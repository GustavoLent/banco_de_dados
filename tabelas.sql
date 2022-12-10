CREATE TABLE Pessoas (
    cpf CHAR(11) NOT NULL,
    rg CHAR(10) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (cpf)
);

CREATE TABLE Enderecos (
    id INT NOT NULL,
    nome_rua VARCHAR(20) NOT NULL,
    numero_rua INT NOT NULL,
    complemento VARCHAR(15),
    bairro VARCHAR(20) NOT NULL,
    cep INT NOT NULL,
    cidade VARCHAR(15) NOT NULL,
    estado CHAR(2) NOT NULL,
    ordem_tel_1 INT NOT NULL,
    prefixo_tel_1 INT NOT NULL,
    numero_tel_1 INT NOT NULL,
    ordem_tel_2 INT,
    prefixo_tel_2 INT,
    numero_tel_2 INT,
    tipo VARCHAR(15) NOT NULL,
    pessoa CHAR(11),
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa) REFERENCES Pessoas (cpf)
);

CREATE TABLE CompradoresLocatarios (
    cpf CHAR(11) NOT NULL,
    profissao VARCHAR(20) NOT NULL,
    lista_preferencias VARCHAR(50) NOT NULL,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf) REFERENCES Pessoas (cpf)
);

CREATE TABLE Proprietarios (
    cpf CHAR(11) NOT NULL,
    estado_civil VARCHAR(15) NOT NULL,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf) REFERENCES Pessoas (cpf)
);

CREATE TABLE Corretores (
    cpf CHAR(11) NOT NULL,
    cresci VARCHAR(8) NOT NULL,
    data_admissao DATE NOT NULL,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf) REFERENCES Pessoas (cpf)
);

CREATE TABLE PrestadoresServico (
    id INT NOT NULL,
    descricao_servico VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Promessas (
    id_compradorlocatario CHAR(11) NOT NULL,
    id_corretor CHAR(11) NOT NULL,
    prioridade VARCHAR(8) NOT NULL,
    data_expiracao DATE NOT NULL,
    PRIMARY KEY (id_compradorlocatario, id_corretor),
    FOREIGN KEY (id_compradorlocatario) REFERENCES CompradoresLocatarios (cpf),
    FOREIGN KEY (id_corretor) REFERENCES Corretores (cpf)
);

CREATE TABLE Imoveis (
    inscricao VARCHAR(15) NOT NULL,
    localizacao VARCHAR(15),
    area_total INT NOT NULL,
    preco_venda DECIMAL(19,2) NOT NULL,
    preco_aluguel DECIMAL(19,2) NOT NULL,
    tipo VARCHAR(6) NOT NULL,
    endereco INT NOT NULL,
    proprietario CHAR(11) NOT NULL,
    promessa_compradorlocatario CHAR(11),
    promessa_corretor CHAR(11),
    PRIMARY KEY (inscricao),
    FOREIGN KEY (endereco) REFERENCES Enderecos (id),
    FOREIGN KEY (proprietario) REFERENCES Proprietarios (cpf),
    FOREIGN KEY (promessa_compradorlocatario, promessa_corretor) REFERENCES Promessas (id_compradorlocatario, id_corretor)
);

CREATE TABLE PrestaSerivco (
    id_prestador INT NOT NULL,
    id_imovel VARCHAR(15) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    valor_mensal DECIMAL(19,2) NOT NULL,
    PRIMARY KEY (id_prestador, id_imovel),
    FOREIGN KEY (id_prestador) REFERENCES PrestadoresServico (id),
    FOREIGN KEY (id_imovel) REFERENCES Imoveis (inscricao)
);

CREATE TABLE Edificacoes (
    id INT NOT NULL,
    area_construida INT NOT NULL,
    padrao_construcao VARCHAR(15) NOT NULL,
    habitada INT NOT NULL,
    destinacao VARCHAR(15) NOT NULL,
    imovel VARCHAR(15) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (imovel) REFERENCES Imoveis (inscricao)
);

CREATE TABLE Contratos (
    number_contrato INT NOT NULL,
    data_assinatura DATE NOT NULL,
    tipo VARCHAR(8) NOT NULL,
    comprador_locatario CHAR(11) NOT NULL,
    proprietario CHAR(11) NOT NULL,
    corretor CHAR(11) NOT NULL,
    imovel VARCHAR(15) NOT NULL,
    PRIMARY KEY (number_contrato),
    FOREIGN KEY (comprador_locatario) REFERENCES CompradoresLocatarios (cpf),
    FOREIGN KEY (proprietario) REFERENCES Proprietarios (cpf),
    FOREIGN KEY (corretor) REFERENCES Corretores (cpf),
    FOREIGN KEY (imovel) REFERENCES Imoveis (inscricao)
);