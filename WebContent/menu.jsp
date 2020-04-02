<!-- Check for session first -->
<% if(session.getAttribute("username") == null)
{
	response.sendRedirect("index.html");
} %>
<!DOCTYPE html>
<html>
<style>
#navigation, #navigation a
{
	padding:10px;
	background-color:lightgray;
	
}
#navigation a
{
	color:black;
	text-decoration:none;
}
#navigation a:hover
{
	background-color:gray;
	color:white;
}
</style>
<body>
<div>
<span>Welcome, <% out.println(session.getAttribute("username"));%></span>
<span style="float:right"><a href="logout.jsp">Log Out</a></span>
</div><br>


<div id="navigation"><a href="add.jsp">ADD</a><a href="edit.jsp">EDIT</a><a href="view.jsp">VIEW</a></div>


</body>
</html>