-- Inserir usuários de exemplo
INSERT INTO auth.users (id, email, raw_user_meta_data, created_at)
VALUES
  (
    '00000000-0000-0000-0000-000000000001',
    'maria@exemplo.com',
    '{"name": "Maria Silva", "avatar_url": "https://i.pravatar.cc/150?img=32", "role": "admin"}',
    now()
  ),
  (
    '00000000-0000-0000-0000-000000000002',
    'joao@exemplo.com',
    '{"name": "João Pereira", "avatar_url": "https://i.pravatar.cc/150?img=59"}',
    now()
  ),
  (
    '00000000-0000-0000-0000-000000000003',
    'ana@exemplo.com',
    '{"name": "Ana Costa", "avatar_url": "https://i.pravatar.cc/150?img=44"}',
    now()
  )
ON CONFLICT (id) DO NOTHING;

-- Inserir perfis de usuários
INSERT INTO public.user_profiles (id, user_id, points, capiba_coins, created_at)
VALUES
  (
    gen_random_uuid(),
    '00000000-0000-0000-0000-000000000001',
    250,
    50,
    now()
  ),
  (
    gen_random_uuid(),
    '00000000-0000-0000-0000-000000000002',
    180,
    30,
    now()
  ),
  (
    gen_random_uuid(),
    '00000000-0000-0000-0000-000000000003',
    120,
    20,
    now()
  )
ON CONFLICT (user_id) DO NOTHING;

-- Inserir histórias de exemplo
INSERT INTO public.stories (id, title, content, location_id, user_id, school, votes, views, status, created_at)
VALUES
  (
    gen_random_uuid(),
    'Memórias do Marco Zero',
    'O Marco Zero é um dos lugares mais emblemáticos do Recife. Lembro-me de quando minha avó me contava histórias sobre como era a praça nos anos 50, quando os navios ainda atracavam bem próximos e o comércio era intenso na região. Ela dizia que as pessoas se reuniam ali para receber notícias de parentes que chegavam de longe e para celebrar datas importantes. Hoje, o local mantém sua importância histórica, mas ganhou novos significados como centro cultural e ponto de encontro para moradores e turistas.',
    (SELECT id FROM public.locations WHERE name = 'Marco Zero' LIMIT 1),
    '00000000-0000-0000-0000-000000000001',
    'Escola Municipal de Recife',
    42,
    156,
    'approved',
    now() - interval '30 days'
  ),
  (
    gen_random_uuid(),
    'A influência judaica na Rua do Bom Jesus',
    'Durante uma pesquisa escolar, descobri que a Rua do Bom Jesus já foi chamada de Rua dos Judeus e abrigou a primeira sinagoga das Américas. Meu professor de história nos levou para uma visita guiada, onde aprendemos sobre a comunidade judaica que viveu em Recife durante o período holandês. Foi fascinante ver como diferentes culturas contribuíram para a formação da identidade recifense. A arquitetura preservada nos transporta para outro tempo, permitindo imaginar como era a vida naquela época.',
    (SELECT id FROM public.locations WHERE name = 'Rua do Bom Jesus' LIMIT 1),
    '00000000-0000-0000-0000-000000000002',
    'Colégio Estadual de Pernambuco',
    38,
    122,
    'approved',
    now() - interval '25 days'
  ),
  (
    gen_random_uuid(),
    'Meu primeiro contato com o frevo no Paço',
    'Nunca vou esquecer a primeira vez que visitei o Paço do Frevo. Era carnaval e eu tinha apenas 10 anos. Fiquei maravilhada com as cores, os sons e a energia contagiante. Uma sombrinha de frevo colorida me foi dada de presente, e até hoje a guardo com carinho. Aprendi alguns passos básicos com os dançarinos que se apresentavam, e desde então o frevo se tornou parte importante da minha vida. O museu preserva essa expressão cultural tão rica e proporciona a todos a oportunidade de conhecer mais sobre essa tradição pernambucana.',
    (SELECT id FROM public.locations WHERE name = 'Paço do Frevo' LIMIT 1),
    '00000000-0000-0000-0000-000000000003',
    'Escola de Artes de Pernambuco',
    51,
    203,
    'approved',
    now() - interval '15 days'
  ),
  (
    gen_random_uuid(),
    'O esplendor da Capela Dourada',
    'A primeira vez que entrei na Capela Dourada fiquei sem palavras. A riqueza de detalhes em ouro e a perfeição das esculturas me deixaram impressionado. Meu avô, que era restaurador, participou de um projeto de conservação da capela nos anos 80 e sempre me contava sobre os segredos e técnicas utilizadas pelos artistas que a construíram. Cada visita revela novos detalhes que passaram despercebidos anteriormente. É um tesouro que todo recifense deveria conhecer e valorizar.',
    (SELECT id FROM public.locations WHERE name = 'Capela Dourada' LIMIT 1),
    '00000000-0000-0000-0000-000000000002',
    'Colégio Estadual de Pernambuco',
    27,
    98,
    'approved',
    now() - interval '10 days'
  ),
  (
    gen_random_uuid(),
    'Um dia no Instituto Ricardo Brennand',
    'Visitar o Instituto Ricardo Brennand foi uma experiência transformadora. O castelo medieval em pleno Recife já surpreende por si só, mas a coleção de arte e artefatos históricos é simplesmente espetacular. Passei horas admirando as armas antigas, pinturas e esculturas. O que mais me impressionou foi a coleção de obras de Frans Post, com suas representações do Brasil holandês. Os jardins também são belíssimos e proporcionam um momento de tranquilidade em meio à agitação da cidade.',
    (SELECT id FROM public.locations WHERE name = 'Instituto Ricardo Brennand' LIMIT 1),
    '00000000-0000-0000-0000-000000000001',
    'Escola Municipal de Recife',
    35,
    142,
    'approved',
    now() - interval '5 days'
  )
