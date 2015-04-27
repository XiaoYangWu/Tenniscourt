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
<div class=left>
<table>
<%
String type=(String)session.getAttribute("type");
if("manager".equals(type)){ 
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
<%

ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);
rs=stmt.executeQuery("select * from m_orderinfo");
int totalIncome=0;
out.println("<br><br><br>");
out.println("<div><table border=1><caption>订单表</caption>");
   out.println("<tr><th>订单号</th><th>学号</th><th>姓名</th><th>场地号</th><th>日期</th><th>时间</th><th>金额</th><th>订单类型</th></tr>");
while(rs.next()){
	 out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td></tr>");
    String order_type=rs.getString(8);
    if("现场订场".equals(order_type)){
   	 String money=rs.getString(7);
   	 totalIncome+=Integer.parseInt(money);
    }
}
out.println("</table></div>");

rs=stmt.executeQuery("select * from m_recharge");
out.println("<br><br><br>");
out.println("<div><table border=1><caption>充值表</caption>");
   out.println("<tr><th>订单号</th><th>学号</th><th>姓名</th><th>充值金额</th><th>用户余额</th><th>日期</th><th>时间</th></tr>");
while(rs.next()){
	 out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td></tr>");
    String money=rs.getString(4);
    totalIncome+=Integer.parseInt(money);
    
}
out.println("</table></div>");

out.println("<br><br>");
out.println("您这一阶段的总收入为"+totalIncome+"元！");

if("supermanager".equals(type)){
	 out.println("<form method=post action=ResetTotalIncome.jsp>");
	 out.println("<input type=submit value=重置>");
	 out.println("</form>");
}



%>


</div>
</body>
</html>