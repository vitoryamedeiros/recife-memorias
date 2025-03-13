-- Função para definir um usuário como administrador
CREATE OR REPLACE FUNCTION set_admin(user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    success BOOLEAN;
BEGIN
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