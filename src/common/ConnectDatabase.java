package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.UnavailableException;


public class ConnectDatabase {
	 private static String url;
	 private static String user;
	 private static String password;
	 public static String getUrl(){
		 return url;
	 }
	 public static String getUser(){
		 return user;
	 }
	 public static String getPassword(){
		 return password;
	 }
	 public static void init(ServletContext sc) throws UnavailableException{
           
	        String driverClass=sc.getInitParameter("driverClass");
			url=sc.getInitParameter("url");
			user=sc.getInitParameter("user");
			password=sc.getInitParameter("password");
			try{
				Class.forName(driverClass);
			}
			catch(ClassNotFoundException ce){
				throw new UnavailableException("加载数据库驱动失败");
			}
	 }
	 public static Statement connect(Connection conn){
		 Statement stmt = null; 
		 try{
			conn=DriverManager.getConnection(url,user,password);
	        stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	        
	     }
		 catch(SQLException se){se.printStackTrace();}
		 finally{
			 return stmt;
		 }
		
	 }
	 public static Statement connect(Connection conn,boolean bool){
		 Statement stmt = null; 
		 try{
			conn=DriverManager.getConnection(url,user,password);
			conn.setAutoCommit(bool);
	        stmt=conn.createStatement();
	        
	     }
		 catch(SQLException se){se.printStackTrace();}
		 finally{
			 return stmt;
		 }
		
	 }
}
