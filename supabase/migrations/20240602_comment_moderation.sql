-- Função para verificar se um comentário precisa de moderação
CREATE OR REPLACE FUNCTION needs_comment_moderation()
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
  WHERE key = 'moderate_comments';
  
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

-- Trigger para definir o status do comentário com base na necessidade de moderação
CREATE OR REPLACE FUNCTION set_comment_status()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Se o comentário precisa de moderação, definir status como 'pending'
  -- Caso contrário, definir como 'approved'
  IF (SELECT needs_comment_moderation()) THEN
    NEW.status := 'pending';
  ELSE
    NEW.status := 'approved';
  END IF;
  
  RETURN NEW;
END;
$$;

-- Aplicar o trigger a novos comentários
DROP TRIGGER IF EXISTS set_comment_status_trigger ON public.comments;
CREATE TRIGGER set_comment_status_trigger
BEFORE INSERT ON public.comments
FOR EACH ROW
EXECUTE FUNCTION set_comment_status(); 