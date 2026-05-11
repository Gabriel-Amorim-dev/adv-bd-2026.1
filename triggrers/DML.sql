
CREATE OR REPLACE FUNCTION atualiza_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.atualizado_em = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_before_clientes_update
BEFORE UPDATE ON clientes
FOR EACH ROW
EXECUTE FUNCTION atualiza_timestamp();

create trigger trigger_before_clientes_insert
before insert on clientes
for each row
execute function atualiza_timestamp();

insert into clientes (nome, telefone, email, endereco) values ('Joana Moreira', '(85) 92722-1229', 'joanamoreira@gmail.com', 'Avenida Nossa Senhora da Penha, s/n')


