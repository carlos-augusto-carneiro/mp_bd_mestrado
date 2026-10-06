-- Miniprojeto 1: Modelagem e Análise de Dados Estruturados 
-- Nome: Carlos Augusto Carneiro de Freitas Filho
-- Opção escolhida: B - Artigos Científicos
-- SGBD Utilizado: PostgreSQL
-- Data: 02/10/2026


=========================================================================================================
-- Comandos DDL
=========================================================================================================
-- A tabela Artigos atua como entidade associativa conectand Pesquisadores e Revistas_Conferencias, 
-- permitindo que um pesquisador possa ter vários artigos publicados em diferentes revistas ou conferências, 
--e uma revista ou conferência possa ter vários artigos de diferentes pesquisadores.

-- Existe um relacionamento 1:N entre Pesquisadores e Artigos, 
-- onde um pesquisador pode ter vários artigos, mas cada artigo pertence a apenas um pesquisador.

-- Existe um relacionamento 1:N entre Revistas_Conferencias e Artigos,
-- onde uma revista ou conferência pode ter vários artigos, mas cada artigo pertence a apenas uma revista ou conferência.

-- Foram utilizadas chaves primárias e estrangeiras para garantir a integridade referencial entre as tabelas,
-- evitando inconsistências e violações de integridade dos dados. FK com NOT NULL para garantir que cada 
-- artigo esteja associado a um pesquisador e a uma revista ou conferência.
=========================================================================================================
CREATE TABLE Pesquisadores 
(
    idpesquisador serial PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    afiliacao VARCHAR(255) NOT NULL,
    anocontratacao INT NOT NULL
);

-- Foi utilizado o tipo de dado DECIMAL para armazenar o fator de impacto, pois ele pode ter valores decimais.
-- Utilizado também o CHECK para garantir que o tipo de local seja apenas 'Revista' ou 'Conferencia'. 
CREATE TABLE Revistas_Conferencias
(
    idlocal serial PRIMARY KEY,
    nomelocal VARCHAR(255) NOT NULL,
    tipolocal VARCHAR(20) NOT NULL CHECK (tipolocal IN ('Revista', 'Conferencia', 'revista', 'conferencia', 'REVISTA', 'CONFERENCIA', 'Conferência', 'CONFERÊNCIA', 'conferência')),
    fatorimpacto DECIMAL(5, 2) NOT NULL
);

-- Está sendo feito a referência das chaves estrangeiras para garantir a integridade referencial entre as tabelas.
CREATE TABLE Artigos 
(
    idartigo serial PRIMARY KEY,
    idpesquisador INT REFERENCES Pesquisadores(idpesquisador) NOT NULL,
    idlocal INT REFERENCES Revistas_Conferencias(idlocal) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    anopublicacao INT NOT NULL
);

=========================================================================================================
-- Comandos DML
=========================================================================================================

