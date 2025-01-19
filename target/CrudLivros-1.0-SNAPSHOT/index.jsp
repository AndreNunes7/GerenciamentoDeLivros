<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Livro" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciamento de Livros</title>
        <style>
            .container {
                width: 70%;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
            }
            .form-group, .form-group2 {
                margin-bottom: 15px;
            }
            .form-group label, .form-group2 label {
                display: block;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }
            .form-group input[type="text"],
            .form-group input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-bottom: 10px;
            }
            .form-group2 input[type="text"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .btn, .btn2 {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .btn:hover {
                background-color: #45a049;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 24px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                border-radius: 8px;
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #4CAF50;
                color: white;
                font-weight: bold;
                text-align: center;
            }
            td {
                background-color: #f9f9f9;
            }
            .action-buttons {
                text-align: center;
            }
            .action-buttons a {
                text-decoration: none;
                padding: 8px 12px;
                color: white;
                border-radius: 4px;
                margin: 0 4px;
                font-size: 14px;
                font-weight: bold;
                display: inline-block;
                transition: background-color 0.3s ease;
            }
            .action-buttons a.edit {
                background-color: #1E90FF;
            }
            .action-buttons a.edit:hover {
                background-color: #1C86EE;
            }
            .action-buttons a.delete {
                background-color: #FF6347;
            }
            .action-buttons a.delete:hover {
                background-color: #FF4500;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Gerenciamento de Livros</h1>
            <form action="salvar_livros.jsp" method="POST">
                <div class="form-group">
                    <label for="titulo">Título:</label>
                    <input type="text" id="titulo" name="titulo" required/>
                </div>
                <div class="form-group">
                    <label for="autor">Autor:</label>
                    <input type="text" id="autor" name="autor" required/>
                </div>
                <div class="form-group">
                    <label for="ano">Ano de Publicação:</label>
                    <input type="number" id="ano" name="ano" required/>
                </div>
                <input type="submit" value="Salvar" class="btn">
            </form>
            <br><br>
            <form action="index.jsp" method="GET">
                <div class="form-group2">
                    <label for="pesquisa">Pesquisar Livro:</label>
                    <input type="text" id="pesquisa" name="termo" placeholder="Digite o título, autor, ou ano">
                </div>
                <input type="submit" value="Pesquisar" class="btn2">
            </form>

            <%
                String termo = request.getParameter("termo");
                String sql = "SELECT * FROM tablivros";
                if (termo != null && !termo.trim().isEmpty()) {
                    sql += " WHERE titulo LIKE ? OR autor LIKE ? OR ano_publicacao LIKE ?";
                }
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "a88387717");

                    PreparedStatement st = conecta.prepareStatement(sql);
                    if (termo != null && !termo.trim().isEmpty()) {
                        st.setString(1, "%" + termo + "%");
                        st.setString(2, "%" + termo + "%");
                        st.setString(3, "%" + termo + "%");
                    }
                    ResultSet rs = st.executeQuery();
            %>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>Ano</th>
                    <th>Ações</th>
                </tr>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("id") %></td>
                    <td><%= rs.getString("titulo") %></td>
                    <td><%= rs.getString("autor") %></td>
                    <td><%= rs.getString("ano_publicacao") %></td>
                    <td class="action-buttons">
                        <a href="editar_livro.jsp?id=<%= rs.getString("id") %>" class="edit">Editar</a>
                        <a href="excluir_livro.jsp?id=<%= rs.getString("id") %>" class="delete" onclick="return confirm('Confirma a exclusão?')">Excluir</a>
                    </td>
                </tr>
                <%
                    }
                    conecta.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </table>
        </div>
    </body>
</html>
