-- Script para definir o usuário geriofilho@gmail.com como administrador

-- Verificar se o usuário existe
DO $$
DECLARE
    user_id UUID;
BEGIN
    -- Tenta encontrar o usuário pelo email
    SELECT id INTO user_id FROM auth.users WHERE email = 'geriofilho@gmail.com';
    
    -- Se o usuário existir, define como administrador
    IF user_id IS NOT NULL THEN
        -- Atualiza o campo is_admin para true
        UPDATE auth.users SET raw_user_meta_data = 
            jsonb_set(
                COALESCE(raw_user_meta_data, '{}'::jsonb),
                '{is_admin}',
                'true'
            )
        WHERE id = user_id;
        
        RAISE NOTICE 'Usuário geriofilho@gmail.com definido como administrador com sucesso!';
    ELSE
        RAISE NOTICE 'Usuário geriofilho@gmail.com não encontrado.';
    END IF;
END $$; 