-- Inserção de dados na tabela Pesquisadores
INSERT INTO Pesquisadores (nome, afiliacao, anocontratacao) VALUES
('Ana Silva', 'Universidade de São Paulo', 2015),
('Carlos Eduardo Santos', 'Universidade Estadual de Campinas', 2018),
('Mariana Oliveira', 'Universidade Federal do Rio de Janeiro', 2012),
('Lucas Pereira', 'Universidade Federal de Minas Gerais', 2020),
('Beatriz Costa', 'Universidade Federal do Rio Grande do Sul', 2016),
('Rafael Rodrigues', 'Fundação Oswaldo Cruz', 2010),
('Fernanda Lima', 'Empresa Brasileira de Pesquisa Agropecuária', 2019),
('Gustavo Almeida', 'Universidade Federal de Santa Catarina', 2021),
('Camila Rocha', 'Universidade Federal da Bahia', 2014),
('Thiago Martins', 'Universidade Federal do Ceará', 2017),
('Juliana Ribeiro', 'Universidade Federal de Pernambuco', 2013),
('Bruno Souza', 'Universidade Federal do Paraná', 2022),
('Aline Fernandes', 'Instituto Nacional de Pesquisas Espaciais', 2011),
('Diego Carvalho', 'Universidade Estadual Paulista', 2015),
('Larissa Gomes', 'Universidade Federal de Viçosa', 2018),
('Marcelo Araujo', 'Universidade Federal do Pará', 2009),
('Patrícia Barbosa', 'Universidade Federal de Goiás', 2020),
('Rodrigo Cardoso', 'Universidade Federal de São Carlos', 2016),
('Vanessa Melo', 'Universidade Federal de Pelotas', 2019),
('Felipe Correia', 'Instituto de Pesquisas Tecnológicas', 2014),
('Leticia Teixeira', 'Universidade Federal Fluminense', 2021),
('Gabriel Moura', 'Universidade Federal do ABC', 2017),
('Isabela Freitas', 'Universidade Federal de Santa Maria', 2013),
('Matheus Dias', 'Universidade Federal de Juiz de Fora', 2023),
('Sophia Cavalcante', 'Universidade Federal do Rio Grande do Norte', 2012),
('Leonardo Ramos', 'Universidade Federal de Uberlândia', 2015),
('Gabriela Castro', 'Universidade Federal do Espírito Santo', 2018),
('Vinicius Nunes', 'Universidade Federal de Campina Grande', 2020),
('Eduarda Monteiro', 'Universidade Federal do Amazonas', 2016),
('Daniel Mendes', 'Universidade Federal de Mato Grosso', 2011);

-- Inserção de dados na tabela Revistas_Conferencias
INSERT INTO Revistas_Conferencias (nomelocal, tipoLocal, fatorimpacto) VALUES
('Nature', 'Revista', 64.80),
('Science', 'Revista', 56.90),
('The Lancet', 'Revista', 168.90),
('IEEE Transactions on Pattern Analysis and Machine Intelligence', 'Revista', 23.60),
('ACM Conference on Computer Vision and Pattern Recognition (CVPR)', 'Conferencia', 11.50),
('International Conference on Machine Learning (ICML)', 'Conferencia', 9.80),
('Advances in Neural Information Processing Systems (NeurIPS)', 'Conferencia', 10.20),
('Journal of the ACM', 'Revista', 3.50),
('ACM SIGCOMM', 'Conferencia', 8.40),
('IEEE International Conference on Robotics and Automation (ICRA)', 'Conferencia', 7.10),
('Cell', 'Revista', 64.50),
('Physical Review Letters', 'Revista', 9.10),
('ACM SIGMOD International Conference on Management of Data', 'Conferencia', 6.80),
('VLDB Conference', 'Conferencia', 6.20),
('Journal of Finance', 'Revista', 7.90),
('Bioinformatics', 'Revista', 5.80),
('IEEE Communications Surveys & Tutorials', 'Revista', 35.60),
('AAAI Conference on Artificial Intelligence', 'Conferencia', 8.90),
('International Joint Conference on Artificial Intelligence (IJCAI)', 'Conferencia', 7.50),
('Nucleic Acids Research', 'Revista', 19.10),
('IEEE Transactions on Software Engineering', 'Revista', 6.50),
('International Conference on Software Engineering (ICSE)', 'Conferencia', 7.30),
('ACM SIGKDD Conference on Knowledge Discovery and Data Mining', 'Conferencia', 8.10),
('PLOS ONE', 'Revista', 3.70),
('Scientific Reports', 'Revista', 4.60),
('IEEE Internet of Things Journal', 'Revista', 10.60),
('USENIX Security Symposium', 'Conferencia', 9.40),
('IEEE Symposium on Security and Privacy (S&P)', 'Conferencia', 10.10),
('ACM Conference on Computer and Communications Security (CCS)', 'Conferencia', 9.00),
('The Review of Financial Studies', 'Revista', 8.20),
('Journal of Cleaner Production', 'Revista', 11.10),
('Renewable and Sustainable Energy Reviews', 'Revista', 15.90),
('IEEE/CVF International Conference on Computer Vision (ICCV)', 'Conferencia', 10.80),
('Annual Review of Astronomy and Astrophysics', 'Revista', 33.20),
('Chemical Reviews', 'Revista', 62.10),
('International Conference on Very Large Data Bases', 'Conferencia', 5.90),
('Journal of High Energy Physics', 'Revista', 5.80),
('ACM SIGGRAPH', 'Conferencia', 8.70),
('EMNLP (Empirical Methods in Natural Language Processing)', 'Conferencia', 8.30),
('ACL (Association for Computational Linguistics)', 'Conferencia', 9.10),
('IEEE Transactions on Knowledge and Data Engineering', 'Revista', 8.90),
('Applied Energy', 'Revista', 11.20),
('Nature Biotechnology', 'Revista', 46.90),
('Lancet Infectious Diseases', 'Revista', 36.40),
('IEEE Robotics and Automation Letters', 'Revista', 4.30);


