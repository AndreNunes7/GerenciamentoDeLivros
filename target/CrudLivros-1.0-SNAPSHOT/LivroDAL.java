import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class LivroDAL {
    private String jdbcURL = "jdbc:mysql://localhost:3306/dblivros";
    private String jdbcUsername = "root";
    private String jdbcPassword = "a88387717";

    private static final String INSERT_LIVRO_SQL = "INSERT INTO tablivros (titulo, autor, ano_publicacao) VALUES (?, ?, ?)";
    private static final String SELECT_LIVRO_BY_ID = "SELECT id, titulo, autor, ano_publicacao FROM tablivros WHERE id = ?";
    private static final String SELECT_ALL_LIVROS = "SELECT * FROM tablivros";
    private static final String DELETE_LIVRO_SQL = "DELETE FROM tablivros WHERE id = ?";
    private static final String UPDATE_LIVRO_SQL = "UPDATE tablivros SET titulo = ?, autor = ?, ano_publicacao = ? WHERE id = ?";

    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void inserir(Livro livro) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_LIVRO_SQL)) {
            preparedStatement.setString(1, livro.getTitulo());
            preparedStatement.setString(2, livro.getAutor());
            preparedStatement.setInt(3, livro.getAno());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Livro buscarPorId(Long id) {
        Livro livro = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_LIVRO_BY_ID)) {
            preparedStatement.setLong(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                int ano = rs.getInt("ano_publicacao");
                livro = new Livro(id, titulo, autor, ano);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return livro;
    }

    public List<Livro> listarTodos() {
        List<Livro> livros = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_LIVROS)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Long id = rs.getLong("id");
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                int ano = rs.getInt("ano_publicacao");
                livros.add(new Livro(id, titulo, autor, ano));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return livros;
    }

    public boolean excluir(Long id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_LIVRO_SQL)) {
            statement.setLong(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean atualizar(Livro livro) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_LIVRO_SQL)) {
            statement.setString(1, livro.getTitulo());
            statement.setString(2, livro.getAutor());
            statement.setInt(3, livro.getAno());
            statement.setLong(4, livro.getId());

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}