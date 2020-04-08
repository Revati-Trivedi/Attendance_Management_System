<%@include file="menu.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
url="jdbc:mysql://localhost:3307/db_attendance" user="root" password="" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
    </head>
    <body>
        <% 
        
        String sub_name = request.getParameter("subject");
        int sem = Integer.parseInt(request.getParameter("sem"));
        String division = request.getParameter("division");
        String dt = request.getParameter("date");
        int t_id = (int)session.getAttribute("teacherid");
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
        <sql:query var="result" dataSource="jdbc/db_attendance">
        SELECT Fkstudentid, name, Attendance FROM attendance, master_student WHERE Fklectureid IN (SELECT Lectureid FROM master_lecture
        WHERE Fkteacherid=${tid} AND fkdivisionid=(SELECT Divisionid FROM master_division WHERE Division="${DIV}" AND Semester=${semester}) AND Fksubjectid IN (SELECT Subjectid FROM master_subject WHERE Subjectname="${sub}")
        AND Date = (SELECT STR_TO_DATE('${date}','%Y-%m-%d')) ) AND enrollmentnumber = Fkstudentid
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
                <table width="70%" border="2" align="center">
                     <tr>
                          <th>Enrollment Number</th>
                          <th>Name</th>
                          <th>Attendance</th>
                           <th>Edit</th>
                      </tr>
                 <c:forEach var="table" items="${result.rows}">
                     <tr>
                           <td align="center"><c:out value="${table.Fkstudentid}"/></td>
                            <td align="center"><c:out value="${table.name}"/></td>
                            <td align="center">
                                <!--c:if test=${table.Attendance eq true} --><!--c:out value="Present"/--><!--/c:if-->
                                <!--c:if test=${table.Attendance eq false} --><!--c:out value="Absent"/--><!--/c:if-->
                                <c:out value="${table.Attendance}"/>
                            </td>
                            <td align="center"><a href="edit.jsp?id=${table.Fkstudentid}&dt=${date}">Edit</a></td>  
                        </tr>
                 </c:forEach>
                </table>
             </c:otherwise>
    </c:choose>
    </body>
</html>
