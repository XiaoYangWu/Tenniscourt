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
    	 <div><form method=post action="dealSetting.jsp"><table>
    	 <tr><td>预售期:</td><td><input type=text name=presale>天</td></tr>
    	 <tr><td>开始营业时间:</td><td><input type=text name=starttime>:00</td></tr>
    	 <tr><td>营业时长:</td><td><input type=text name=opentimeamount>小时</td></tr>
    	 <tr><td>订单最晚退订时间：</td><td>提前<input type=text name=mintimetounsubscribe>小时</td></tr>
    	 <tr><td>免费开放的日期:</td><td><textarea rows=10 cols=30 name=datefree></textarea></td></tr>
    	 <tr><td><input type=reset value="重填"></td><td><input type=submit value="修改"></td>
         </table></form></div>

</div>
</body>
</html>