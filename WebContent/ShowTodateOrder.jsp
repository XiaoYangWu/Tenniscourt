<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.ConnectDatabase"%>
<%@page import="common.CurrentDateTime"%>
<%@page import="java.util.Calendar"%>
<%@page import="common.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>国际关系学院网球场管理系统</title>
<link href="mycss.css" rel="stylesheet" type="text/css">
</head>
<body background="page1.jpg">
<%
if(session.getAttribute("id")==null)
	response.sendRedirect("index.html");
%>
<table>
<tr id=titleempty><td></td></tr>
</table>
<div class=left>
欢迎你，<%=session.getAttribute("id") %>
</div>
<table>
<tr id=welcomeempty><td></td></tr>
</table>
<div class=left><table>
<tr class="trheight"><td><a href="ShowTodateOrder.jsp">今日订单</a></td></tr>
<tr class="trheight"><td><a href="orderDatePage.jsp">现场预定</a></td></tr>
<tr class="trheight"><td><a href="rechargeForm.jsp">用户充值</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>
<tr class="trheight"><td><a href="UserLogout">退出登录</a></td></tr>
</table></div> 

<div id="bottom" align="center">
<%
ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);

Calendar cc=Calendar.getInstance();
String toDate=CurrentDateTime.calendarDateToString(cc);
rs=stmt.executeQuery("select * from t_orderinfo where date='"+toDate+"'");
int count=0;
Calendar co=(Calendar) cc.clone();
while(rs.next()){
	 co=CurrentDateTime.stringToCalendar(co, rs.getString(5), rs.getString(6));
	 if(co.after(cc)){
		 count++;
	 }
}
Order[] orders=new Order[count];

count=0;

rs.beforeFirst();	
while(rs.next()){
	 co=CurrentDateTime.stringToCalendar(co, rs.getString(5), rs.getString(6));

	 if(co.after(cc)){
		 String number=rs.getString(1);
		 String id=rs.getString(2);
		 String name=rs.getString(3);
		 String court_id=rs.getString(4);
		 String date=rs.getString(5);
		 String time=rs.getString(6);
		 String money=rs.getString(7);
		 String type=rs.getString(8);
	     orders[count]=new Order(number, id, name, court_id, date, time, money, type);
	     count++;
	 }
	 
}


for(int i=0;i<count-1;i++){
	 Order temp=null;
	 for(int j=i+1;j<count;j++){
		 if(!orders[i].CompareTo(orders[j])){
			 temp=orders[i];
			 orders[i]=orders[j];
			 orders[j]=temp;
		 }
	 }
}

out.println("<br><br><br>");
  out.println("<div><table border=1>");
 out.println("<tr><th>订单号</th><th>学号</th><th>姓名</th><th>场地号</th><th>日期</th><th>时间</th><th>金额</th><th>订单类型</th></tr>");
 for(int i=0;i<orders.length;i++){
	 out.println("<tr><td>"+orders[i].number+"</td><td>"+orders[i].id+"</td><td>"+orders[i].name+"</td><td>"+orders[i].court_id+"</td><td>"+orders[i].date+"</td><td>"+orders[i].time+"</td><td>"+orders[i].money+"</td><td>"+orders[i].type+"</td></tr>");
    
 }
 
 
 out.println("</table></div>");


%>

</div>
</body>
</html>