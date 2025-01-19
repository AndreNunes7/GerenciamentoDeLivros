import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;


@WebServlet("/")
public class LivroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LivroDAL livroDAL;

    @Override
    public void init() {
        livroDAL = new LivroDAL();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertLivro(request, response);
                    break;
                case "delete":
                    deleteLivro(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateLivro(request, response);
                    break;
                default:
                    listLivro(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listLivro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Livro> livros = livroDAL.listarTodos();
        request.setAttribute("livros", livros);
        RequestDispatcher dispatcher = request.getRequestDispatcher("livro-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("livro-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Livro livroExistente = livroDAL.buscarPorId(id);
        request.setAttribute("livro", livroExistente);
        RequestDispatcher dispatcher = request.getRequestDispatcher("livro-form.jsp");
        dispatcher.forward(request, response);
    }

    private void insertLivro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        int ano = Integer.parseInt(request.getParameter("ano"));

        Livro novoLivro = new Livro();
        novoLivro.setTitulo(titulo);
        novoLivro.setAutor(autor);
        novoLivro.setAno(ano);

        livroDAL.inserir(novoLivro);
        response.sendRedirect("livros?action=list"); // Redireciona para a listagem após inserção
    }

    private void updateLivro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        int ano = Integer.parseInt(request.getParameter("ano"));

        Livro livro = new Livro(id, titulo, autor, ano);
        livroDAL.atualizar(livro);
        response.sendRedirect("livros?action=list"); // Redireciona para a listagem após atualização
    }

    private void deleteLivro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        livroDAL.excluir(id);
        response.sendRedirect("livros?action=list"); // Redireciona para a listagem após exclusão
    }
}

