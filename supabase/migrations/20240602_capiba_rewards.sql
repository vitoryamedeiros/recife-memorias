-- Função para distribuir Capibas para as histórias mais votadas do mês
CREATE OR REPLACE FUNCTION distribute_monthly_capiba_rewards()
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  first_place_story_id UUID;
  first_place_user_id UUID;
  second_place_story_id UUID;
  second_place_user_id UUID;
  third_place_story_id UUID;
  third_place_user_id UUID;
  current_month TEXT;
  reward_date TIMESTAMP WITH TIME ZONE;
BEGIN
  -- Definir o mês atual para registro
  current_month := to_char(now(), 'YYYY-MM');
  reward_date := now();
  
  -- Verificar se já foram distribuídas recompensas este mês
  IF EXISTS (
    SELECT 1 FROM public.capiba_rewards 
    WHERE reward_month = current_month
  ) THEN
    RAISE EXCEPTION 'As recompensas já foram distribuídas para o mês atual.';
  END IF;
  
  -- Encontrar as 3 histórias mais votadas do mês anterior
  WITH top_stories AS (
    SELECT 
      s.id AS story_id,
      s.user_id,
      s.title,
      COUNT(v.id) AS vote_count,
      ROW_NUMBER() OVER (ORDER BY COUNT(v.id) DESC) AS rank
    FROM 
      public.stories s
    JOIN 
      public.votes v ON s.id = v.story_id
    WHERE 
      s.status = 'approved' AND
      v.created_at >= date_trunc('month', now() - interval '1 month') AND
      v.created_at < date_trunc('month', now())
    GROUP BY 
      s.id, s.user_id, s.title
    ORDER BY 
      vote_count DESC
    LIMIT 3
  )
  SELECT 
    story_id, user_id INTO first_place_story_id, first_place_user_id
  FROM 
    top_stories
  WHERE 
    rank = 1;
  
  SELECT 
    story_id, user_id INTO second_place_story_id, second_place_user_id
  FROM 
    top_stories
  WHERE 
    rank = 2;
  
  SELECT 
    story_id, user_id INTO third_place_story_id, third_place_user_id
  FROM 
    top_stories
  WHERE 
    rank = 3;
  
  -- Distribuir Capibas para o primeiro lugar (50 Capibas)
  IF first_place_user_id IS NOT NULL THEN
    PERFORM increment_user_capiba(first_place_user_id, 50);
    
    INSERT INTO public.capiba_rewards (
      user_id, story_id, amount, reward_type, reward_month, created_at
    ) VALUES (
      first_place_user_id, first_place_story_id, 50, 'first_place', current_month, reward_date
    );
  END IF;
  
  -- Distribuir Capibas para o segundo lugar (30 Capibas)
  IF second_place_user_id IS NOT NULL THEN
    PERFORM increment_user_capiba(second_place_user_id, 30);
    
    INSERT INTO public.capiba_rewards (
      user_id, story_id, amount, reward_type, reward_month, created_at
    ) VALUES (
      second_place_user_id, second_place_story_id, 30, 'second_place', current_month, reward_date
    );
  END IF;
  
  -- Distribuir Capibas para o terceiro lugar (20 Capibas)
  IF third_place_user_id IS NOT NULL THEN
    PERFORM increment_user_capiba(third_place_user_id, 20);
    
    INSERT INTO public.capiba_rewards (
      user_id, story_id, amount, reward_type, reward_month, created_at
    ) VALUES (
      third_place_user_id, third_place_story_id, 20, 'third_place', current_month, reward_date
    );
  END IF;
END;
$$;

-- Criar tabela para registrar as recompensas de Capiba
CREATE TABLE IF NOT EXISTS public.capiba_rewards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  story_id UUID REFERENCES public.stories(id) ON DELETE CASCADE NOT NULL,
  amount INTEGER NOT NULL,
  reward_type TEXT NOT NULL,
  reward_month TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Habilitar RLS na tabela
ALTER TABLE public.capiba_rewards ENABLE ROW LEVEL SECURITY;

-- Políticas para recompensas de Capiba
CREATE POLICY "Qualquer pessoa pode ver recompensas de Capiba" 
ON public.capiba_rewards FOR SELECT 
TO authenticated, anon 
USING (true);

-- Função para obter o ranking de histórias do mês atual
CREATE OR REPLACE FUNCTION get_current_month_story_ranking()
RETURNS TABLE (
  story_id UUID,
  title TEXT,
  user_id UUID,
  user_name TEXT,
  vote_count BIGINT,
  rank BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  WITH story_votes AS (
    SELECT 
      s.id AS story_id,
      s.title,
      s.user_id,
      u.raw_user_meta_data->>'name' AS user_name,
      COUNT(v.id) AS vote_count,
      ROW_NUMBER() OVER (ORDER BY COUNT(v.id) DESC) AS rank
    FROM 
      public.stories s
    JOIN 
      auth.users u ON s.user_id = u.id
    LEFT JOIN 
      public.votes v ON s.id = v.story_id AND
      v.created_at >= date_trunc('month', now()) AND
      v.created_at < date_trunc('month', now() + interval '1 month')
    WHERE 
      s.status = 'approved'
    GROUP BY 
      s.id, s.title, s.user_id, u.raw_user_meta_data->>'name'
    ORDER BY 
      vote_count DESC
    LIMIT 10
  )
  SELECT * FROM story_votes;
END;
$$;

-- Função para obter o histórico de recompensas de Capiba
CREATE OR REPLACE FUNCTION get_capiba_reward_history(user_id_param UUID DEFAULT NULL)
RETURNS TABLE (
  reward_id UUID,
  user_id UUID,
  user_name TEXT,
  story_id UUID,
  story_title TEXT,
  amount INTEGER,
  reward_type TEXT,
  reward_month TEXT,
  created_at TIMESTAMP WITH TIME ZONE
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    r.id AS reward_id,
    r.user_id,
    u.raw_user_meta_data->>'name' AS user_name,
    r.story_id,
    s.title AS story_title,
    r.amount,
    r.reward_type,
    r.reward_month,
    r.created_at
  FROM 
    public.capiba_rewards r
  JOIN 
    auth.users u ON r.user_id = u.id
  JOIN 
    public.stories s ON r.story_id = s.id
  WHERE 
    (user_id_param IS NULL OR r.user_id = user_id_param)
  ORDER BY 
    r.created_at DESC;
END;
$$; 