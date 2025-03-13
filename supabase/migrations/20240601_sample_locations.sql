-- Inserir locais históricos e culturais do Recife
INSERT INTO public.locations (id, name, description, address, main_image, coordinates, created_at, updated_at)
VALUES
  (
    gen_random_uuid(),
    'Marco Zero',
    'O Marco Zero é o ponto inicial de contagem das distâncias na cidade do Recife. Localizado na Praça Rio Branco, no Bairro do Recife (Recife Antigo), é um dos pontos turísticos mais importantes da cidade. A praça abriga a escultura "Rosa dos Ventos", do artista plástico Cícero Dias, e é cercada por edifícios históricos, como a Associação Comercial de Pernambuco e o prédio da Bolsa de Valores.',
    'Praça Rio Branco, Bairro do Recife, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Marco_Zero_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Marco_Zero_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.063099, "lng": -34.871128}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Rua do Bom Jesus',
    'Antiga Rua dos Judeus, é uma das ruas mais históricas do Recife Antigo. Foi o centro da primeira comunidade judaica das Américas durante o período da ocupação holandesa (1630-1654). Hoje, é uma rua charmosa com casarões coloridos, bares, restaurantes e lojas. A rua abriga a Sinagoga Kahal Zur Israel, a primeira das Américas.',
    'Rua do Bom Jesus, Bairro do Recife, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Rua_do_Bom_Jesus_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Rua_do_Bom_Jesus_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.062222, "lng": -34.870833}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Paço do Frevo',
    'O Paço do Frevo é um espaço cultural dedicado à difusão, pesquisa e preservação do frevo, ritmo pernambucano declarado Patrimônio Imaterial da Humanidade pela UNESCO. Localizado em um antigo casarão no Bairro do Recife, o museu conta com exposições permanentes e temporárias, além de oferecer oficinas e apresentações de dança e música.',
    'Praça do Arsenal, Bairro do Recife, Recife - PE',
    'https://www.pacodofrevo.org.br/wp-content/uploads/2022/01/paco-do-frevo-fachada-1.jpg',
    '{"lat": -8.061944, "lng": -34.871389}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Capela Dourada',
    'A Capela Dourada, oficialmente Capela dos Noviços da Ordem Terceira de São Francisco, é uma das mais importantes expressões do barroco brasileiro. Construída entre 1696 e 1724, seu interior é ricamente decorado com talha dourada, pinturas e azulejos portugueses. É considerada uma das igrejas mais ricas em ornamentação do Brasil.',
    'Rua do Imperador Dom Pedro II, Santo Antônio, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Capela_Dourada_Recife_Pernambuco_Brasil.jpg/1200px-Capela_Dourada_Recife_Pernambuco_Brasil.jpg',
    '{"lat": -8.062778, "lng": -34.879444}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Instituto Ricardo Brennand',
    'O Instituto Ricardo Brennand é um complexo cultural que abriga um dos mais importantes acervos de arte e artefatos históricos do Brasil. Fundado pelo colecionador pernambucano Ricardo Brennand, o instituto está localizado em um castelo medieval construído especialmente para abrigar a coleção. Destaca-se pelo acervo de armas brancas, pinturas e objetos relacionados ao período colonial brasileiro.',
    'Alameda Antônio Brennand, s/n, Várzea, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Instituto_Ricardo_Brennand_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Instituto_Ricardo_Brennand_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.066667, "lng": -34.965556}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Oficina Cerâmica Francisco Brennand',
    'A Oficina Cerâmica Francisco Brennand é um museu a céu aberto criado pelo artista plástico pernambucano Francisco Brennand. Instalada em uma antiga olaria, a Oficina abriga milhares de esculturas, painéis e objetos de cerâmica criados pelo artista, além de jardins e edificações que compõem um ambiente único. É considerado um dos mais importantes espaços de arte contemporânea do Brasil.',
    'Propriedade Santos Cosme e Damião, s/n, Várzea, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Oficina_Brennand_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Oficina_Brennand_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.068889, "lng": -34.965278}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Mercado de São José',
    'O Mercado de São José é o primeiro mercado público construído no Brasil, inaugurado em 1875. Com sua estrutura de ferro importada da Europa, o mercado é um importante exemplo da arquitetura do século XIX. Hoje, é um centro vibrante de comércio popular, onde se encontram artesanato, ervas medicinais, frutas, verduras e produtos típicos da culinária pernambucana.',
    'Praça Dom Vital, s/n, São José, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Mercado_de_S%C3%A3o_Jos%C3%A9_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Mercado_de_S%C3%A3o_Jos%C3%A9_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.069722, "lng": -34.880833}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Parque das Esculturas Francisco Brennand',
    'O Parque das Esculturas Francisco Brennand é um museu a céu aberto localizado em um molhe de pedras na Bacia do Pina, em frente ao Marco Zero. Inaugurado em 2000, o parque abriga 90 esculturas em cerâmica do artista pernambucano Francisco Brennand, incluindo a emblemática "Torre de Cristal", com 32 metros de altura. O acesso ao parque é feito por barco, a partir do Marco Zero.',
    'Av. Alfredo Lisboa, s/n, Bairro do Recife, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Parque_das_Esculturas_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Parque_das_Esculturas_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.062778, "lng": -34.868889}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Teatro de Santa Isabel',
    'O Teatro de Santa Isabel é um dos mais importantes teatros do Brasil, inaugurado em 1850. Projetado pelo engenheiro francês Louis Léger Vauthier, o teatro é um belo exemplo da arquitetura neoclássica. Ao longo de sua história, o Teatro de Santa Isabel foi palco de importantes eventos culturais e políticos, incluindo a campanha abolicionista liderada por Joaquim Nabuco.',
    'Praça da República, s/n, Santo Antônio, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Teatro_Santa_Isabel_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Teatro_Santa_Isabel_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.062500, "lng": -34.881111}',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Cais do Sertão',
    'O Cais do Sertão é um museu interativo dedicado à cultura do sertão nordestino e à obra do músico Luiz Gonzaga, o Rei do Baião. Localizado no Bairro do Recife, o museu utiliza recursos tecnológicos para proporcionar uma experiência imersiva sobre a vida, a música e as tradições do sertão. O espaço conta com exposições permanentes e temporárias, além de áreas para shows e eventos culturais.',
    'Av. Alfredo Lisboa, s/n, Bairro do Recife, Recife - PE',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Cais_do_Sert%C3%A3o_-_Recife%2C_Pernambuco%2C_Brasil.jpg/1200px-Cais_do_Sert%C3%A3o_-_Recife%2C_Pernambuco%2C_Brasil.jpg',
    '{"lat": -8.060833, "lng": -34.870556}',
    now(),
    now()
  ); 