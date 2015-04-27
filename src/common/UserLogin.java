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
 * Servlet implementation class UserLogin
 */
@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogin() {
        super();
        // TODO Auto-generated constructor stub
    }
    public void init() throws ServletException{
		 ServletContext sc=getServletContext();
		 ConnectDatabase.init(sc);
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
		String type=request.getParameter("usertype");
		String name=request.getParameter("user");
    	String pwd=request.getParameter("passwd");
    	if(null==type||null==name||null==pwd)
    		response.sendRedirect("index.html?status=again");
    	else
    	   vertifyAndAssign(type,name,pwd,request,response);
	}
    
	private void vertifyAndAssign(String type,String name, String pwd, HttpServletRequest 

request,
			HttpServletResponse response ) throws IOException{
		// TODO Auto-generated method stub
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
		stmt=ConnectDatabase.connect(conn);
    	if("students".equals(type))
    	   rs=stmt.executeQuery("select id,password,name from students where id='"+name+"'");
    	else 
    		rs=stmt.executeQuery("select * from admin where id='"+name+"'");
    	if(!rs.next()){
    		response.sendRedirect("index.html?status=again");
    		return;
    	}
    	
    	if(pwd.equals(rs.getString(2))){
    		
    	    if("students".equals(type))
    	    {
    	      HttpSession session=request.getSession();
    	      session.setAttribute("id", name);
    	      session.setAttribute("type",type);
    	      session.setAttribute("name",rs.getString(3));
    	      session.setAttribute("password",pwd);
    		  response.sendRedirect(response.encodeRedirectURL("students.jsp"));
    	    }
    	    else if("manager".equals(type)){
    	    	if(type.equals(rs.getString(3))){
    	    		HttpSession session=request.getSession();
    	    		 session.setAttribute("id", name);
    	    		 session.setAttribute("type",type);
    	    		 session.setAttribute("password",pwd);
    	    		response.sendRedirect(response.encodeRedirectURL("manager.jsp"));
    	    	}
    	    	else
    	    		response.sendRedirect("index.html?status=again");
    	    }
    	    else{
    	    	if(type.equals(rs.getString(3))){
    	    		HttpSession session=request.getSession();
    	    		session.setAttribute("id",name);
    	    		 session.setAttribute("type",type);
    	    		 session.setAttribute("password",pwd);
    	    		response.sendRedirect(response.encodeRedirectURL("supermanager.jsp"));
    	    	}
    	    	else
    	    		response.sendRedirect("index.html?status=again");
    	    }
    	}
    	else{
    		response.sendRedirect("index.html?status=again");
    	}
	}
	catch(SQLException e){
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
