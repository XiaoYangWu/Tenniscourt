<%@page import="common.CurrentDateTime"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
<tr class="trheight"><td><a href="ShowTodateOrder.jsp">今日订单</a></td></tr>
<tr class="trheight"><td><a href="orderDatePage.jsp">现场预定</a></td></tr>
<tr class="trheight"><td><a href="rechargeForm.jsp">用户充值</a></td></tr>
<tr class="trheight"><td><a href="modifyPassword.jsp">修改密码</a></td></tr>
<tr class="trheight"><td><a href="checkTotalIncome.jsp">账单核对</a></td></tr>
<tr class="trheight"><td><a href="UserLogout">退出登录</a></td></tr>
</table></div> 
<br><br><br>
<div id="bottom" align="center">
<%
ConnectDatabase.init(application);
Connection conn=null;
Statement stmt=null;
PreparedStatement pstmt=null;
PreparedStatement pstmt2=null;
ResultSet rs=null;


String id=request.getParameter("id");
String money=request.getParameter("money");
out.println("<br><br><br><br>");
try{
	 String url=ConnectDatabase.getUrl();
	 String user=ConnectDatabase.getUser();
	 String password=ConnectDatabase.getPassword();
	 conn=DriverManager.getConnection(url, user, password);
	 conn.setAutoCommit(false);
    stmt=conn.createStatement();
	 pstmt=conn.prepareStatement("INSERT INTO recharge (id,name,recharge,account,date,time) VALUES (?,?,?,?,?,?)");
	 pstmt2=conn.prepareStatement("INSERT INTO m_recharge (id,name,recharge,account,date,time) VALUES (?,?,?,?,?,?)");
	 rs=stmt.executeQuery("select name,account from students where id='"+id+"'");
	 rs.next();
	 
	 String name=rs.getString(1);
	 String account=rs.getString(2);
	 account=Integer.toString(Integer.parseInt(account)+Integer.parseInt(money));
	 stmt.executeUpdate("UPDATE students SET account='"+account+"' WHERE id='"+id+"'");
	 
	 String date=new CurrentDateTime().getDate();
	 String time=new CurrentDateTime().getTime();
	 pstmt.setString(1,id);
	 pstmt.setString(2,name);
	 pstmt.setString(3,money);
	 pstmt.setString(4,account);
	 pstmt.setString(5,date);
	 pstmt.setString(6,time);
	 pstmt.executeUpdate();
	 pstmt2.setString(1,id);
	 pstmt2.setString(2,name);
	 pstmt2.setString(3,money);
	 pstmt2.setString(4,account);
	 pstmt2.setString(5,date);
	 pstmt2.setString(6,time);
	 pstmt2.executeUpdate();
	 conn.commit();
	 out.println("充值成功!");
	 out.println(name+",你的账户余额为"+account+"元");
    }
   catch(SQLException se)
   {
	   if(conn!=null)
	   {
	      try{
	    	  conn.rollback();
	    	  out.println("充值失败,请重新充值!");
	      }
	      catch(SQLException sex)
	      {
	    	  sex.printStackTrace();
	      }
		   
      }
	   se.printStackTrace();
   }
  finally
  {
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
  	if(pstmt!=null){
  		try{
  			pstmt.close();
  		}
  		catch(SQLException se){
  			se.printStackTrace();
  		}
  		pstmt=null;
  	}
  	if(conn!=null){
  		try{
  			conn.close();
  		}
  		catch(SQLException se){
  			se.printStackTrace();
  		}
  		conn=null;
  	}
  }


%>

</div>
</body>
</html>