-- Função para encontrar um usuário pelo email
CREATE OR REPLACE FUNCTION find_user_by_email(user_email TEXT)
RETURNS UUID AS $$
DECLARE
    found_user_id UUID;
BEGIN
    -- Buscar o ID do usuário pelo email
    SELECT id INTO found_user_id 
    FROM auth.users 
    WHERE email = user_email;
    
    RETURN found_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Função para definir um usuário como administrador pelo email
CREATE OR REPLACE FUNCTION set_admin_by_email(user_email TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    user_id UUID;
    success BOOLEAN;
BEGIN
    -- Encontrar o ID do usuário pelo email
    user_id := find_user_by_email(user_email);
    
    -- Verificar se o usuário foi encontrado
    IF user_id IS NULL THEN
        RAISE NOTICE 'Usuário com email % não encontrado', user_email;
        RETURN FALSE;
    END IF;
    
    -- Atualizar o campo role para 'admin'
    UPDATE auth.users 
    SET role = 'admin' 
    WHERE id = user_id;
    
    -- Verificar se a atualização foi bem-sucedida
    GET DIAGNOSTICS success = ROW_COUNT;
    
    -- Retornar verdadeiro se pelo menos uma linha foi atualizada
    RETURN success > 0;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Função para executar SQL seguro (para uso administrativo)
CREATE OR REPLACE FUNCTION execute_sql(sql_command TEXT)
RETURNS TEXT AS $$
DECLARE
    result TEXT;
BEGIN
    -- Verificar se o usuário atual é administrador
    IF NOT (SELECT auth.jwt() ->> 'role' = 'admin') THEN
        RETURN 'Erro: Apenas administradores podem executar comandos SQL';
    END IF;
    
    -- Executar o comando SQL
    EXECUTE sql_command;
    
    RETURN 'Comando SQL executado com sucesso';
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Erro ao executar SQL: ' || SQLERRM;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Função para verificar se um usuário é administrador pelo email
CREATE OR REPLACE FUNCTION is_admin_by_email(user_email TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  is_admin BOOLEAN;
BEGIN
  SELECT (raw_user_meta_data->>'role') = 'admin' INTO is_admin
  FROM auth.users
  WHERE email = user_email;
  
  RETURN COALESCE(is_admin, false);
END;
$$; 