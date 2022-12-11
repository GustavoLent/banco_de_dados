-- Exercicio 1
SELECT inscricao, nome_rua, numero_rua, bairro, cep, cidade, estado
FROM Imoveis JOIN Enderecos
WHERE Enderecos.bairro = 'Bairro XYZ'

-- Exercicio 2 Quais são os imóveis residenciais (código e endereço) disponíveis para venda/aluguel com
-- determinado tamanho (faixa da área em m2), disponíveis para negociação (pode ser
-- locação ou venda – deve aparecer no resultado o tipo da negociação).
SELECT inscricao, nome_rua, numero_rua, bairro, cep, cidade, estado
FROM Imoveis, Enderecos, Edificacoes
WHERE area_total BETWEEN 10 AND 20 AND
    Imoveis.endereco = Enderecos.id AND
    Imoveis.promessa_compradorlocatario IS NULL AND
    Imoveis.promessa_corretor IS NULL AND
    Imoveis.inscricao IN 
    (SELECT imovel
    FROM Edificacoes JOIN Imoveis
    WHERE destinacao = 'Residencial') AND
    NOT EXISTS 
    (SELECT * FROM Contratos WHERE imovel = inscricao)

-- Exercicio 3 Quais são os imóveis (código e endereço) negociadas nos últimos 5 anos de uma
-- determinada pessoa (cliente/proprietária).
SELECT c.imovel, nome_rua, numero_rua, bairro, cep, cidade, estado
FROM Contratos c JOIN Imoveis JOIN Enderecos, Pessoas
WHERE data_assinatura >= '2017-12-14' AND data_assinatura <= '2022-12-14' AND
    (c.proprietario = '12345678920' OR
    c.comprador_locatario = '12345678920'
    )

-- Exercicio 4 Quais são os 3 clientes que mais vezes fizeram negócios com a Imobiliária?
SELECT cpf, COUNT(*) as total_negocios
FROM CompradoresLocatarios, Contratos
WHERE Contratos.comprador_locatario = cpf
GROUP BY cpf
ORDER BY total_negocios
LIMIT 3

-- Exercicio 5 Quantas manutenções e o custo total das manutenções realizadas em um determinado 
-- imóvel, num determinado período?
SELECT id_imovel, COUNT(*) as total_manutencoes, SUM(valor) as valor_total
FROM PrestaSerivco JOIN PrestadoresServico
WHERE data_inicio >= '2022/11/10' AND data_inicio <= '2022/11/20' AND
    ((data_fim >= '2022/11/10' AND data_fim <= '2022/11/20') OR data_fim IS NULL) AND
    id_imovel = '123456789123456'

-- Exercicio 6
SELECT p.nome, p.cpf
FROM Pessoas p, Contratos c
WHERE c.imovel = '123456789123456' AND
    c.tipo = 'Aluguel' AND
    c.comprador_locatario = p.cpf

-- Exercicio 7
SELECT p.nome as nome_inquilino, c.cpf as cpf_inquilino, nome_rua, numero_rua, bairro, cep, cidade, estado, c.proprietario as cpf_proprietario
FROM Pessoas p, Enderecos, Contratos c
WHERE c.proprietario = '12345678920' AND
    c.tipo = 'Aluguel' AND
    c.comprador_locatario = p.cpf

-- Exercicio 8 Quais são as características de um imóvel localizado num determinado endereço (área,
-- tipo do imóvel, se tem edificação, quantos quartos e banheiros, preço de venda/aluguel,
-- etc.)
SELECT inscricao, localizacao, area_total, preco_venda, preco_aluguel, tipo, proprietario as cpf_proprietario, Edificacoes.id as edificacao
FROM (Imoveis JOIN Enderecos) RIGHT JOIN Edificacoes
WHERE nome_rua = 'Rua Alfeneiros' AND
    numero_rua = 5 AND
    bairro = 'Vila das Flores' AND
    cep = '13123895' AND
    cidade = 'Rio Claro' AND
    estado = 'SP'

-- Exercicio 9 Quais são os imóveis alugados (código e endereço), quem é o inquilino (nome, CPF) e
-- quem é o proprietário (nome, CPF) de cada imóvel.
SELECT inscricao, nome_rua, numero_rua, bairro, cep, cidade, estado,
cl.nome AS nome_inquilino, cl.cpf AS cpf_inquilino, p.nome AS nome_proprietario, p.cpf AS cpf_proprietario
FROM Imoveis JOIN Enderecos, Contratos, Pessoas as cl, Pessoal as p
WHERE Contratos.imovel = inscricao AND
    Contratos.tipo = 'Aluguel' AND
    Contratos.comprador_locatario = cl.cpf AND
    Contratos.proprietario = p.cpf


-- Exercicio 10 Quais são os imóveis (código, tipo e endereço) disponíveis para venda num determinado
-- bairro, dentro de uma determinada faixa de preço.
SELECT inscricao, Imoveis.tipo as tipo_imovel, nome_rua, numero_rua, bairro, cep, cidade, estado, preco_venda
FROM Imoveis, Enderecos
WHERE preco_venda BETWEEN 100000.00 AND 200000.00 AND
    Imoveis.endereco = Enderecos.id AND
    Imoveis.promessa_compradorlocatario IS NULL AND
    Imoveis.promessa_corretor IS NULL AND
    Imoveis.inscricao IN 
    NOT EXISTS 
    (SELECT * FROM Contratos WHERE imovel = inscricao)