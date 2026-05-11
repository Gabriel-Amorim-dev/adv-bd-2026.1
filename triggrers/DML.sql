-- DML (Data Manipulation Language) is a group of SQL commands used to manipulate data stored in database tables.
-- Common DML operations include INSERT, UPDATE, DELETE, and SELECT.
-- In this example, we are using INSERT to add new data into the clientes table,
-- and also using TRIGGERS together with a FUNCTION to automatically update timestamps whenever data is inserted or updated.

-- 1 First, we are creating a function called atualiza_timestamp.
-- This function automatically updates the column atualizado_em with the current date and time.

CREATE OR REPLACE FUNCTION atualiza_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.atualizado_em = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2 Now we are creating a trigger called trigger_before_clientes_update.
-- This trigger executes the function before any UPDATE operation happens in the clientes table.

CREATE TRIGGER trigger_before_clientes_update
BEFORE UPDATE ON clientes
FOR EACH ROW
EXECUTE FUNCTION atualiza_timestamp();

-- 3 Here we are creating another trigger called trigger_before_clientes_insert.
-- This trigger executes the same function before any INSERT operation happens in the clientes table,
-- ensuring that the timestamp is automatically filled when a new client is registered.

CREATE TRIGGER trigger_before_clientes_insert
BEFORE INSERT ON clientes
FOR EACH ROW
EXECUTE FUNCTION atualiza_timestamp();

-- 4 Finally, we are inserting a new record into the clientes table.
-- The trigger will automatically set the atualizado_em column with the current timestamp.

INSERT INTO clientes (nome, telefone, email, endereco)
VALUES (
    'Joana Moreira',
    '(85) 92722-1229',
    'joanamoreira@gmail.com',
    'Avenida Nossa Senhora da Penha, s/n'
);
