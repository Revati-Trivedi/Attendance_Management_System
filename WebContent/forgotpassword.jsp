<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="javax.activation.*"%>
<% 
String to ="revatitrivedi24@gmail.com";
String from  = "revatitrivedi24@gmail.com";
String host = "localhost";
Properties properties = System.getProperties();
properties.setProperty("mail.smtp.host", host);
try
{
	MimeMessage message = new MimeMessage(Session.getDefaultInstance(properties));
	message.setFrom(new InternetAddress(from));
    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
    message.setSubject("New password");
    message.setText("New password is : abc");
    Transport.send(message);
    System.out.println("Message sent successfully");
}
catch(Exception e)
{
	System.out.println(e);
}
%>