-- Miniprojeto 2: Análise Avançada e Lógica de Negócio com SQL
-- Nome: Carlos Augusto Carneiro de Freitas Filho
-- Opção escolhida: B
-- SGBD utilizado: PostgreSQL
-- Data: 06/10/2026


-- ============================================================================
-- 1. ANÁLISES COM WINDOW FUNCTIONS
-- ============================================================================

-- Ranking de Pesquisadores por Número de Publicações
-- Minha lógica foi a seguinte:
-- Primeiro, criei uma CTE (Common Table Expression) chamada ContagemPublicacoes para contar o número total de publicações de cada pesquisador.
-- Em seguida, utilizei a função DENSE_RANK() para atribuir um ranking aos pesquisadores com base no número de publicações, particionando pelo ano de contratação.
-- Na query final, selecionei o nome do pesquisador, o ano de contratação, o total de publicações e o ranking correspondente.


WITH ContagemPublicacoes AS (
    SELECT
        p.idpesquisador,
        p.nome,
        p.anocontratacao,
        COUNT(a.idartigo) AS total_publicacoes
    FROM Pesquisadores p
    LEFT JOIN Artigos a ON p.idpesquisador = a.idpesquisador
    GROUP BY p.idpesquisador, p.nome, p.anocontratacao
)
SELECT
    nome,
    anocontratacao,
    total_publicacoes,
    DENSE_RANK() OVER (PARTITION BY anocontratacao ORDER BY total_publicacoes DESC) AS ranking
FROM ContagemPublicacoes;

-- ============================================================================
-- 2. Auditória
-- ============================================================================
-- A tabela Log_Artigos_Excluidos armazena o ID, título, data/hora exata da exclusão 
-- e o utilizador da base de dados que executou a operação.
-- PostgreSQL, a implementação de Triggers exige a criação prévia de uma função 
-- (fn_LogExclusaoArtigos) que define a ação a ser executada. A variável especial 'OLD' 
-- captura os dados da linha antes desta ser eliminada.
-- O Trigger 'trg_LogExclusaoArtigos' é configurado para disparar automaticamente 
-- depois (AFTER) de qualquer operação de DELETE na tabela Artigos, para cada linha afetada (FOR EACH ROW)

-- Tabela de auditória para registrar exclusões de artigos
CREATE TABLE Log_Artigos_Excluidos (
    idlog SERIAL PRIMARY KEY,
    idartigoexcluido INT,
    tituloexcluido VARCHAR(255),
    dataexclusao TIMESTAMP,
    usuariodb VARCHAR(50)
);

-- Trigger para registrar exclusões de artigos
CREATE OR REPLACE FUNCTION fn_LogExclusaoArtigos()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Artigos_Excluidos (idartigoexcluido, tituloexcluido, dataexclusao, usuariodb)
    VALUES (OLD.idartigo, OLD.titulo, CURRENT_TIMESTAMP, current_user);
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Criando a trigger para a tabela Artigos
CREATE TRIGGER trg_LogExclusaoArtigos
AFTER DELETE ON Artigos
FOR EACH ROW
EXECUTE FUNCTION fn_LogExclusaoArtigos();