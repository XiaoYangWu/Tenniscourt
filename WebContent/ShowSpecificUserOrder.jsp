<%@page import="common.CurrentDateTime"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.ConnectDatabase"%>
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
if(session.getAttribute("name")==null)
	response.sendRedirect("index.html");
%>
<table>
<tr id=titleempty><td></td></tr>
</table>
<div class=left>
欢迎你，<%=session.getAttribute("name") %>
</div>
<table>
<tr id=welcomeempty><td></td></tr>
</table>
<div class=left><table>
<tr class="trheight"><td><a href="orderDatePage.jsp">订阅场地</a></td></tr>
<tr class="trheight"><td><a href="CheckSpecificUserBalance.jsp">查询账户余额</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="ShowSpecificUserOrder.jsp">查看订单</a></td></tr>
<tr class="trheight"><td><a href="courtSituation.jsp">网球场概况</a></td></tr>
<tr class="trheight"><td><a href="UserLogout">退出登录</a></td></tr>
</table></div> 
<div id="bottom" align="center">
<%
ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);
 Calendar toDate=Calendar.getInstance();
Calendar orderDate=(Calendar) toDate.clone();
String id=(String)session.getAttribute("id");
rs=stmt.executeQuery("select value from courtattr where attr='MinTime-To-Unsubscribe(h)'");
rs.next();
int minTimeToUnsubscribe=Integer.parseInt(rs.getString(1))*60*60*1000;

out.println("<br><br>");

rs=stmt.executeQuery("select * from s_orderinfo where id='"+id+"'");

if(!rs.next())
	  out.println("您还没有订单");
	  
else{
rs.last();

	  

out.println("<div><form method=post action="+response.encodeURL("UnsubscribeOrCancelOrder")+"><table border=1>");
out.println("<tr><th>订单号</th><th>学号</th><th>姓名</th><th>场地号</th><th>日期</th><th>时间</th><th>金额</th><th>订单类型</th><th>操作</th></tr>");
while(!rs.isBeforeFirst()){
	 out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td>");
   orderDate=CurrentDateTime.stringToCalendar(orderDate, rs.getString(5), rs.getString(6));
  
   long remainingTime=orderDate.getTimeInMillis()-toDate.getTimeInMillis();
  
   if(remainingTime>minTimeToUnsubscribe)
  	 out.println("<td>取消订单:<input type=checkbox name=unsubscribe value='"+rs.getString(1)+"'></td>");
   else
  	 out.println("<td>删除记录:<input type=checkbox name=cancelrecord value='"+rs.getString(1)+"'></td>");
   
   out.println("</tr>");
   rs.previous();
}
out.println("<tr><td colspan=9 align=center><input type=reset value=重选>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=submit value=确定></td>");

out.println("</table></form></div>");
}

%>

</div>
</body>
</html>