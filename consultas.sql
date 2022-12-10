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