ON CONFLICT DO NOTHING;

-- Inserir tags para as histórias
INSERT INTO public.story_tags (id, story_id, tag)
SELECT 
  gen_random_uuid(),
  s.id,
  t.tag
FROM 
  public.stories s,
  (VALUES 
    ('Marco Histórico'), 
    ('Cultura'), 
    ('Arquitetura'), 
    ('Religião'),
    ('Personalidades'),
    ('Arte'),
    ('Folclore'),
    ('Carnaval')
  ) AS t(tag)
WHERE 
  s.user_id IN ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003')
  AND (
    (s.location_id = (SELECT id FROM public.locations WHERE name = 'Marco Zero' LIMIT 1) AND t.tag IN ('Marco Histórico', 'Cultura'))
    OR (s.location_id = (SELECT id FROM public.locations WHERE name = 'Rua do Bom Jesus' LIMIT 1) AND t.tag IN ('Marco Histórico', 'Religião', 'Arquitetura'))
    OR (s.location_id = (SELECT id FROM public.locations WHERE name = 'Paço do Frevo' LIMIT 1) AND t.tag IN ('Cultura', 'Folclore', 'Carnaval'))
    OR (s.location_id = (SELECT id FROM public.locations WHERE name = 'Capela Dourada' LIMIT 1) AND t.tag IN ('Arquitetura', 'Religião', 'Arte'))
    OR (s.location_id = (SELECT id FROM public.locations WHERE name = 'Instituto Ricardo Brennand' LIMIT 1) AND t.tag IN ('Arte', 'Cultura', 'Personalidades'))
  )
ON CONFLICT DO NOTHING;

-- Inserir comentários para as histórias
INSERT INTO public.comments (id, story_id, user_id, content, status, created_at)
SELECT
  gen_random_uuid(),
  s.id,
  u.id,
  c.content,
  'approved',
  now() - (random() * interval '10 days')
FROM
  public.stories s
CROSS JOIN (
  SELECT id FROM auth.users WHERE id IN (
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000002',
    '00000000-0000-0000-0000-000000000003'
  )
) u
CROSS JOIN (
  VALUES 
    ('Que história incrível! Também tenho memórias maravilhosas desse lugar.'),
    ('Nunca tinha pensado nesse local por essa perspectiva. Obrigado por compartilhar!'),
    ('Sua história me fez querer visitar esse lugar novamente. Parabéns!'),
    ('Meus avós me contavam histórias parecidas. Que bom preservar essas memórias.'),
    ('Adorei conhecer mais sobre a história desse lugar tão importante para nossa cidade.')
) AS c(content)
WHERE
  s.user_id != u.id
LIMIT 15
ON CONFLICT DO NOTHING;

-- Inserir votos para as histórias
INSERT INTO public.votes (id, story_id, user_id, created_at)
SELECT
  gen_random_uuid(),
  s.id,
  u.id,
  now() - (random() * interval '10 days')
FROM
  public.stories s
CROSS JOIN (
  SELECT id FROM auth.users WHERE id IN (
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000002',
    '00000000-0000-0000-0000-000000000003'
  )
) u
WHERE
  s.user_id != u.id
ON CONFLICT DO NOTHING; 