-- Inserção de dados na tabela Artigos
INSERT INTO Artigos (idpesquisador, idlocal, titulo, anopublicacao) VALUES
(1, 5, 'Deep Learning Architectures for Visual Recognition', 2021),
(2, 14, 'Optimizing Query Execution in Distributed Databases', 2019),
(3, 1, 'Genomic Sequencing of Rare Pathogens in Tropical Regions', 2018),
(4, 23, 'Graph Neural Networks for Scalable Data Mining', 2022),
(5, 31, 'Lifecycle Assessment of Solar Panel Materials', 2020),
(6, 3, 'Clinical Trial Outcomes for Novel Antiviral Therapies', 2015),
(7, 7, 'Transformer-Based Approaches to Time Series Forecasting', 2023),
(8, 26, 'Energy-Efficient Protocols for Industrial IoT Sensor Networks', 2021),
(9, 20, 'CRISPR-Cas9 Editing Efficiency in Plant Genomes', 2017),
(10, 10, 'Autonomous Navigation Strategies in Unstructured Environments', 2020),
(11, 40, 'Cross-Lingual Representation Learning for Low-Resource Languages', 2022),
(12, 18, 'Heuristic Search Optimization in Large State Spaces', 2019),
(13, 2, 'Detection of High-Energy Particles in Cosmic Ray Events', 2016),
(14, 28, 'Zero-Knowledge Proofs for Privacy-Preserving Smart Contracts', 2023),
(15, 32, 'Grid Integration of Hybrid Wind-Solar Power Systems', 2021),
(16, 24, 'Statistical Bias in Large Scale Social Datasets', 2014),
(17, 6, 'Self-Supervised Learning Techniques for Speech Processing', 2022),
(18, 22, 'Automated Bug Detection using Neural Program Synthesis', 2020),
(19, 11, 'Mechanisms of Cellular Respiration under Hypoxic Stress', 2013),
(20, 21, 'Empirical Evaluation of Automated Testing Tools in Python', 2018),
(21, 39, 'Prompt Tuning Strategies for Large Language Models', 2023),
(22, 9, 'Congestion Control Algorithms for Ultra-Low Latency Networks', 2019),
(1, 1, 'Deep Learning Aplicado a Diagnósticos Médicos', 2024),
(2, 1, 'Visão Computacional e Processamento Digital de Imagens', 2023),
(3, 1, 'Aplicações de Inteligência Artificial em Cidades Inteligentes', 2022),
(23, 16, 'Comparative Analysis of Metagenomic Assembly Pipelines', 2017),
(24, 29, 'Mitigating Side-Channel Attacks in Cryptographic Hardware', 2021),
(25, 43, 'Monoclonal Antibodies for Targeted Cancer Immunotherapy', 2022),
(26, 17, 'Edge Computing Paradigms for Next-Generation Wireless Networks', 2020),
(27, 42, 'Thermodynamic Efficiency of Solid-State Energy Storage', 2019),
(28, 12, 'Quantum Entanglement Dynamics in Condensed Matter Systems', 2016),
(29, 38, 'Real-Time Ray Tracing Algorithms using Hardware Accelerators', 2021),
(30, 35, 'Catalytic Reduction of CO2 into Sustainable Fuels', 2018),
(1, 33, 'Object Detection Frameworks for Autonomous Vehicles', 2022),
(3, 44, 'Epidemiological Modeling of Infectious Disease Outbreaks', 2021),
(4, 4, 'Attention Mechanisms in Deep Convolutional Networks', 2020),
(6, 25, 'Open Science Practices in Biomedical Research', 2017),
(8, 27, 'Formal Verification of Distributed Consensus Protocols', 2022),
(10, 45, 'Reinforcement Learning for Manipulator Arm Control', 2023),
(12, 13, 'Scalable Transaction Processing in Hybrid Cloud Storage', 2018),
(14, 8, 'Theoretical Bounds of Probabilistic Data Structures', 2015),
(1, 3, 'Otimização de Desempenho em Arquitetura de Microsserviços', 2024),
(2, 3, 'Análise de Segurança e Vulnerabilidades em Redes Neutras', 2023),
(4, 3, 'Gerenciamento Eficiente de Memória em Containers Docker', 2022),
(15, 30, 'Impact of Green Bonds on Corporate Environmental Performance', 2021),
(17, 36, 'Distributed Transaction Commit Protocols at Scale', 2019),
(19, 34, 'Observation of Exoplanetary Atmospheres using Infrared Spectra', 2020),
(21, 15, 'Market Liquidity during Periods of Extreme Volatility', 2016),
(23, 37, 'NLO Quantum Chromodynamics Corrections in Particle Collisions', 2018),
(25, 41, 'Graph Mining Algorithms for Massive Social Networks', 2021),
(27, 31, 'Recycling Technologies for Lithium-Ion Batteries', 2022),
(28, 5, 'Semantic Segmentation in High-Resolution Satellite Imagery', 2023),
(2, 23, 'Feature Selection Methods for High-Dimensional Omics Data', 2017),
(5, 17, 'Massive MIMO Performance in Heterogeneous Cellular Networks', 2019),
(7, 7, 'Generative Adversarial Networks for Image-to-Image Translation', 2020),
(9, 20, 'Metabolic Engineering of Yeast for Biofuel Production', 2021);

