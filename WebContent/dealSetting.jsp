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
<tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>
<tr class="trheight"><td><a href="checkUser.jsp">查看用户信息</a></td></tr>
<tr class="trheight"><td><a href="showSettingPage.jsp">设置</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
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
  String presale=request.getParameter("presale");
	 String startTime=request.getParameter("starttime")+":00";
	 String openTimeAmount=request.getParameter("opentimeamount");
	 String minTimeToUnsubscribe=request.getParameter("mintimetounsubscribe");
	 String dateFree=request.getParameter("datefree");
	 if(!"".equals(presale)){
	      stmt.executeUpdate("UPDATE courtattr SET value='"+presale+"' WHERE attr='presale'");
	 }
	 if(!"".equals(startTime)){
	      stmt.executeUpdate("UPDATE courtattr SET value='"+startTime+"' WHERE attr='starttime'");
	 }
	 if(!"".equals(openTimeAmount)){
	      stmt.executeUpdate("UPDATE courtattr SET value='"+openTimeAmount+"' WHERE attr='opentimeamount'");
	 }
	 if(!"".equals(minTimeToUnsubscribe)){
	      stmt.executeUpdate("UPDATE courtattr SET value='"+minTimeToUnsubscribe+"' WHERE attr='MinTime-To-Unsubscribe(h)'");
	 }
	 if(!"".equals(dateFree)){
	      stmt.executeUpdate("UPDATE courtattr SET value='"+dateFree+"' WHERE attr='date-free-period'");
	 }
%>
    <div align="center">
    <font>设置成功！</font>
    </div>


</div>
</body>
</html>