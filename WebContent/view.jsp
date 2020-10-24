<%@include file="menu.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
url="jdbc:sqlserver://localhost:1433;databaseName=attendance_system;integratedSecurity=true" user="root" password="" />
<sql:query var="subjects" dataSource="${dataSource}">
    SELECT Subjectname FROM master_subject
</sql:query>
<!DOCTYPE html>
<html>
    <head>
    <style>
    	.btn
		{
			background-color:gray;
			border-radius:5px;
			font-size:18px;
			color:white;
		}
		.btn:hover
		{
			cursor:pointer;
		}
		#view
		{
			margin-left:38%;
		}
    	</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
    </head>
    <body>
        
        <form action="view_process.jsp" method="GET">
        	<table id="view" cellpadding="10">
        	<tr>
        	<td colspan="2"><h3>View Attendance By Class</h3></td>
        	</tr>
        	<tr>
        	<td>Subject name:</td>
        	<td><select name="subject">
               
                <c:forEach var="sub" items="${subjects.rows}">
                <option value="${sub.Subjectname}">${sub.Subjectname}</option>
                </c:forEach>
            </select></td>
            </tr>
            <tr>
            <td>
            Semester:
            </td>
            <td>
            <select name="sem">
                <c:forEach var="j" begin="1" end="8">
                <option value="${j}">${j}</option>
                </c:forEach>
                
            </select>
            </td>
            </tr>
             <tr>
            <td>
            Division:
            </td>
            <td>
            <select name="division">
                <option value="A">A</option>
                <option value="B">B</option>
            </select>
            </td>
            </tr>
             <tr>
            <td>
            Date:
            </td>
            <td>
            <input type="date" value="2020-04-01" name="date">
            </td>
            </tr>
        	<tr>
        	<td colspan="2"><input class="btn" type="submit" value="Show Attendance"></td>
        	</tr>
        	</table>            
        </form>
    </body>
</html>
