<%@include file="menu.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sql:setDataSource var="dataSource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
url="jdbc:sqlserver://localhost:1433;databaseName=attendance_system;integratedSecurity=true"
 user="root" password="" />

<!DOCTYPE html>
<html>
    <head>
    	<style>
    	#attendance_table
    	{
			margin-top:3%;
			width:50%;
		}
		#attendance_table tr td
		{
			padding:20px;
		}
		#attendance_table tr:first-child
		{
			background-color:gray;
			color:white;
		}
		#attendance_table tr:nth-child(even)
		{
			background-color:lightgray;
		}  	
    	</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
    </head>
    <body>
        <% 
        
        String sub_name = request.getParameter("subject");
        int sem = Integer.parseInt(request.getParameter("sem"));
        String division = request.getParameter("division");
        String dt = request.getParameter("date");
        int t_id = (Integer)session.getAttribute("teacherid");
        %>
        
        <c:set var="sub" value="<%=sub_name%>" scope="page"/>
          
        <c:set var="semester" value="<%=sem%>" scope="page" />
        <c:set var="DIV" value="<%=division%>" scope="page"/>
        <c:set var="tid" value="<%=t_id%>" scope="page"/>
        <c:set var="date" value="<%=dt%>" scope="page"/>
        <!--fmt:parseDate value="%=dt%" var="date" pattern="yyyy-mm-dd" /-->
        <!--fmt:parseNumber var ="semester" type = "number" value = "%=sem%"/-->
        <h3>Attendance for 
        <% out.print(dt);%>
        </h3>
        <h3>
        Subject:
        <% out.print(sub_name);%>
        </h3>
        <c:catch var ="catchException">
        <sql:query var="result" dataSource="${dataSource}">
        SELECT enrollmentnumber, name, Attendance FROM attendance join master_student 
        on fkenrollmentnumber = enrollmentnumber WHERE Fklectureid IN
         (SELECT Lectureid FROM master_lecture
        WHERE Fkteacherid=${tid} AND fkdivisionid=(SELECT Divisionid FROM master_division WHERE 
        Division='${DIV}' AND Semester=${semester}) AND Fksubjectid IN 
        (SELECT Subjectid FROM master_subject WHERE Subjectname='${sub}')
        AND Date = '${date}' AND enrollmentnumber = enrollmentnumber)
        </sql:query>
        </c:catch>
        
        <c:choose>
              <c:when test = "${catchException != null}">
                  <p> There is an exception: ${catchException.message}</p>
             </c:when>
             <c:when test = "${result.rowCount == 0}">
             <p>Data Unavailable</p>
             </c:when>
             <c:otherwise>
                <table  id="attendance_table" align="center" style="vertical-align:middle" cellspacing="0" cellpadding="0">
                     <tr>
                          <td>Enrollment Number</td>
                          <td>Name</td>
                          <td>Attendance</td>
                           <td>Edit</td>
                      </tr>
                 <c:forEach var="table" items="${result.rows}">
                     <tr>
                           <td align="center"><c:out value="${table.enrollmentnumber}"/></td>
                            <td align="center"><c:out value="${table.name}"/></td>
                            <td align="center">
                                <!--c:if test=${table.Attendance eq true} --><!--c:out value="Present"/--><!--/c:if-->
                                <!--c:if test=${table.Attendance eq false} --><!--c:out value="Absent"/--><!--/c:if-->
                                <c:out value="${table.Attendance}"/>
                            </td>
                            <td align="center"><a href="edit.jsp?id=${table.enrollmentnumber}&dt=${date}">Edit</a></td>  
                        </tr>
                 </c:forEach>
                </table>
             </c:otherwise>
    </c:choose>
    </body>
</html>
