<%@page import="common.Court"%>
<%@page import="common.CourtSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.ConnectDatabase"%>
<%@page import="common.CurrentDateTime"%>
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
欢迎你，<% 
        String type=(String)session.getAttribute("type");
        if("students".equals(type))
        	out.println(session.getAttribute("name"));
        else
        	out.println(session.getAttribute("id"));
      %>
</div>
<table>
<tr id=welcomeempty><td></td></tr>
</table>
<div class=left><table>

<%

if("students".equals(type)){

%>

<tr class="trheight"><td><a href="orderDatePage.jsp">订阅场地</a></td></tr>
<tr class="trheight"><td><a href="CheckSpecificUserBalance.jsp">查询账户余额</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="ShowSpecificUserOrder.jsp">查看订单</a></td></tr>
<tr class="trheight"><td><a href="courtSituation.jsp">网球场概况</a></td></tr>


<%
 }
   else { 
%>
<tr class="trheight"><td><a href="ShowTodateOrder.jsp">今日订单</a></td></tr>
<tr class="trheight"><td><a href="orderDatePage.jsp">现场预定</a></td></tr>
<tr class="trheight"><td><a href="rechargeForm.jsp">用户充值</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>

<%
   }
%>
    <tr class="trheight"><td><a href="UserLogout">退出登录</a></td></tr>
</table></div> 
<br><br><br>

<div id="bottom" align="center">

<%
ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);
CurrentDateTime datetime=new CurrentDateTime();
String date=request.getParameter("date");
session.setAttribute("date", date);
String orderid=null;
boolean isToday=false;
isToday=datetime.isToday(date);
if(!"students".equals(type))
 {
	   orderid=request.getParameter("orderid");
	   session.setAttribute("orderid",orderid);
 }

 rs=stmt.executeQuery("select name from students where id='"+orderid+"'");
 
 if(!rs.next()&&orderid!=null){
	 out.println("<br><br><br>学号输入错误,没有这个用户,请重新订场！");
 }
else{
String startTime=null;
String openTimeAmount=null;
rs=stmt.executeQuery("select value from courtattr where attr='starttime'");
rs.next();
startTime=rs.getString(1);
rs=stmt.executeQuery("select value from courtattr where attr='opentimeamount'");
rs.next();
openTimeAmount=rs.getString(1);
CourtSet courtset=CourtSet.getInstance(startTime,Integer.parseInt(openTimeAmount));
Court court=null;
rs=stmt.executeQuery("select court_id,time from t_orderinfo where date='"+date+"'");
String court_id=null;
String time=null;
int intStartTime=CurrentDateTime.timeStringToInt(startTime);
while(rs.next()){
	 court_id=rs.getString(1);
	 time=rs.getString(2);
	 int intTime[]=CurrentDateTime.timePeriodToInt(time);
	 if("1号场".equals(court_id))
		 court=courtset.getCourt(1);
	 else if("2号场".equals(court_id))
		 court=courtset.getCourt(2);
	 else if("3号场".equals(court_id))
		 court=courtset.getCourt(3);
	 else if("4号场".equals(court_id))
		 court=courtset.getCourt(4);
	 int index=intTime[0]-intStartTime;

	 court.getTimePeriod().setPeriod(index,false);
 }


out.println("<br><br><br>");
out.println("<div>");
out.println("<form method=post action=orderPay.jsp><table border=1 align=center><caption><font size=5 color=black>余场信息</font></caption>");
out.println("<tr><th>1号场</th><th>2号场</th><th>3号场</th><th>4号场</th></tr>");
out.println("<tr>");
for(int i=1;i<=4;i++){
	 out.println("<td>");
	 court=courtset.getCourt(i);
	 int startindex;
	 if(isToday){
	    int nowHour=datetime.getCurrentHour();
	    startindex=nowHour-intStartTime+1;
	    if(startindex<0)
	    	startindex=0;
	 }
	 else{
		 startindex=0;
	 }
	 for(int j=startindex;j<court.getOpenTimeAmount();j++){
		    if(court.getTimePeriod().getPeriod(j)){
			  String timeperiod=CurrentDateTime.intPeriodToString(intStartTime,j+1);
			  out.println(timeperiod);
			  int simplifyStartTime=intStartTime+j;
			  out.println("<input type=checkbox name=timeperiod value="+court.getIndex()+"00"+simplifyStartTime+">");
			  out.println("<br>");
		    }
			 
	    }
	 out.println("</td>");
}
out.println("</tr>");
out.println("<tr><th colspan=2><input type=reset value=重选></th><th colspan=2><input type=submit value=预订></th></tr>");
out.println("</table></form></div>");
}


%>

</div>

</body>
</html>