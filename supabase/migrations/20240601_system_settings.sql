-- Tabela de configurações do sistema
CREATE TABLE IF NOT EXISTS public.system_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key TEXT NOT NULL UNIQUE,
  value JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Inserir configurações padrão
INSERT INTO public.system_settings (key, value)
VALUES 
  ('allow_registrations', 'true'::jsonb),
  ('moderate_stories', 'true'::jsonb),
  ('moderate_comments', 'true'::jsonb)
ON CONFLICT (key) DO NOTHING;

-- Função para obter uma configuração do sistema
CREATE OR REPLACE FUNCTION get_system_setting(setting_key TEXT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  setting_value JSONB;
BEGIN
  SELECT value INTO setting_value
  FROM public.system_settings
  WHERE key = setting_key;
  
  RETURN setting_value;
END;
$$;

-- Função para atualizar uma configuração do sistema
CREATE OR REPLACE FUNCTION update_system_setting(setting_key TEXT, setting_value JSONB)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Verificar se o usuário atual é administrador
  IF NOT (SELECT auth.jwt() ->> 'role' = 'admin') THEN
    RAISE EXCEPTION 'Apenas administradores podem atualizar configurações do sistema';
  END IF;
  
  -- Atualizar configuração
  INSERT INTO public.system_settings (key, value, updated_at)
  VALUES (setting_key, setting_value, now())
  ON CONFLICT (key) DO UPDATE
  SET value = setting_value, updated_at = now();
  
  RETURN TRUE;
END;
$$;

-- Função para obter todas as configurações do sistema
CREATE OR REPLACE FUNCTION get_all_system_settings()
RETURNS TABLE (key TEXT, value JSONB)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Verificar se o usuário atual é administrador
  IF NOT (SELECT auth.jwt() ->> 'role' = 'admin') THEN
    RAISE EXCEPTION 'Apenas administradores podem visualizar todas as configurações do sistema';
  END IF;
  
  RETURN QUERY
  SELECT s.key, s.value
  FROM public.system_settings s
  ORDER BY s.key;
END;
$$;

-- Atualizar a função needs_moderation para usar as configurações do sistema
CREATE OR REPLACE FUNCTION needs_moderation()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  moderation_enabled BOOLEAN;
BEGIN
  -- Verificar se a moderação está habilitada nas configurações do sistema
  SELECT (value::text)::boolean INTO moderation_enabled
  FROM public.system_settings
  WHERE key = 'moderate_stories';
  
  -- Se a configuração não existir, assumir que a moderação está habilitada
  IF moderation_enabled IS NULL THEN
    moderation_enabled := TRUE;
  END IF;
  
  -- Verificar se o usuário atual é administrador
  IF (SELECT auth.jwt() ->> 'role' = 'admin') THEN
    -- Administradores não precisam de moderação
    RETURN FALSE;
  END IF;
  
  -- Retornar se a moderação está habilitada
  RETURN moderation_enabled;
END;
$$; 