=========================================================================================================
-- Perguntas
=========================================================================================================

-- 1 - Quais são os 3 pesquisadores com o maior número de publicações?
-- Foi usado o count para contar a quantidade de artigos publicados por cada pesquisador, 
-- agrupando pelo idpesquisador e nome, ordenando em ordem decrescente e limitando a 3 resultados.
Select p.nome, COUNT(a.idartigo) AS num_publicacoes
From Pesquisadores p
Join Artigos a ON p.idpesquisador = a.idpesquisador
Group By p.idpesquisador, p.nome
Order By num_publicacoes DESC
Limit 3;

-- 2 - Qual a quantidade de artigos publicados por ano, ordenados do ano mais recente para o mais antigo? 
-- Foi usado o count para contar a quantidade de artigos publicados por ano, 
-- agrupando pelo ano de publicação e ordenando em ordem decrescente.
Select anopublicacao, COUNT(idartigo) AS quantidade_artigos
From Artigos
Group By anopublicacao
Order By anopublicacao DESC;

-- 3 - Liste as revistas/conferências que receberam mais de 2 publicações do departamento, junto com a contagem de artigos. 
-- Foi usado o count para contar a quantidade de artigos publicados em cada revista/conferência,
-- agrupando pelo idlocal e nome, e filtrando para mostrar apenas aqueles com mais de 2 publicações.
Select rc.nomelocal, COUNT(a.idartigo) AS quantidade_artigos
From Revistas_Conferencias rc
Join Artigos a ON rc.idlocal = a.idlocal
Group By rc.idlocal, rc.nomelocal
Having COUNT(a.idartigo) > 2;