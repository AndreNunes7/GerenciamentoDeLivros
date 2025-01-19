# Gerenciamento de Livros - Aplicação Web em Java

Este projeto é uma aplicação web em Java para o gerenciamento de livros, que permite realizar as operações CRUD (Criar, Ler, Atualizar e Deletar) em uma base de dados MySQL. A aplicação utiliza JSP (Java Server Pages) e JDBC para interagir com o banco de dados e exibir os dados na interface web.

## Funcionalidades

- **Cadastro de Livros**: O formulário permite cadastrar livros, informando o título, autor e ano de publicação.
- **Pesquisa de Livros**: Permite buscar livros pelo título, autor ou ano de publicação.
- **Edição de Livros**: O usuário pode editar os detalhes de um livro cadastrado.
- **Exclusão de Livros**: O usuário pode excluir um livro da lista.
- **Listagem de Livros**: Todos os livros cadastrados são exibidos em uma tabela com as opções de editar ou excluir.

## Tecnologias Utilizadas

- **JSP (Java Server Pages)**: Utilizado para renderizar o conteúdo dinâmico e interagir com o servidor.
- **JDBC (Java Database Connectivity)**: Utilizado para se conectar e realizar operações em um banco de dados MySQL.
- **MySQL**: Banco de dados utilizado para armazenar as informações dos livros.
- **HTML/CSS**: Utilizados para a criação e estilização da interface web.

## Estrutura do Projeto

- **index.jsp**: Página principal onde o usuário pode cadastrar livros, realizar buscas e visualizar a lista de livros cadastrados.
- **salvar_livros.jsp**: Página de processamento que recebe os dados do formulário de cadastro e salva o livro no banco de dados.
- **editar_livro.jsp**: Página para editar os dados de um livro existente.
- **excluir_livro.jsp**: Página para excluir um livro do banco de dados.

## Banco de Dados

A aplicação utiliza um banco de dados MySQL com a seguinte tabela:

### Tabela `tablivros`

| Campo            | Tipo     |
|------------------|----------|
| id               | INT      |
| titulo           | VARCHAR  |
| autor            | VARCHAR  |
| ano_publicacao   | INT      |

## Como Rodar o Projeto

### Pré-requisitos

- **Java JDK** (versão 8 ou superior).
- **MySQL** (ou MariaDB).
- **IDE**: Você pode usar qualquer IDE de sua preferência (como Eclipse, IntelliJ IDEA ou NetBeans).

### Passos para Executar

1. **Clone o repositório:**
    ```bash
    git clone https://github.com/SeuUsuario/GerenciamentoLivros.git
    ```

2. **Configure o Banco de Dados:**
   - Crie um banco de dados MySQL chamado `dblivros` (ou outro nome de sua escolha).
   - Execute o seguinte comando SQL para criar a tabela `tablivros`:
     ```sql
     CREATE TABLE tablivros (
         id INT AUTO_INCREMENT PRIMARY KEY,
         titulo VARCHAR(255),
         autor VARCHAR(255),
         ano_publicacao INT
     );
     ```

3. **Configuração do Banco de Dados no Projeto:**
   - No arquivo JSP, altere a string de conexão do banco de dados para refletir suas configurações:
     ```java
     Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dblivros", "root", "senha");
     ```

4. **Compile e execute a aplicação:**
   - Importe o projeto na sua IDE.
   - Execute a aplicação em um servidor como Apache Tomcat.
   - Acesse a aplicação pelo navegador no endereço: `http://localhost:8080/`.

## Como Funciona

1. **Cadastro de Livros:**
   - Na página principal (`index.jsp`), o usuário preenche um formulário com o título, autor e ano de publicação e clica em "Salvar" para adicionar o livro ao banco de dados.

2. **Pesquisa de Livros:**
   - O usuário pode pesquisar livros através do título, autor ou ano de publicação, e a lista será filtrada com base no termo informado.

3. **Edição e Exclusão:**
   - Cada livro exibido na tabela possui links para "Editar" e "Excluir". O link de edição leva o usuário à página de edição, onde os detalhes podem ser alterados. O link de exclusão exclui o livro da base de dados.

## Exemplo de Funcionamento

- **Cadastro:** O usuário preenche um formulário com as informações do livro e clica em "Salvar".
- **Pesquisa:** O usuário pode buscar livros pelo título, autor ou ano.
- **Edição:** O usuário pode alterar as informações de um livro clicando no botão "Editar" e fazendo as modificações necessárias.
- **Exclusão:** O usuário pode excluir um livro clicando no botão "Excluir" e confirmando a ação.

## Contribuições

Contribuições são bem-vindas! Se você deseja melhorar o projeto, pode abrir uma **pull request** ou sugerir novas funcionalidades.

## Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Se você tiver qualquer dúvida ou precisar de mais informações, fique à vontade para abrir uma issue ou entrar em contato!
