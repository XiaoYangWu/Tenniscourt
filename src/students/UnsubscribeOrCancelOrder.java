package students;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.ConnectDatabase;

/**
 * Servlet implementation class UnsubscribeOrCancelOrder
 */
@WebServlet("/UnsubscribeOrCancelOrder")
public class UnsubscribeOrCancelOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UnsubscribeOrCancelOrder() {
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
		ConnectDatabase.init(getServletContext());
		Connection conn=null;
		Statement stmt=null;
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		ResultSet rs=null;
	//	stmt=ConnectDatabase.connect(conn);
		  HttpSession session=request.getSession();
    	  String id=(String)session.getAttribute("id");
    	  String []unsubscribeOrder=request.getParameterValues("unsubscribe");
    	  String []cancelOrder=request.getParameterValues("cancelrecord");
    	  
    	  String url=ConnectDatabase.getUrl();
 		 String user=ConnectDatabase.getUser();
 		 String password=ConnectDatabase.getPassword();
    	  try {
			conn=DriverManager.getConnection(url, user, password);
		
 		 conn.setAutoCommit(false);
 	     stmt=conn.createStatement();
    	  pstmt=conn.prepareStatement("DELETE FROM s_orderinfo WHERE number=?");
    	  if(cancelOrder!=null){
    	     for(int i=0;i<cancelOrder.length;i++){
    		 pstmt.setString(1,cancelOrder[i]);
    		  pstmt.executeUpdate();
    	     }
    	  }
    	  if(unsubscribeOrder!=null){
    	  pstmt2=conn.prepareStatement("DELETE FROM m_orderinfo WHERE number=?");
    	  pstmt3=conn.prepareStatement("DELETE FROM t_orderinfo WHERE number=?");
    	  for(int i=0;i<unsubscribeOrder.length;i++){
    		  rs=stmt.executeQuery("select money from t_orderinfo where number='"+unsubscribeOrder[i]+"'");
    		  rs.next();
    		  int money=Integer.parseInt(rs.getString(1));
    		  if(money!=0){
    		     rs=stmt.executeQuery("select account from students where id='"+id+"'");
    		     rs.next();
    		     int account=Integer.parseInt(rs.getString(1));
    		     String nowAccount=(money+account)+"";
    		 
    			 stmt.executeUpdate("UPDATE students SET account='"+nowAccount+"' WHERE id='"+id+"'");
    		  }
    		  pstmt.setString(1,unsubscribeOrder[i]);
    		  pstmt2.setString(1,unsubscribeOrder[i]);
    		  pstmt3.setString(1,unsubscribeOrder[i]);
    		  pstmt.executeUpdate();
    		  pstmt2.executeUpdate();
    		  pstmt3.executeUpdate();
    		  
     	  }
    	  }
    	  conn.commit();
    	  response.sendRedirect(response.encodeRedirectUrl("ShowSpecificUserOrder.jsp"));
    	  }
    	  catch(SQLException se)
   	    {
   		   if(conn!=null)
   		   {
   		      try{
   		    	  conn.rollback();
   		    	  
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
  	    	if(pstmt2!=null){
  	    		try{
  	    			pstmt2.close();
  	    		}
  	    		catch(SQLException se){
  	    			se.printStackTrace();
  	    		}
  	    		pstmt2=null;
  	    	}
  	    	if(pstmt3!=null){
  	    		try{
  	    			pstmt3.close();
  	    		}
  	    		catch(SQLException se){
  	    			se.printStackTrace();
  	    		}
  	    		pstmt3=null;
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
	}

}
