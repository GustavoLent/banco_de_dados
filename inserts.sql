INSERT INTO CompradoresLocatarios (cpf, profissao, lista_preferencias) VALUES
('11111111111', 'Marceneiro(a)', 'Sobrados'),
('22222222222', 'Engenheiro(a)', 'Com garagem'),
('33333333333', 'Vendedor(a)', 'De esquina');

INSERT INTO Contratos (number_contrato, data_assinatura, tipo, comprador_locatario, proprietario, corretor, imovel) VALUES
(1, '2022-10-04', 'Compra', '11111111111', '55555555555', '77777777777', '222222222222222'),
(2, '2022-10-04', 'Compra', '11111111111', '44444444444', '77777777777', '555555555555555'),
(3, '2022-10-04', 'Compra', '22222222222', '44444444444', '77777777777', '666666666666666'),
(4, '2022-10-04', 'Compra', '33333333333', '44444444444', '77777777777', '777777777777777'),
(5, '2022-10-04', 'Aluguel', '11111111111', '55555555555', '88888888888', '888888888888888'),
(6, '2022-10-04', 'Aluguel', '22222222222', '55555555555', '88888888888', '999999999999999');

INSERT INTO Corretores (cpf, cresci, data_admissao) VALUES
('77777777777', '11112222', '2022-11-14'),
('88888888888', '33334444', '2021-09-27');

INSERT INTO Edificacoes (id, area_construida, padrao_construcao, habitada, destinacao, imovel) VALUES
(1, 20, 'Economico', 1, 'Residencial', '333333333333333'),
(2, 30, 'Normal', 1, 'Comercial', '222222222222222');

INSERT INTO Enderecos (id, nome_rua, numero_rua, complemento, bairro, cep, cidade, estado, ordem_tel_1, prefixo_tel_1, numero_tel_1, ordem_tel_2, prefixo_tel_2, numero_tel_2, tipo, pessoa) VALUES
(1, 'Rua Silva', 1, NULL, 'Vila das Flores', 12569852, 'Campinas', 'SP', 1, 19, 12569874, NULL, NULL, NULL, 'Residencial', NULL),
(2, 'Rua Jatoba', 5, NULL, 'Jardim America', 89526789, 'Rio Claro', 'SP', 1, 19, 45688525, NULL, NULL, NULL, 'Residencial', NULL),
(3, 'Rua Jatoba', 6, NULL, 'Jardim America', 89526785, 'Rio Claro', 'SP', 1, 19, 45688524, NULL, NULL, NULL, 'Residencial', NULL),
(4, 'Rua Jatoba', 9, NULL, 'Jardim America', 89526782, 'Rio Claro', 'SP', 1, 19, 45688526, NULL, NULL, NULL, 'Residencial', NULL),
(5, 'Rua Jatoba', 11, NULL, 'Jardim America', 89526783, 'Rio Claro', 'SP', 1, 19, 45688527, NULL, NULL, NULL, 'Residencial', NULL),
(6, 'Rua Jatoba', 12, NULL, 'Jardim America', 89526784, 'Rio Claro', 'SP', 1, 19, 45688456, NULL, NULL, NULL, 'Residencial', NULL),
(7, 'Rua Jatoba', 13, NULL, 'Jardim America', 89526778, 'Rio Claro', 'SP', 1, 19, 45688544, NULL, NULL, NULL, 'Residencial', NULL),
(8, 'Rua Jatoba', 14, NULL, 'Jardim America', 89526781, 'Rio Claro', 'SP', 1, 19, 45688888, NULL, NULL, NULL, 'Residencial', NULL),
(9, 'Rua Jatoba', 15, NULL, 'Jardim America', 89526781, 'Rio Claro', 'SP', 1, 19, 45688777, NULL, NULL, NULL, 'Residencial', NULL);

INSERT INTO Imoveis (inscricao, localizacao, area_total, preco_venda, preco_aluguel, tipo, endereco, proprietario, promessa_compradorlocatario, promessa_corretor) VALUES
('111111111111111', 'Central', 120, '200000.00', '5000.00', 'Urbano', 1, '44444444444', '11111111111', '77777777777'),
('222222222222222', 'Periferica', 50, '100000.00', '1000.00', 'Urbano', 3, '55555555555', NULL, NULL),
('333333333333333', 'Central', 200, '300000.00', '3000.00', 'Urbano', 2, '55555555555', NULL, NULL),
('444444444444444', 'Periferica', 200, '100000.00', '1000.00', 'Urbano', 4, '55555555555', NULL, NULL),
('555555555555555', 'Periferica', 112, '90000.00', '900.00', 'Urbano', 5, '44444444444', NULL, NULL),
('666666666666666', 'Periferica', 112, '90000.00', '900.00', 'Urbano', 6, '44444444444', NULL, NULL),
('777777777777777', 'Periferica', 115, '91000.00', '910.00', 'Urbano', 7, '66666666666', NULL, NULL),
('888888888888888', 'Periferica', 110, '91000.00', '910.00', 'Urbano', 8, '55555555555', NULL, NULL),
('999999999999999', 'Periferica', 115, '91000.00', '910.00', 'Urbano', 9, '55555555555', NULL, NULL);

INSERT INTO Pessoas (cpf, rg, nome) VALUES
('11111111111', '1111111111', 'Joao Silva'),
('22222222222', '2222222222', 'Maria Silva'),
('33333333333', '3333333333', 'Jonas Silveira'),
('44444444444', '4444444444', 'Marta Menezes'),
('55555555555', '5555555555', 'Carlos Castro'),
('66666666666', '6666666666', 'Pietro da Fonseca'),
('77777777777', '7777777777', 'Beatriz Abreu'),
('88888888888', '8888888888', 'Cleiton Rubens');

INSERT INTO PrestadoresServico (id, descricao_servico) VALUES
(1, 'Manutenção');


INSERT INTO PrestaServico (id_prestador, id_imovel, data_inicio, data_fim, valor) VALUES
(1, '333333333333333', '2022-12-14', '2022-12-15', '200.00'),
(1, '333333333333333', '2022-12-14', '2022-12-17', '120.00');


INSERT INTO Promessas (id_compradorlocatario, id_corretor, prioridade, data_expiracao) VALUES
('11111111111', '77777777777', 'Compra', '2022-12-22');

INSERT INTO Proprietarios (cpf, estado_civil) VALUES
('44444444444', 'Casado(a)'),
('55555555555', 'Solteiro(a)'),
('66666666666', 'Viuvo(a)');