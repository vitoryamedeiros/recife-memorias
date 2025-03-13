-- Função para verificar se um usuário é administrador

CREATE OR REPLACE FUNCTION is_admin(user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    user_role TEXT;
BEGIN
    SELECT role INTO user_role FROM auth.users WHERE id = user_id;
    RETURN user_role = 'admin';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER; 