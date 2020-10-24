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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Attendance</title>
    </head>
    <body>
        <% 
        long enroll_no = Long.parseLong(request.getParameter("enroll"));
        out.println(enroll_no);
        String sub_name = request.getParameter("subject");
        int sem = Integer.parseInt(request.getParameter("sem"));
        String division = request.getParameter("division");
        String dt = request.getParameter("date");
        int t_id = (Integer)session.getAttribute("teacherid");
        int attend = Integer.parseInt(request.getParameter("attend"));
        %>
        <c:set var="sub" value="<%=sub_name%>" scope="page"/>
        <c:set var="semester" value="<%=sem%>" scope="page" />
        <c:set var="DIV" value="<%=division%>" scope="page"/>
        <c:set var="tid" value="<%=t_id%>" scope="page"/>
        <c:set var="date" value="<%=dt%>" scope="page"/>
        <c:set var ="attnd" scope="page" value = "<%= attend%>"/>
        <c:set var ="stud_id" scope="page" value = "<%= enroll_no%>"/>
        
        <sql:update dataSource="${dataSource}" var="count">
            UPDATE attendance SET Attendance='${attnd}' WHERE Fklectureid IN (SELECT Lectureid FROM master_lecture
        WHERE Fkteacherid=${tid} AND fkdivisionid=(SELECT Divisionid FROM master_division WHERE Division='${DIV}' AND Semester=${semester}) AND Fksubjectid IN (SELECT Subjectid FROM master_subject WHERE Subjectname='${sub}')
        AND Date = '${date}' AND Fkenrollmentnumber=${stud_id})
           
        </sql:update>
        <c:choose>
        <c:when test="${count>=1}">
            <font size="5" color='green'> Data updated
            successfully.</font>
        </c:when>
        <c:otherwise>
            <font size="5" color='Red'> Data not updated. Check if data really needs updation.</font>
        </c:otherwise>
        </c:choose>
        
    </body>
</html>
