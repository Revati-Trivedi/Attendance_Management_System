<%@include file="menu.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<!-- Get list of lectures of the teacher in dropdown -->
<%
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
Connection connection = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=attendance_system;integratedSecurity=true");
Statement st = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
ResultSet rs = null,rs2 = null;

if(request.getParameter("attendance") != null)
{
	Enumeration en = request.getParameterNames();
	int flag = 0;
	while(en.hasMoreElements())
	{
			Object objOri=en.nextElement();
			String param=(String)objOri;
			String regex = "\\d+";
			String value=request.getParameter(param);
			int lectureid = Integer.parseInt(request.getParameter("lectures").substring(0,1));
			if(param.matches("^[^a-zA-Z]+\n$"))
			{
				if(value.equals("0"))//means student is absent
				{
					String query = "insert into attendance(fklectureid,fkenrollmentnumber,attendance) values("+lectureid+","+param+","+0+")";
					int rows = st.executeUpdate(query);
					if(rows==0)
					{
						flag=1;
						out.println("Problem inserting the attendance");
					}
				}
				else//student is present
				{
					String query = "insert into attendance(fklectureid,fkenrollmentnumber,attendance) values("+lectureid+","+param+","+1+")";
					int rows = st.executeUpdate(query);
					if(rows==0)
					{
						flag=1;
						out.println("Problem inserting the attendance");
					}
				}		
			}
			
	}	
	if(flag==0)
	{
		out.println("<h2>Attendance marked successfully.</h2>");
	}

}
else
{
	if(request.getParameter("lectures") == null)
	{
		int teacherid = (Integer)session.getAttribute("teacherid");
		String query = "select lectureid,concat(semester,division) as div,subjectname,format(date,'dd/MM/yyyy') as date from master_lecture join master_division on fkdivisionid=divisionid join master_subject on fksubjectid=subjectid where fkteacherid="+teacherid;
		rs = st.executeQuery(query);
	}
	else
	{
		String query = "select enrollmentnumber,name,lectureid,format(date,'dd/MM/yyyy') as date,semester,division,subjectname from master_student join master_lecture on master_student.fkdivisionid = master_lecture.fkdivisionid join master_subject on fksubjectid=subjectid join master_division on master_lecture.fkdivisionid = divisionid where lectureid="+request.getParameter("lectures").substring(0,1);
 		rs2 = st.executeQuery(query);
 	}
}
%>
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
#lectures
{
	height:50px;
	border-radius:5px;
	background-color:lightgray;
}

    option:hover{background-color:gray;
    color:white;
    }
#attendance_table{
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
</head>
<script>
function validate()
{
	var num = document.getElementById("lectures").value;
	if(num == 0)
		{
		alert("Please select a Lecture");
		return false;
		}
}
</script>
<body>



<% if(rs != null){ %>
<form onsubmit="return validate()">
<table style="margin-top:15%;margin-left:45%;">

<tr>
<td>
<select id="lectures" name="lectures">
<option value="0">------SELECT------</option>
<% while(rs.next()){ %>
<option value="<% out.println(rs.getInt("lectureid")); %>"><% out.println(rs.getString("div")+" "+rs.getString("subjectname")+" "+rs.getString("date")); %></option>	
<% } %>
</select>
</td>
</tr>
<tr></tr>
<tr>
<td align="center">
<input class="btn" type="submit" name="submit" value="Submit">
</td>
</tr>
</table>
</form>
<% } %>



<% int rst=0;if(rs2!=null){ %>

<% while(rst!=1 && rs2.next()){ %>
<p style="margin-top:2%;">
<h3><b>Semester :</b><% out.println(rs2.getString("semester")); %></h3>
<h3><b>Division :</b><% out.println(rs2.getString("division")); %></h3>
<h3><b>Subject :</b><% out.println(rs2.getString("subjectname")); %> </h3>
<h3><b>Date :</b><% out.println(rs2.getString("date")); %> </h3>
</p>
<% rst++;}
rs2.beforeFirst();
%>


<form method="post">
<table id="attendance_table" align="center" style="vertical-align:middle" cellspacing="0" cellpadding="0">

<tr>
<td>Enrollment Number</td>
<td>Student Name</td>
<td>All<input type="checkbox" id="checkall" onclick="check()" style="width:18px;height:18px"></td>
</tr>

<% int i=1;while(rs2.next()){ %>

<tr>
<td><% out.println(rs2.getBigDecimal("enrollmentnumber")); %></td>
<td><% out.println(rs2.getString("name")); %></td>
<td>
<input type="checkbox" value="1" class="attendancecheckboxes" onclick="changecheckbox()" style="width:18px;height:18px" name="<% out.println(rs2.getBigDecimal("enrollmentnumber")); %>">
<input type="hidden" value="0" name="<% out.println(rs2.getBigDecimal("enrollmentnumber")); %>"></td>

</tr>
<% i++; %>
<% } %>

<tr>
<td>
<input class="btn" type="submit" name="attendance" value="Submit">
</td>

</tr>
</table>
</form>

<% } %>

</body>
<script>
function changecheckbox()
{
	
}
function fillattendance()
{
	var x = document.getElementsByClassName("attendancecheckboxes");
	var i;
	for (i = 0; i < x.length; i++) 
	{
	  <%
	  //Insert data into attendance table
	  //String query = "insert into attendance(fklectureid,fkenrollmentnumber,attendance) values("+lectureid+","+x[i].name+","+x[i].checked+")";
	  
	  
	  %>
	}
	return false;
}

function check()
{
	var y = document.getElementById("checkall").checked;
	var x = document.getElementsByClassName("attendancecheckboxes");
	if(y == true)
	{
		var i;
		for (i = 0; i < x.length; i++) {
		  x[i].checked = true;
		}
	}
	else
	{
		var i;
		for (i = 0; i < x.length; i++) {
		  x[i].checked = false;
		}
	}
}


</script>
</html>