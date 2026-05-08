-- 1 DATABASE CREATION (EXECUTE BY ITSELF)
CREATE DATABASE IF NOT EXISTS petshop;

-- 2 clientes TABLE CREATION
-- Stores customer information such as name, contact details, and address
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco VARCHAR(500),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3 especie_pet ENUM CREATION (IF OBJECT IS DUPLICATE THEN NULL)
-- Defines the allowed pet species types
DO $$ BEGIN
    CREATE TYPE especie_pet AS ENUM (
        'cachorro',
        'gato',
        'passaro',
        'peixe',
        'reptil',
        'outro'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 4 pets TABLE CREATION
-- Stores pet information and links each pet to its owner (cliente)
CREATE TABLE IF NOT EXISTS pets (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especie especie_pet NOT NULL,
    raca VARCHAR(255),
    data_nascimento DATE,
    cliente_id INTEGER NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- 5 servicos TABLE CREATION
-- Stores the services offered by the pet shop (bath, grooming, vet care, etc.)
CREATE TABLE IF NOT EXISTS servicos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6 status_agendamento ENUM CREATION (IF OBJECT IS DUPLICATE THEN NULL)
-- Defines the possible appointment statuses
DO $$ BEGIN
    CREATE TYPE status_agendamento AS ENUM (
        'agendado',
        'concluido',
        'cancelado',
        'reagendado'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 7 agendamentos TABLE CREATION
-- Stores scheduled appointments between pets and services
CREATE TABLE IF NOT EXISTS agendamentos (
    id SERIAL PRIMARY KEY,
    pet_id INTEGER NOT NULL,
    servico_id INTEGER NOT NULL,
    data_agendamento TIMESTAMP NOT NULL,
    status status_agendamento DEFAULT 'agendado',
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE,
    FOREIGN KEY (servico_id) REFERENCES servicos(id) ON DELETE CASCADE
);

-- 8 produtos TABLE CREATION
-- Stores products available for sale and inventory control
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    quantidade_estoque INTEGER NOT NULL DEFAULT 0,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9 vendas TABLE CREATION
-- Stores customer purchase records and total sale value
CREATE TABLE IF NOT EXISTS vendas (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- 10 itens_venda TABLE CREATION
-- Stores the individual products included in each sale
CREATE TABLE IF NOT EXISTS itens_venda (
    id SERIAL PRIMARY KEY,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);
