package common;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class doModifyPassword
 */
@WebServlet("/doModifyPassword")
public class doModifyPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public doModifyPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	   doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    String oldPassword=request.getParameter("oldPassword");
	    String newPassword=request.getParameter("newPassword");
	    String repetePassword=request.getParameter("repetePassword");
	    if(null==oldPassword||null==newPassword||null==repetePassword){
	    	response.sendRedirect("index.html");
	    	return;
	    }
        if(!newPassword.equals(repetePassword))
        {
        	response.sendRedirect("modifyPassword.jsp?cause=different");
        	return;
        }
       HttpSession session=request.getSession();
       String realPassword=(String)session.getAttribute("password");
       if(null==realPassword)
       {
    	   response.sendRedirect("index.jsp");
    	   return;
       }
        if(!realPassword.equals(oldPassword))
        {
        	response.sendRedirect("modifyPassword.jsp?cause=error");
        	return;
        }
        
        ServletContext sc=getServletContext();
		ConnectDatabase.init(sc);
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		stmt=ConnectDatabase.connect(conn);
		String id=(String)session.getAttribute("id");
		String type=(String)session.getAttribute("type");
		try{
			if("students".equals(type))
		       stmt.executeUpdate("UPDATE students SET password='"+newPassword+"' WHERE id='"+id+"'");
			else 
			   stmt.executeUpdate("UPDATE admin SET password='"+newPassword+"' WHERE id='"+id+"'");
			   session.setAttribute("password",newPassword);
			if("students".equals(type))
			{
				response.sendRedirect("modifyPasswordSuccessfullyStudents.jsp");
				return;
			}
		    else if("manager".equals(type))
		    {
		    	response.sendRedirect("modifyPasswordSuccessfullyManager.jsp");
		    	return;
		    }
		    else
		    {
		    	response.sendRedirect("modifyPasswordSuccessfullySuperManager.jsp");
		    	return;
		    }
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally{
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
	    	
		}
	}

}
