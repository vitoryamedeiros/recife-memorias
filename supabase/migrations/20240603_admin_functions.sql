-- Função para verificar se o usuário atual é administrador
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  is_admin BOOLEAN;
BEGIN
  -- Verificar se o usuário atual tem a role 'admin' nos metadados
  SELECT 
    (raw_user_meta_data->>'role') = 'admin' INTO is_admin
  FROM 
    auth.users
  WHERE 
    id = auth.uid();
  
  RETURN COALESCE(is_admin, false);
END;
$$;

-- Função para definir um usuário como administrador
CREATE OR REPLACE FUNCTION set_user_admin(user_id UUID, is_admin BOOLEAN)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Verificar se o usuário que está executando a função é administrador
  IF NOT (SELECT is_admin()) THEN
    RAISE EXCEPTION 'Apenas administradores podem definir outros administradores';
  END IF;
  
  -- Atualizar os metadados do usuário
  UPDATE auth.users
  SET raw_user_meta_data = 
    CASE 
      WHEN is_admin THEN 
        jsonb_set(
          COALESCE(raw_user_meta_data, '{}'::jsonb),
          '{role}',
          '"admin"'
        )
      ELSE 
        raw_user_meta_data - 'role'
    END
  WHERE id = user_id;
END;
$$;

-- Função para definir um usuário como administrador pelo email
CREATE OR REPLACE FUNCTION set_admin_by_email(email_param TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  user_id UUID;
BEGIN
  -- Encontrar o ID do usuário pelo email
  SELECT id INTO user_id
  FROM auth.users
  WHERE email = email_param;
  
  IF user_id IS NULL THEN
    RAISE EXCEPTION 'Usuário com email % não encontrado', email_param;
  END IF;
  
  -- Atualizar os metadados do usuário
  UPDATE auth.users
  SET raw_user_meta_data = 
    jsonb_set(
      COALESCE(raw_user_meta_data, '{}'::jsonb),
      '{role}',
      '"admin"'
    )
  WHERE id = user_id;
  
  RETURN TRUE;
END;
$$;

-- Tabela para armazenar configurações do sistema
CREATE TABLE IF NOT EXISTS public.system_settings (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Função para obter todas as configurações do sistema
CREATE OR REPLACE FUNCTION get_all_system_settings()
RETURNS SETOF public.system_settings
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM public.system_settings;
END;
$$;

-- Função para atualizar uma configuração do sistema
CREATE OR REPLACE FUNCTION update_system_setting(setting_key TEXT, setting_value JSONB)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Verificar se o usuário que está executando a função é administrador
  IF NOT (SELECT is_admin()) THEN
    RAISE EXCEPTION 'Apenas administradores podem atualizar configurações do sistema';
  END IF;
  
  -- Inserir ou atualizar a configuração
  INSERT INTO public.system_settings (key, value, updated_at)
  VALUES (setting_key, setting_value, now())
  ON CONFLICT (key) 
  DO UPDATE SET 
    value = setting_value,
    updated_at = now();
END;
$$; 