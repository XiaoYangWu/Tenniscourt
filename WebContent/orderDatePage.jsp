<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
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
<br><br><br>
<%

ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);
rs=stmt.executeQuery("select value from courtattr where attr='presale'");
rs.next();
int presale=Integer.parseInt(rs.getString(1));
CurrentDateTime date=new CurrentDateTime();
date.getSpecifiedDate(-1);
out.println("<form method=post action=orderCourtPage.jsp><table>");
if(!"students".equals(type)){
	 out.println("<tr><th>请输入学号:</th><td><input type=text name=orderid></td></tr>");
	 out.println("<tr height=20px><td></td></tr><tr><td></td></tr>");
  }
 
 out.println("<tr><th>请选择日期:</th>");
 out.println("<td>");
 out.println("<select size=1 name=date style='width:100pt'>");
 for(int i=0;i<presale;i++){
	 out.println("<option style='width:100pt' value="+date.getSpecifiedDate(1)+">");
	 out.println(date.getDate());
	 out.println("</option>");
 }
 out.println("</select>");
 out.println("<tr height=20px></tr>");
 out.println("</td></tr><tr><th><input type=submit value=查询></th></tr>");
 out.println("</table></form>");
 if(conn!=null){
		try{
			conn.close();
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		conn=null;
	}
	if(rs!=null){
		try{
			rs.close();
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		rs=null;
	}
	if(stmt!=null){
		try{
			stmt.close();
		}
		catch(SQLException se){
			se.printStackTrace();
		}
		stmt=null;
	}

%>

</div>

</body>
</html>