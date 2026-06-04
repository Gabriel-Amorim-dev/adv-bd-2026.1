-- 1. Procedure: aplicar_desconto
-- Recebe o id de um produto e um percentual de desconto,
-- e atualiza o preço do produto na tabela produtos.
-- Validações:
--   - O produto existe
--   - O percentual está entre 1 e 100
--   - O preço final não fique menor que R$ 1,00

-- 2. Procedure: cadastrar_agendamento
-- Recebe o pet_id, o servico_id e a data_agendamento,
-- e insere um novo agendamento na tabela agendamentos.
-- Validações:
--   - O pet existe
--   - O serviço existe
--   - A data não é anterior à data atual

-- 3. Procedure: transferir_pet
-- Recebe o pet_id e o cliente_novo_id, e atualiza o dono
-- do pet na tabela pets.
-- Validações:
--   - O pet existe
--   - O novo cliente existe
--   - O pet não pertence já ao novo cliente

CREATE OR REPLACE PROCEDURE aplicar_desconto(
    p_produto_id  INT,
    p_percentual  NUMERIC(5, 2)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_preco_atual  NUMERIC(10, 2);
    v_preco_final  NUMERIC(10, 2);
BEGIN
    
    SELECT preco INTO v_preco_atual
    FROM produtos
    WHERE id = p_produto_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto com id % não encontrado.', p_produto_id;
    END IF;

    
    IF p_percentual < 1 OR p_percentual > 100 THEN
        RAISE EXCEPTION 'Percentual de desconto inválido: %. Deve estar entre 1 e 100.', p_percentual;
    END IF;

 
    v_preco_final := v_preco_atual - (v_preco_atual * p_percentual / 100);

   
    IF v_preco_final < 1.00 THEN
        RAISE EXCEPTION 'O preço final (R$ %) ficaria abaixo de R$ 1,00. Desconto não aplicado.', v_preco_final;
    END IF;

  
    UPDATE produtos
    SET preco = v_preco_final
    WHERE id = p_produto_id;

    RAISE NOTICE 'Desconto de %% aplicado. Preço atualizado de R$ % para R$ %.', 
        p_percentual, v_preco_atual, v_preco_final;
END;
$$;

CREATE OR REPLACE PROCEDURE cadastrar_agendamento(
    p_pet_id            INT,
    p_servico_id        INT,
    p_data_agendamento  DATE
)
LANGUAGE plpgsql AS $$
BEGIN
 
    IF NOT EXISTS (SELECT 1 FROM pets WHERE id = p_pet_id) THEN
        RAISE EXCEPTION 'Pet com id % não encontrado.', p_pet_id;
    END IF;

   
    IF NOT EXISTS (SELECT 1 FROM servicos WHERE id = p_servico_id) THEN
        RAISE EXCEPTION 'Serviço com id % não encontrado.', p_servico_id;
    END IF;

  
    IF p_data_agendamento < CURRENT_DATE THEN
        RAISE EXCEPTION 'A data de agendamento (%) não pode ser anterior à data atual (%).', 
            p_data_agendamento, CURRENT_DATE;
    END IF;

  
    INSERT INTO agendamentos (pet_id, servico_id, data_agendamento, status)
    VALUES (p_pet_id, p_servico_id, p_data_agendamento, 'pendente');

    RAISE NOTICE 'Agendamento cadastrado com sucesso para o pet % no serviço % em %.', 
        p_pet_id, p_servico_id, p_data_agendamento;
END;
$$;

CREATE OR REPLACE PROCEDURE transferir_pet(
    p_pet_id          INT,
    p_cliente_novo_id INT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_cliente_atual INT;
BEGIN
    SELECT cliente_id INTO v_cliente_atual
    FROM pets
    WHERE id = p_pet_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pet com id % não encontrado.', p_pet_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = p_cliente_novo_id) THEN
        RAISE EXCEPTION 'Cliente com id % não encontrado.', p_cliente_novo_id;
    END IF;

    IF v_cliente_atual = p_cliente_novo_id THEN
        RAISE EXCEPTION 'O pet % já pertence ao cliente %.', p_pet_id, p_cliente_novo_id;
    END IF;

   
    UPDATE pets
    SET cliente_id = p_cliente_novo_id
    WHERE id = p_pet_id;

    RAISE NOTICE 'Pet % transferido do cliente % para o cliente % com sucesso.', 
        p_pet_id, v_cliente_atual, p_cliente_novo_id;
END;
$$;
