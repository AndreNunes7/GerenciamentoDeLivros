<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String titulo = request.getParameter("titulo");
    String autor = request.getParameter("autor");
    String ano_publicacao = request.getParameter("ano");

    Connection conecta;
    PreparedStatement st;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "a88387717");

        st = conecta.prepareStatement("INSERT INTO tablivros (titulo, autor, ano_publicacao) VALUES (?, ?, ?)");
        st.setString(1, titulo);
        st.setString(2, autor);
        st.setString(3, ano_publicacao);

        st.executeUpdate(); 
        conecta.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    response.sendRedirect("index.jsp");

%>
