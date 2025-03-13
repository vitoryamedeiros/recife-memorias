-- Inserir mais locais históricos e turísticos de Recife
INSERT INTO public.locations (id, name, description, address, main_image, coordinates, created_at)
VALUES
  (
    gen_random_uuid(),
    'Forte do Brum',
    'Construído pelos holandeses no século XVII, o Forte do Brum é um dos mais importantes monumentos militares do Brasil colonial. Sua arquitetura em forma de estrela é característica das fortificações da época. Hoje abriga o Museu Militar do Forte do Brum, com exposições sobre a história militar de Pernambuco e do Brasil.',
    'Praça da Comunidade Luso-Brasileira, s/n - Recife Antigo, Recife - PE, 50030-230',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Forte_do_Brum_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Forte_do_Brum_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0539, "lng": -34.8711}',
    now()
  ),
  (
    gen_random_uuid(),
    'Casa da Cultura',
    'Instalada em um antigo presídio do século XIX, a Casa da Cultura é hoje um importante centro de artesanato e cultura popular de Pernambuco. O edifício mantém sua arquitetura original, com celas transformadas em lojas de artesanato, onde é possível encontrar desde rendas e bordados até esculturas em madeira e cerâmica.',
    'R. Floriano Peixoto, s/n - Santo Antônio, Recife - PE, 50010-060',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Casa_da_Cultura_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Casa_da_Cultura_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0636, "lng": -34.8823}',
    now()
  ),
  (
    gen_random_uuid(),
    'Praça do Arsenal',
    'Localizada no coração do Recife Antigo, a Praça do Arsenal é um importante espaço cultural da cidade. Cercada por edifícios históricos, como o Arsenal da Marinha e a Caixa Cultural, a praça é palco de diversos eventos culturais e apresentações artísticas, especialmente durante o carnaval e outras festividades.',
    'Praça do Arsenal - Recife Antigo, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Pra%C3%A7a_do_Arsenal_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Pra%C3%A7a_do_Arsenal_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0636, "lng": -34.8716}',
    now()
  ),
  (
    gen_random_uuid(),
    'Ponte Maurício de Nassau',
    'Construída em 1643 durante o domínio holandês, a Ponte Maurício de Nassau foi a primeira ponte fixa do Brasil. Embora a estrutura atual seja uma reconstrução do século XIX, a ponte mantém sua importância histórica como símbolo da influência holandesa na cidade. Liga o bairro do Recife ao bairro de Santo Antônio, sendo um importante ponto de passagem e observação do Rio Capibaribe.',
    'Av. Alfredo Lisboa - Recife, PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Ponte_Mauricio_de_Nassau_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Ponte_Mauricio_de_Nassau_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0636, "lng": -34.8747}',
    now()
  ),
  (
    gen_random_uuid(),
    'Sinagoga Kahal Zur Israel',
    'Primeira sinagoga das Américas, a Kahal Zur Israel foi fundada em 1636 durante o período de dominação holandesa. Após séculos fechada, foi redescoberta e restaurada nos anos 2000, funcionando hoje como museu que conta a história da presença judaica no Brasil colonial. O local preserva um micvê (banho ritual judaico) original do século XVII.',
    'R. do Bom Jesus, 197 - Recife, PE, 50030-170',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Sinagoga_Kahal_Zur_Israel_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Sinagoga_Kahal_Zur_Israel_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0625, "lng": -34.8717}',
    now()
  ),
  (
    gen_random_uuid(),
    'Parque de Esculturas Francisco Brennand',
    'Museu a céu aberto com obras do artista pernambucano Francisco Brennand, localizado no Marco Zero. O parque é acessível por barco e oferece uma vista única da cidade, com esculturas monumentais que representam figuras mitológicas e simbólicas.',
    'Av. Alfredo Lisboa, s/n - Recife, PE, 50030-150',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Parque_das_Esculturas_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Parque_das_Esculturas_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0631, "lng": -34.8703}',
    now()
  ),
  (
    gen_random_uuid(),
    'Basílica e Convento de Nossa Senhora do Carmo',
    'Construído no século XVIII, o conjunto arquitetônico da Basílica e Convento do Carmo é um dos mais importantes exemplares do barroco brasileiro. A igreja impressiona pela riqueza de detalhes em sua fachada e interior, com altares dourados e painéis de azulejos portugueses. O convento anexo abriga um museu de arte sacra com peças dos períodos colonial e imperial.',
    'Av. Dantas Barreto, 646 - Santo Antônio, Recife - PE, 50010-360',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Bas%C3%ADlica_do_Carmo_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Bas%C3%ADlica_do_Carmo_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0658, "lng": -34.8811}',
    now()
  ),
  (
    gen_random_uuid(),
    'Museu Cais do Sertão',
    'Dedicado à cultura do sertão nordestino e à obra de Luiz Gonzaga, o Museu Cais do Sertão é um dos mais modernos e interativos museus do Brasil. Com 7 mil m² de área, oferece experiências sensoriais que permitem ao visitante conhecer aspectos da vida sertaneja, como a seca, a religiosidade, a música e as tradições populares.',
    'Av. Alfredo Lisboa, s/n - Recife Antigo, Recife - PE, 50030-150',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Museu_Cais_do_Sert%C3%A3o_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Museu_Cais_do_Sert%C3%A3o_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.0608, "lng": -34.8708}',
    now()
  )
ON CONFLICT DO NOTHING; 