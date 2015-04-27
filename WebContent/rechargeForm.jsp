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
<br><br><br>
<div id="bottom" align="center">
       <br><br><br>
  	   <form method=post action="doRecharge.jsp">
  	   <table>
  	   <caption>用户充值</caption>
  	   <tr height =20px></tr>
  	   <tr><td>学号:</td><td><input type=text name=id></td>
  	   <tr height=20px></tr>
  	   <tr><td>金额:</td><td><input type=text name=money></td><td>元</td>
  	   <tr height=20px></tr>
  	   </table>
  	   <table>
  	   <tr><th><input type=reset value=重填></th><td width=15px></td><th><input type=submit value=充值></th>
  	   </table>
  	   </form>


</div>
</body>
</html>