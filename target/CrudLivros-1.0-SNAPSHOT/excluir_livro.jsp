<%-- 
    Document   : excluir_livro
    Created on : 7 de nov. de 2024, 15:52:50
    Author     : andre
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Livro" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String id = request.getParameter("id");
            if (id != null) {
                Connection conecta = null;
                PreparedStatement st = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "a88387717");

                    String deleteQuery = "DELETE FROM tablivros WHERE id = ?";
                    st = conecta.prepareStatement(deleteQuery);
                    st.setString(1, id);
                    st.executeUpdate();  
                    conecta.close();

                    response.sendRedirect("index.jsp"); 
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
