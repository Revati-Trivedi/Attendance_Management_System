<%@include file="menu.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver" 
url="jdbc:sqlserver://localhost:1433;databaseName=attendance_system;integratedSecurity=true"
user="root" password="" />
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
		#edit
		{
			margin-left:38%;
		}
    	</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Attendance</title>
    </head>
    <body>
        
        <%
        Long id;
        if(request.getParameter("id")==null)
        {
        	id=null;
        }
        else 
        { 
        	id=Long.parseLong(request.getParameter("id"));
        	
        
        
        }
           String date = request.getParameter("dt");
           
        %>
        <form action="edit_process.jsp" method="POST" onsubmit="return validation();">
        	
        	<table id="edit" cellpadding="10">
        	<tr>
        		<td colspan="2" align="center"><h3>Edit Attendance </h3></td>	
        	</tr>
        	<tr>
        		<td>Enrollment Number*</td>
        		<td><input type="number" required name="enroll" value="<%=id%>"></td>
        	</tr>
        	<tr>
        		<td>Subject name*</td>
        		<td>
        			<select name="subject"  id="subject">
        			    <option value="-1">---SELECT---</option>
                  		<c:forEach var="sub" items="${subjects.rows}">
                		<option value="${sub.Subjectname}">${sub.Subjectname}</option>
                		</c:forEach>
            		</select>
        		</td>
        	</tr>
        	<tr>
        		<td>Semester*</td>
        		<td>
        			<select name="sem" id="sem">
        				<option value="-1">---SELECT---</option>
                		<c:forEach var="j" begin="1" end="8">
                			<option value="${j}">${j}</option>
                		</c:forEach>
                     </select>
                </td>
            </tr>
            <tr>
            	<td>Division*</td>
            	<td>
            		<select name="division" id="div">
            		    <option value="-1">---SELECT---</option>
                  		<option value="A">A</option>
                		<option value="B">B</option>
                    </select>	
        		</td>
        	</tr>
        	<tr>
        		<td>Date*</td>
        		<td><input required type="date" value="<%=date%>" name="date"></td>
        	</tr>
        	<tr>
        		<td>Attendance*</td>
        		<td>
        			<select name="attend" id="attend">
        				<option value="-1">---SELECT---</option>
                 		<option value="0">Absent</option>
                 		<option value="1">Present</option>
            		</select>
            	</td>
        	</tr>
        	<tr>
        		<td colspan="2" align="center"><input type="submit" class="btn" name="submit" value="Edit Attendance"></td>
        	</tr>
        	</table>
        </form>
    </body>
</html>
<script>
function validation()
{	
	alert("In");
	int attendance = document.getElementById("attend").value;
	if(value == -1)
		{
			alert("Please select Attendance");
			return false;
		}
	int attendance = document.getElementById("subject").value;
	if(value == -1)
		{
			alert("Please select Subject");
			return false;
		}
	int attendance = document.getElementById("div").value;
	if(value == -1)
		{
			alert("Please select Divison");
			return false;
		}
	int attendance = document.getElementById("sem").value;
	if(value == -1)
		{
			alert("Please select Semester");
			return false;
		}
	
}
</script>
