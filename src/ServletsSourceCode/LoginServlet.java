package ServletsSourceCode;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try
        {
        	 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
             Connection connection = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=attendance_system;integratedSecurity=true");
       	  
             Statement st = connection.createStatement();
             String username = request.getParameter("username");
             String password = request.getParameter("password");
             String query = "select * from master_teacher where username='"+username+"' and password='"+password+"'";
             ResultSet rs = st.executeQuery(query);
             if(!rs.next())
             {
            	 out.println("<script>alert('No user with given username and password found')</script>");
            	 request.getRequestDispatcher("index.html").include(request,response); 	
             }
             else
             {
            	 //forward request to home.jsp
            	 request.setAttribute("username",username);
            	 HttpSession session = request.getSession();
            	 session.setAttribute("username",username);
            	 session.setAttribute("teacherid",rs.getInt("teacherid"));
            	 response.sendRedirect("home.jsp");
             }
             
             
        }
        catch(Exception e)
        {
        	out.println("Exception is : "+e);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
