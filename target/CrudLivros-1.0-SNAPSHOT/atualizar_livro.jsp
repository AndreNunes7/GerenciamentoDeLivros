<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Atualizar Livro</title>
</head>
<body>
    <%
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        int ano = Integer.parseInt(request.getParameter("ano"));
        
        try {
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "a88387717");
            
            st = conecta.prepareStatement("UPDATE tablivros SET titulo = ?, autor = ?, ano_publicacao = ? WHERE id = ?");
            st.setString(1, titulo);
            st.setString(2, autor);
            st.setInt(3, ano);
            st.setString(4, id);
            
            int result = st.executeUpdate();
            
            
            conecta.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Erro: " + e.getMessage() + "</p>");
        }
    %>
    
</body>
</html>
