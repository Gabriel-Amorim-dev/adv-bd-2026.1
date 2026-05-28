-- 1. Crie uma trigger que impeça o cancelamento de um agendamento que já foi
--concluído na tabela agendamentos. Se o status já for concluido, a trigger deve
--lançar um erro informando que não é possível cancelar.

-- 2. Crie uma trigger que registre na tabela log_transferencias_pets sempre que
--um pet for transferido de cliente na tabela pets, salvando o pet_id, o
--cliente_anterior e o cliente_novo e a data_transferencia.

-- 3. Crie uma trigger que gere uma entrada na tabela log_produtos_deletados
--sempre que um produto for deletado da tabela produtos, salvando o
--produto_id, o nome e o preco do produto deletado.

CREATE TABLE log_transferencias_pets (
    id                  SERIAL PRIMARY KEY,
    pet_id              INT,
    cliente_anterior    INT,
    cliente_novo        INT,
    data_transferencia  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE log_produtos_deletados (
    id          SERIAL PRIMARY KEY,
    produto_id  INT,
    nome        VARCHAR(255),
    preco       NUMERIC(10, 2),
    deletado_em TIMESTAMP DEFAULT NOW()
);

-- 1:
CREATE OR REPLACE FUNCTION fn_bloqueia_cancelamento()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status = 'concluido' AND NEW.status = 'cancelado' THEN
        RAISE EXCEPTION 'Não é possível cancelar um agendamento já concluído.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_bloqueia_cancelamento
BEFORE UPDATE ON agendamentos
FOR EACH ROW
EXECUTE FUNCTION fn_bloqueia_cancelamento();

--2:
CREATE OR REPLACE FUNCTION fn_log_transferencia_pet()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.cliente_id IS DISTINCT FROM NEW.cliente_id THEN
        INSERT INTO log_transferencias_pets (pet_id, cliente_anterior, cliente_novo, data_transferencia)
        VALUES (OLD.id, OLD.cliente_id, NEW.cliente_id, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_transferencia_pet
AFTER UPDATE ON pets
FOR EACH ROW
EXECUTE FUNCTION fn_log_transferencia_pet();

--3:
CREATE OR REPLACE FUNCTION fn_log_produto_deletado()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_produtos_deletados (produto_id, nome, preco)
    VALUES (OLD.id, OLD.nome, OLD.preco);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_produto_deletado
AFTER DELETE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_log_produto_deletado();
