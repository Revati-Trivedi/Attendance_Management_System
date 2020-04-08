<%@include file="menu.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost:3307/db_attendance" user="root" password="" />
<sql:query var="subjects" dataSource="jdbc/db_attendance">
    SELECT Subjectname FROM master_subject
</sql:query>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
    </head>
    <body>
        <h3>View Attendance By Class</h3>
        <form action="view_process.jsp" method="GET">
            Subject name: 
            <select name="subject">
               
                <c:forEach var="sub" items="${subjects.rows}">
                <option value="${sub.Subjectname}">${sub.Subjectname}</option>
                </c:forEach>
            </select><br>
            Semester:
            <select name="sem">
                <c:forEach var="j" begin="1" end="8">
                <option value="${j}">${j}</option>
                </c:forEach>
                
            </select> &nbsp;
            Division:
            <select name="division">
                <option value="A">A</option>
                <option value="B">B</option>
            </select> &nbsp;
            Date: 
            <input type="date" value="2020-04-01" name="date"> <br>
            <input type="submit" value="Show Attendance">
            
        </form>
    </body>
</html>
