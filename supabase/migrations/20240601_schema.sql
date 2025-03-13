-- Criar tabela de usuários (extensão do auth.users)
CREATE TABLE IF NOT EXISTS public.users (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  name TEXT,
  avatar_url TEXT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Trigger para criar perfil de usuário automaticamente
CREATE OR REPLACE FUNCTION public.create_user_profile()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, name, avatar_url)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'name',
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para criar perfil quando um novo usuário é criado
DROP TRIGGER IF EXISTS create_user_profile_trigger ON auth.users;
CREATE TRIGGER create_user_profile_trigger
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.create_user_profile();

-- Tabela de locais
CREATE TABLE IF NOT EXISTS public.locations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  address TEXT,
  main_image TEXT,
  coordinates JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Tabela de histórias
CREATE TABLE IF NOT EXISTS public.stories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  location_id UUID REFERENCES public.locations(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  school TEXT,
  votes INTEGER DEFAULT 0 NOT NULL,
  views INTEGER DEFAULT 0 NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Tabela de mídia das histórias
CREATE TABLE IF NOT EXISTS public.story_media (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
  media_url TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Tabela de tags das histórias
CREATE TABLE IF NOT EXISTS public.story_tags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
  tag TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  UNIQUE(story_id, tag)
);

-- Tabela de votos
CREATE TABLE IF NOT EXISTS public.votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  UNIQUE(story_id, user_id)
);

-- Tabela de comentários
CREATE TABLE IF NOT EXISTS public.comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  reported BOOLEAN DEFAULT false NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Configurar políticas de segurança RLS (Row Level Security)

-- Habilitar RLS em todas as tabelas
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.story_media ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.story_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

-- Políticas para usuários
CREATE POLICY "Usuários podem ver todos os perfis" 
ON public.users FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários podem editar apenas seu próprio perfil" 
ON public.users FOR UPDATE 
TO authenticated 
USING (auth.uid() = id);

-- Políticas para locais
CREATE POLICY "Qualquer pessoa pode ver locais" 
ON public.locations FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Apenas administradores podem criar/editar locais" 
ON public.locations FOR INSERT 
TO authenticated 
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

-- Políticas para histórias
CREATE POLICY "Qualquer pessoa pode ver histórias" 
ON public.stories FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários autenticados podem criar histórias" 
ON public.stories FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuários podem editar apenas suas próprias histórias" 
ON public.stories FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id);

CREATE POLICY "Usuários podem excluir apenas suas próprias histórias" 
ON public.stories FOR DELETE 
TO authenticated 
USING (auth.uid() = user_id);

-- Políticas para mídia das histórias
CREATE POLICY "Qualquer pessoa pode ver mídia das histórias" 
ON public.story_media FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários autenticados podem adicionar mídia às suas histórias" 
ON public.story_media FOR INSERT 
TO authenticated 
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.stories 
    WHERE id = story_id AND user_id = auth.uid()
  )
);

CREATE POLICY "Usuários podem excluir mídia apenas de suas próprias histórias" 
ON public.story_media FOR DELETE 
TO authenticated 
USING (
  EXISTS (
    SELECT 1 FROM public.stories 
    WHERE id = story_id AND user_id = auth.uid()
  )
);

-- Políticas para tags das histórias
CREATE POLICY "Qualquer pessoa pode ver tags das histórias" 
ON public.story_tags FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários autenticados podem adicionar tags às suas histórias" 
ON public.story_tags FOR INSERT 
TO authenticated 
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.stories 
    WHERE id = story_id AND user_id = auth.uid()
  )
);

-- Políticas para votos
CREATE POLICY "Qualquer pessoa pode ver votos" 
ON public.votes FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários autenticados podem votar" 
ON public.votes FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

-- Políticas para comentários
CREATE POLICY "Qualquer pessoa pode ver comentários" 
ON public.comments FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Usuários autenticados podem comentar" 
ON public.comments FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuários podem editar apenas seus próprios comentários" 
ON public.comments FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id);

CREATE POLICY "Usuários podem excluir apenas seus próprios comentários" 
ON public.comments FOR DELETE 
TO authenticated 
USING (auth.uid() = user_id);

-- Criar buckets no Storage
INSERT INTO storage.buckets (id, name, public) 
VALUES ('story-media', 'story-media', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas para storage
CREATE POLICY "Mídia das histórias é publicamente acessível"
ON storage.objects FOR SELECT
TO anon
USING (bucket_id = 'story-media');

CREATE POLICY "Usuários autenticados podem fazer upload de mídia"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'story-media');

CREATE POLICY "Usuários podem excluir apenas sua própria mídia"
ON storage.objects FOR DELETE
TO authenticated
USING (auth.uid()::text = (storage.foldername(name))[1]); 