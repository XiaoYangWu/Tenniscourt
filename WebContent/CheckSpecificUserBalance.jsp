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
<br><br><br>
<div id="bottom" align=center>
<% 
         String id=(String)session.getAttribute("id");
         ConnectDatabase.init(application);
		 Connection conn=null;
		 Statement stmt=null;
		 ResultSet rs=null;
		 stmt=ConnectDatabase.connect(conn);
    	 rs=stmt.executeQuery("select account from students where id='"+id+"'");
    	 rs.next();
    	 String account=rs.getString(1);
%>
    	 <div align="center">
    	 <font>您的账户余额为:<%=account %>元</font>
    	 </div>
    
</div>
</body>
</html>