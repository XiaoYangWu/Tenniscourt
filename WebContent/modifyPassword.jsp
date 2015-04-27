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
   else if("manager".equals(type)){ 
%>
<tr class="trheight"><td><a href="ShowTodateOrder.jsp">今日订单</a></td></tr>
<tr class="trheight"><td><a href="orderDatePage.jsp">现场预定</a></td></tr>
<tr class="trheight"><td><a href="rechargeForm.jsp">用户充值</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>

<%
   }
   else{
%>   
   <tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>
<tr class="trheight"><td><a href="checkUser.jsp">查看用户信息</a></td></tr>
<tr class="trheight"><td><a href="showSettingPage.jsp">设置</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>

<%
   }
%>
    <tr class="trheight"><td><a href="UserLogout">退出登录</a></td></tr>
</table></div> 
<br><br><br>
<div id="bottom" align="center">
<form action="doModifyPassword" method="post">
		<table>
			<tr>
				<td width=20px></td>
				<td>请输入原来的密码：</td>
				<td>
				  <input type="password" name="oldPassword">
				</td>
			</tr>
			<br><br>
			<tr height=20></tr>
			<tr>
				<td width=20px></td>
				<td>请输入新密码:</td>
				<td>
					<input type="password" name="newPassword"></td>
			</tr>
			<tr height=20></tr>
			<tr>
			<tr>
				<td width=20px></td>
				<td>请重复新密码:</td>
				<td>
					<input type="password" name="repetePassword"></td>
           </tr>
          <tr height=20></tr>
			<tr>
				<td width=20px></td>
				<td>
					<input type="submit" value="确认修改"></td>
				<td>
					<input type="reset" value="重新输入"></td>
					
			</tr>
			<%
				String cause=request.getParameter("cause");
				if(cause!=null){
					out.println("<tr>"); 
					out.println("<td width=20px></td>"); 
					if("different".equals(cause))
				        out.println("<td>两次密码不一样！</td>"); 
					else
				        out.println("<td>密码输入错误！</td>"); 
					out.println("</tr>"); 
				}
			%>
			</table>
			</form>
			</div>
			
			</body>
			</html>
			