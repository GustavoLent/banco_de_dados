-- 1. Quais são os imóveis (código e endereço) disponíveis para venda/aluguel num determinado bairro.
SELECT
    DISTINCT inscricao,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado
FROM
    Imoveis,
    Enderecos
WHERE
    Enderecos.bairro = 'Jardim America' AND
	Imoveis.endereco = Enderecos.codigo_endereco AND
    Imoveis.promessa_compradorlocatario IS NULL AND
    Imoveis.promessa_corretor IS NULL AND
    Imoveis.disponivel IS NOT NULL;

-- 2. Quais são os imóveis residenciais (código e endereço) disponíveis para venda/aluguel com
-- determinado tamanho (faixa da área em m2), disponíveis para negociação (pode ser
-- locação ou venda – deve aparecer no resultado o tipo da negociação).
SELECT 
    inscricao,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado,
    disponivel
FROM 
    Imoveis,
    Enderecos
WHERE
    Imoveis.disponivel IS NOT NULL AND
    Imoveis.endereco = Enderecos.codigo_endereco AND
    area_total BETWEEN 100 AND 250 AND
    Imoveis.promessa_compradorlocatario IS NULL AND
    Imoveis.promessa_corretor IS NULL AND
    Imoveis.inscricao IN (SELECT imovel FROM Edificacoes WHERE destinacao = 'Residencial');

-- 3. Quais são os imóveis (código e endereço) negociadas nos últimos 5 anos de uma
-- determinada pessoa (cliente/proprietária).
SELECT 
    c.imovel,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado
FROM 
    Contratos c,
    Imoveis,
    Enderecos
WHERE 
    data_assinatura >= '2017-12-14' AND data_assinatura <= '2022-12-14' AND
    (c.proprietario = '11111111111' OR c.comprador_locatario = '11111111111') AND
    c.imovel = Imoveis.inscricao AND
    Imoveis.endereco = Enderecos.codigo_endereco;

-- 4. Quais são os 3 clientes que mais vezes fizeram negócios com a Imobiliária?
SELECT cpf, COUNT(*) as total_negocios
FROM CompradoresLocatarios, Contratos
WHERE Contratos.comprador_locatario = cpf
GROUP BY cpf
ORDER BY total_negocios DESC
LIMIT 3;

-- 5. Quantas manutenções e o custo total das manutenções realizadas em um determinado 
-- imóvel, num determinado período?
SELECT 
    id_imovel,
    COUNT(*) as total_manutencoes,
    SUM(valor) as valor_total
FROM 
    PrestaServico JOIN PrestadoresServico
WHERE 
    data_inicio >= '2022-11-10' AND data_inicio <= '2022-12-20' AND
    ((data_fim >= '2022-11-10' AND data_fim <= '2022-12-20') OR data_fim IS NULL) AND
    id_imovel = '333333333333333' AND
    descricao_servico = 'Manutenção';

-- 6. Quem é inquilino (nome e CPF) de um determinado imóvel?
SELECT 
    p.nome, 
    p.cpf
FROM 
    Pessoas p,
    Contratos c
WHERE 
    c.imovel = '888888888888888' AND
    c.tipo = 'Aluguel' AND
    c.comprador_locatario = p.cpf AND
    (data_expiracao IS NULL OR data_expiracao >= '2022-12-13');

-- 7. Quem são os inquilinos (nome, CPF, endereço do imóvel alugado) de uma determinada pessoa (CPF – proprietário).
SELECT 
    p.nome as nome_inquilino,
    c.comprador_locatario as cpf_inquilino,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado,
    c.proprietario as cpf_proprietario
FROM 
    Pessoas p,
    Imoveis,
    Enderecos,
    Contratos c
WHERE 
    c.proprietario = '55555555555' AND
    c.tipo = 'Aluguel' AND
    c.comprador_locatario = p.cpf AND
    c.imovel = Imoveis.inscricao AND
    Imoveis.endereco = Enderecos.codigo_endereco;

-- 8. Quais são as características de um imóvel localizado num determinado endereço 
-- (área, tipo do imóvel, se tem edificação, quantos quartos e banheiros, preço de venda/aluguel, etc.)
SELECT 
    inscricao,
    localizacao,
    area_total,
    preco_venda,
    preco_aluguel,
    Imoveis.tipo,
    proprietario as cpf_proprietario,
    Edificacoes.id as edificacao
FROM 
	(Imoveis, Enderecos)
LEFT JOIN 
	Edificacoes ON Edificacoes.imovel = Imoveis.inscricao
WHERE 
	Imoveis.inscricao = '222222222222222' AND
    Imoveis.endereco = Enderecos.codigo_endereco;

-- 9. Quais são os imóveis alugados (código e endereço), quem é o inquilino (nome, CPF) e
-- quem é o proprietário (nome, CPF) de cada imóvel.
SELECT
    inscricao,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado,
    inquilino.nome AS nome_inquilino,
    inquilino.cpf AS cpf_inquilino,
    locatario.nome AS nome_proprietario,
    locatario.cpf AS cpf_proprietario
FROM
    Imoveis,
    Enderecos,
    Contratos,
    Pessoas inquilino,
    Pessoas locatario
WHERE
    Contratos.imovel = Imoveis.inscricao AND
    Contratos.tipo = 'Aluguel' AND
    Contratos.comprador_locatario = inquilino.cpf AND
    Contratos.proprietario = locatario.cpf AND
    Imoveis.endereco = Enderecos.codigo_endereco;

-- 10. Quais são os imóveis (código, tipo e endereço) disponíveis para venda num determinado
-- bairro, dentro de uma determinada faixa de preço.
SELECT 
    inscricao,
    Imoveis.tipo as tipo_imovel,
    nome_rua,
    numero_rua,
    bairro,
    cep,
    cidade,
    estado,
    preco_venda,
    Imoveis.disponivel
FROM 
    Imoveis,
    Enderecos
WHERE 
    preco_venda BETWEEN 100000.00 AND 200000.00 AND
    Imoveis.endereco = Enderecos.codigo_endereco AND
    Imoveis.promessa_compradorlocatario IS NULL AND
    Imoveis.promessa_corretor IS NULL AND
    (Imoveis.disponivel = "compra" or Imoveis.disponivel = "compra/locação");