<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Editar Livro</title>
        <style>
            .container {
                width: 70%;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
            }

            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
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

            .btn {
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
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Editar Livro</h1>

            <%
                String id = request.getParameter("id");
                String titulo = "";
                String autor = "";
                int anoPublicacao = 0;

                try {
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "a88387717");

                    st = conecta.prepareStatement("SELECT * FROM tablivros WHERE id = ?");
                    st.setString(1, id);

                    ResultSet rs = st.executeQuery();

                    if (rs.next()) {
                        titulo = rs.getString("titulo");
                        autor = rs.getString("autor");
                        anoPublicacao = rs.getInt("ano_publicacao");
                    }

                    conecta.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            <form action="atualizar_livro.jsp" method="POST">
                <input type="hidden" name="id" value="<%= id%>">
                <div class="form-group">
                    <label for="titulo">Título:</label>
                    <input type="text" id="titulo" name="titulo" value="<%= titulo%>" required>
                </div>

                <div class="form-group">
                    <label for="autor">Autor:</label>
                    <input type="text" id="autor" name="autor" value="<%= autor%>" required>
                </div>

                <div class="form-group">
                    <label for="ano">Ano de Publicação:</label>
                    <input type="number" id="ano" name="ano" value="<%= anoPublicacao%>" required>
                </div>

                <input type="submit" value="Salvar Alterações" class="btn">
            </form>
        </div>
    </body>
</html>
