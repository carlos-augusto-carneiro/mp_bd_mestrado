# Análise de Produção Acadêmica (SGBD - PostgreSQL)

Projeto desenvolvido como trabalho prático da disciplina de Banco de Dados, focando na modelagem relacional, manipulação e análise de dados sobre a produtividade acadêmica de um departamento de pesquisa.

---

## Tecnologias Utilizadas

* **SGBD:** PostgreSQL (via Docker Container)
* **IDE / Cliente SQL:** DBeaver
* **Linguagem:** SQL (DDL, DML, DQL)

---

## Cenário e Modelagem do Banco

O objetivo do banco de dados é gerenciar publicações de pesquisadores do departamento em diferentes veículos científicos (revistas e conferências). 

A tabela `Artigos` funciona como a tabela associativa entre `Pesquisadores` e `Revistas_Conferencias`, armazenando os títulos e anos de publicação.

### Visualização do Schema / Tabelas Criadas:
![Tabelas Criadas](tabelas_criadas.png)

---

## Povoamento das Tabelas (DML)

Os dados foram inseridos de forma coerente e balanceada para garantir que as consultas analíticas retornem resultados significativos.

### Registros de Pesquisadores:
![Pesquisadores](pesquisadores_criados.png)

### Registros de Revistas e Conferências:
![Revistas e Conferências](revistas_criadas.png)

### Registros de Artigos Criados:
![Artigos Criados](artigo_criado.png)

---

## Consultas Analíticas e Resultados

Abaixo estão as consultas desenvolvidas para responder às perguntas analíticas do projeto e seus respectivos retornos no banco de dados.

### 1. Quais são os 3 pesquisadores com o maior número de publicações?

```sql
SELECT 
    p.nome, 
    COUNT(a.idartigo) AS num_publicacoes
FROM Pesquisadores p
JOIN Artigos a ON p.idpesquisador = a.idpesquisador
GROUP BY p.idpesquisador, p.nome
ORDER BY num_publicacoes DESC
LIMIT 3;
```
**Resultado:**
![Resultado Pergunta 1](1pergunta.png)

---

### 2. Qual a quantidade de artigos publicados por ano, ordenados do ano mais recente para o mais antigo?

```sql
SELECT 
    anopublicacao, 
    COUNT(idartigo) AS quantidade_artigos
FROM Artigos
GROUP BY anopublicacao
ORDER BY anopublicacao DESC;
```
**Resultado:**
![Resultado Pergunta 2](2pergunta.png)

---

### 3. Liste as revistas/conferências que receberam mais de 2 publicações do departamento, junto com a contagem de artigos.

```sql
SELECT 
    rc.nomelocal, 
    COUNT(a.idartigo) AS quantidade_artigos
FROM Revistas_Conferencias rc
JOIN Artigos a ON rc.idlocal = a.idlocal
GROUP BY rc.idlocal, rc.nomelocal
HAVING COUNT(a.idartigo) > 2;
```
**Resultado:**
![Resultado Pergunta 3](3pergunta.png)

---

## 🚀 Como Executar o Projeto

1. Suba o container PostgreSQL no Docker via `docker-compose.yml`:
   ```bash
   docker compose up -d
   ```
2. Conecte ao banco através do **DBeaver** (`localhost:5432`).
3. Execute o arquivo `.sql` principal para recriar as tabelas, inserir os dados e testar as consultas.