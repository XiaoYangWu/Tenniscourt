<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
PreparedStatement pstmt=null;
PreparedStatement pstmt2=null;
PreparedStatement pstmt3=null;
ResultSet rs=null;
stmt=ConnectDatabase.connect(conn);
String date=(String)session.getAttribute("date");
String id=(String)session.getAttribute("id");
String name=(String)session.getAttribute("name");
String orderType="网上订场";
// out.println(date+id+name+type+"<br>");
try{
if(!("students".equals(type))){
	 id=(String)session.getAttribute("orderid");
	 rs=stmt.executeQuery("select name from students where id='"+id+"'");
	 rs.next();
	 name=rs.getString(1);
	 orderType="现场订场";
}
// out.println(id);
Calendar cc=Calendar.getInstance();

String []temp=date.split("-");

cc.set(Integer.parseInt(temp[0]),(Integer.parseInt(temp[1])-1),Integer.parseInt(temp[2]));
//cc.set(Calendar.YEAR, Integer.parseInt(temp[0]));
//cc.set(Calendar.MONTH, Integer.parseInt(temp[1]));
// cc.set(Calendar.DATE, Integer.parseInt(temp[2]));
int dayOfWeek=cc.get(Calendar.DAY_OF_WEEK);
String week=CurrentDateTime.intDayOfWeekToString(dayOfWeek);
//out.println(week);

String url=ConnectDatabase.getUrl();
String user=ConnectDatabase.getUser();
String password=ConnectDatabase.getPassword();
conn=DriverManager.getConnection(url, user, password);
conn.setAutoCommit(false);
stmt=conn.createStatement();


rs=stmt.executeQuery("select value from courtattr where attr='date-free-period'");
rs.next();
String datesFree=rs.getString(1);
// out.println(datesFree+"<br>");
boolean charge=true;

if(datesFree!=null){
	 String[] freeDate=CurrentDateTime.datesStringToArray(datesFree);
	 for(int i=0;i<freeDate.length;i++){
		 if(date.equals(freeDate[i]))
		 {
			 charge=false;
			 break;
		 }
	 }
}

// out.println(charge);





String[] timePeriod=request.getParameterValues("timeperiod");

//out.println(timePeriod[0]);

pstmt=conn.prepareStatement("INSERT INTO t_orderinfo (id,name,court_id,date,time,money,type) VALUES (?,?,?,?,?,?,?)");
pstmt2=conn.prepareStatement("INSERT INTO s_orderinfo (id,name,court_id,date,time,money,type) VALUES (?,?,?,?,?,?,?)");
pstmt3=conn.prepareStatement("INSERT INTO m_orderinfo (id,name,court_id,date,time,money,type) VALUES (?,?,?,?,?,?,?)");
rs=stmt.executeQuery("select account from students where id='"+id+"'");
rs.next();
String account=rs.getString(1);

// out.println(account);
//out.println(timePeriod.length);


int totalPrice=0;
ArrayList<String> court_ids=new ArrayList<String>();
ArrayList<String> timeperiods=new ArrayList<String>();
ArrayList<String> prices=new ArrayList<String>();
for(int i=0;i<timePeriod.length;i++){
	 String []temp1=timePeriod[i].split("00");
	 
	// out.println(temp1[0]+"..."+temp1[1]);
	 
    court_ids.add(temp1[0]+"号场");
    timeperiods.add(temp1[1]);
    String price=null;
    if(charge==false){
   	 price=0+"";
    }
    else
    {
   	// out.println(week);
   	 
   	 rs=stmt.executeQuery("select "+week+" from price where time='"+temp1[1]+":00-"+(Integer.parseInt(temp1[1])+1)+":00'");
   	 rs.next();
   	 price=rs.getString(1);
    }
    prices.add(price);
    totalPrice+=Integer.parseInt(price);
 }
if("students".equals(type)){
  if(totalPrice>Integer.parseInt(account))
	   out.println("您的余额不足,请续费！");
  else{
	   for(int i=0;i<timePeriod.length;i++){
		   String court_id=court_ids.get(i);
	       String timeperiod=timeperiods.get(i)+":00-"+(Integer.parseInt(timeperiods.get(i))+1)+":00";
	       String price=prices.get(i);
	      
	        pstmt.setString(1,id);
       	 pstmt.setString(2,name);
       	 pstmt.setString(3,court_id);
       	 pstmt.setString(4,date);
       	 pstmt.setString(5,timeperiod);
       	 pstmt.setString(6,price);
       	 pstmt.setString(7,orderType);
       	 pstmt.executeUpdate();
       	
       	 pstmt2.setString(1,id);
       	 pstmt2.setString(2,name);
       	 pstmt2.setString(3,court_id);
       	 pstmt2.setString(4,date);
       	 pstmt2.setString(5,timeperiod);
       	 pstmt2.setString(6,price);
       	 pstmt2.setString(7,orderType);
       	 pstmt2.executeUpdate();
       	 
       	 pstmt3.setString(1,id);
       	 pstmt3.setString(2,name);
       	 pstmt3.setString(3,court_id);
       	 pstmt3.setString(4,date);
       	 pstmt3.setString(5,timeperiod);
       	 pstmt3.setString(6,price);
       	 pstmt3.setString(7,orderType);
       	 pstmt3.executeUpdate();
       }
	        String remainPrice=(Integer.parseInt(account)-totalPrice)+"";
	        stmt.executeUpdate("UPDATE students SET account='"+remainPrice+"' WHERE id='"+id+"'");
	        conn.commit();
	        out.println("订场成功！");
	 }
}
else{
	 for(int i=0;i<timePeriod.length;i++){
		   String court_id=court_ids.get(i);
	       String timeperiod=timeperiods.get(i)+":00-"+(Integer.parseInt(timeperiods.get(i))+1)+":00";
	       String price=prices.get(i);
	       pstmt.setString(1,id);
       	 pstmt.setString(2,name);
       	 pstmt.setString(3,court_id);
       	 pstmt.setString(4,date);
       	 pstmt.setString(5,timeperiod);
       	 pstmt.setString(6,price);
       	 pstmt.setString(7,orderType);
       	 pstmt.executeUpdate();
       	 
       	 pstmt2.setString(1,id);
       	 pstmt2.setString(2,name);
       	 pstmt2.setString(3,court_id);
       	 pstmt2.setString(4,date);
       	 pstmt2.setString(5,timeperiod);
       	 pstmt2.setString(6,price);
       	 pstmt2.setString(7,orderType);
       	 pstmt2.executeUpdate();
       	 
       	 pstmt3.setString(1,id);
       	 pstmt3.setString(2,name);
       	 pstmt3.setString(3,court_id);
       	 pstmt3.setString(4,date);
       	 pstmt3.setString(5,timeperiod);
       	 pstmt3.setString(6,price);
       	 pstmt3.setString(7,orderType);
       	 pstmt3.executeUpdate();
       }
	 conn.commit();
	   out.println("订场成功！总金额为"+totalPrice+"元");
}


}
catch(SQLException se)
{
   if(conn!=null)
   {
      try{
    	  conn.rollback();
    	  out.println("订场失败!");
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