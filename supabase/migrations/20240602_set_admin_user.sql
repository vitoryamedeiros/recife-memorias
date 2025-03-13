-- Definir o usuário geriofilho@gmail.com como administrador
-- Este script deve ser executado após a criação do usuário

-- Verificar se a função set_admin_by_email existe
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM pg_proc 
        WHERE proname = 'set_admin_by_email'
    ) THEN
        -- Chamar a função para definir o usuário como administrador
        PERFORM set_admin_by_email('geriofilho@gmail.com');
        
        -- Registrar a operação
        RAISE NOTICE 'Usuário geriofilho@gmail.com definido como administrador.';
    ELSE
        -- Atualizar diretamente se a função não existir
        UPDATE auth.users 
        SET role = 'admin' 
        WHERE email = 'geriofilho@gmail.com';
        
        RAISE NOTICE 'Usuário geriofilho@gmail.com definido como administrador (método alternativo).';
    END IF;
END
$$; 