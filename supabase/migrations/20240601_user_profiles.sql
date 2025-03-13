-- Criar tabela de perfis de usuário
CREATE TABLE IF NOT EXISTS public.user_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  bio TEXT,
  school TEXT,
  points INTEGER DEFAULT 0 NOT NULL,
  capiba_coins INTEGER DEFAULT 0 NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Habilitar RLS na tabela
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

-- Políticas para perfis de usuário
CREATE POLICY "Qualquer pessoa pode ver perfis de usuário" 
ON public.user_profiles FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários podem editar apenas seu próprio perfil" 
ON public.user_profiles FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id);

-- Função para incrementar pontos do usuário
CREATE OR REPLACE FUNCTION increment_user_points(user_id_param UUID, points_to_add INTEGER)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.user_profiles (user_id, points)
  VALUES (user_id_param, points_to_add)
  ON CONFLICT (user_id) 
  DO UPDATE SET 
    points = public.user_profiles.points + points_to_add,
    updated_at = now();
END;
$$;

-- Função para incrementar capiba_coins do usuário
CREATE OR REPLACE FUNCTION increment_user_capiba(user_id_param UUID, coins_to_add INTEGER)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.user_profiles (user_id, capiba_coins)
  VALUES (user_id_param, coins_to_add)
  ON CONFLICT (user_id) 
  DO UPDATE SET 
    capiba_coins = public.user_profiles.capiba_coins + coins_to_add,
    updated_at = now();
END;
$$;

-- Trigger para criar perfil de usuário automaticamente
CREATE OR REPLACE FUNCTION public.create_user_profile_record()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (user_id)
  VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para criar perfil quando um novo usuário é criado
DROP TRIGGER IF EXISTS create_user_profile_record_trigger ON auth.users;
CREATE TRIGGER create_user_profile_record_trigger
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.create_user_profile_record(); 