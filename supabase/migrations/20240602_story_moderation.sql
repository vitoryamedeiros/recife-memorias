-- Função para verificar se uma história precisa de moderação
CREATE OR REPLACE FUNCTION needs_moderation()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  moderation_enabled BOOLEAN;
BEGIN
  -- Verificar se a moderação está habilitada nas configurações do sistema
  -- Por padrão, vamos considerar que a moderação está habilitada
  moderation_enabled := TRUE;
  
  -- Verificar se o usuário atual é administrador
  IF (SELECT auth.jwt() ->> 'role' = 'admin') THEN
    -- Administradores não precisam de moderação
    RETURN FALSE;
  END IF;
  
  -- Retornar se a moderação está habilitada
  RETURN moderation_enabled;
END;
$$;

-- Trigger para definir o status da história com base na necessidade de moderação
CREATE OR REPLACE FUNCTION set_story_status()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Se a história precisa de moderação, definir status como 'pending'
  -- Caso contrário, definir como 'approved'
  IF (SELECT needs_moderation()) THEN
    NEW.status := 'pending';
  ELSE
    NEW.status := 'approved';
  END IF;
  
  RETURN NEW;
END;
$$;

-- Aplicar o trigger a novas histórias
DROP TRIGGER IF EXISTS set_story_status_trigger ON public.stories;
CREATE TRIGGER set_story_status_trigger
BEFORE INSERT ON public.stories
FOR EACH ROW
EXECUTE FUNCTION set_story_status(); 