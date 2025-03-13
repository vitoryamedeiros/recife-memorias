
// User types
export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'user';
  avatar?: string;
}

export interface UserProfile {
  userId: string;
  bio?: string;
  school?: string;
  avatar?: string;
  points: number;
  achievements: string[];
}

// Location types
export interface Location {
  id: string;
  name: string;
  description: string;
  address: string;
  mainImage: string;
  gallery: string[];
  coordinates: {
    lat: number;
    lng: number;
  };
}

// Story types
export interface Story {
  id: string;
  title: string;
  content: string;
  locationId: string;
  userId: string;
  media: string[];
  votes: number;
  views: number;
  school?: string;
  tags: string[];
  createdAt: Date;
}

// Comment types
export interface Comment {
  id: string;
  storyId: string;
  content: string;
  authorName: string;
  reported: boolean;
  createdAt: Date;
}

// Achievement types
export interface Achievement {
  id: string;
  title: string;
  description: string;
  icon: string;
  type: 'votes' | 'stories' | 'views' | 'shares';
  threshold: number;
}

// Sample tags
export const tags = [
  "Marco Histórico",
  "Cultura",
  "Arquitetura",
  "Gastronomia",
  "Música",
  "Folclore",
  "Arte",
  "Religião",
  "Personalidades",
  "Eventos",
  "Festas Populares",
  "Tradições",
  "Curiosidades",
  "Lendas",
  "Carnaval",
  "Educação"
];

// Sample locations
export const locations: Location[] = [
  {
    id: "1",
    name: "Marco Zero",
    description: "O Marco Zero, na Praça Rio Branco, é o centro histórico do Recife e ponto inicial de contagem das distâncias para outras localidades de Pernambuco.",
    address: "Praça Rio Branco, s/n - Recife Antigo, Recife - PE",
    mainImage: "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932",
    gallery: [
      "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932",
      "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"
    ],
    coordinates: {
      lat: -8.0631,
      lng: -34.8711
    }
  },
  {
    id: "2",
    name: "Rua do Bom Jesus",
    description: "Antiga Rua dos Judeus, é um dos locais mais históricos do Recife, abrigando a primeira sinagoga das Américas.",
    address: "Rua do Bom Jesus - Recife Antigo, Recife - PE",
    mainImage: "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932",
    gallery: [
      "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"
    ],
    coordinates: {
      lat: -8.0631,
      lng: -34.8711
    }
  },
  {
    id: "3",
    name: "Paço do Frevo",
    description: "Museu dedicado ao frevo, expressão cultural pernambucana reconhecida como Patrimônio Imaterial da Humanidade.",
    address: "R. da Guia, 91 - Recife Antigo, Recife - PE",
    mainImage: "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932",
    gallery: [
      "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"
    ],
    coordinates: {
      lat: -8.0656,
      lng: -34.8731
    }
  },
  {
    id: "4",
    name: "Capela Dourada",
    description: "Importante monumento do barroco brasileiro, conhecida pela riqueza de detalhes em ouro.",
    address: "R. do Imperador Dom Pedro II, s/n - Santo Antônio, Recife - PE",
    mainImage: "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932",
    gallery: [
      "https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"
    ],
    coordinates: {
      lat: -8.0625,
      lng: -34.8781
    }
  }
];

// Sample stories
export const stories: Story[] = [
  {
    id: "1",
    title: "A história por trás do Marco Zero",
    content: "O Marco Zero, oficialmente Praça Rio Branco, é o centro histórico da cidade do Recife e o ponto inicial de contagem das distâncias na cidade. Foi nesta área que os portugueses iniciaram a ocupação urbana do que viria a ser o Recife, no século XVI...",
    locationId: "1",
    userId: "1",
    media: ["https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"],
    votes: 42,
    views: 156,
    school: "Escola Municipal Recife",
    tags: ["Marco Histórico", "Arquitetura"],
    createdAt: new Date("2023-09-15")
  },
  {
    id: "2",
    title: "A influência judaica na Rua do Bom Jesus",
    content: "Anteriormente conhecida como Rua dos Judeus, a Rua do Bom Jesus abrigou a primeira sinagoga das Américas. Durante o período holandês (1630-1654), Recife foi lar de uma próspera comunidade judaica...",
    locationId: "2",
    userId: "2",
    media: ["https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"],
    votes: 38,
    views: 122,
    school: "Colégio Estadual de Pernambuco",
    tags: ["Religião", "Cultura", "Marco Histórico"],
    createdAt: new Date("2023-10-02")
  },
  {
    id: "3",
    title: "Frevo: Patrimônio Cultural no Recife",
    content: "O frevo é uma expressão artística e cultural nascida em Recife no final do século XIX. Mistura de marcha, maxixe e elementos da capoeira, essa dança vibrante e enérgica é hoje Patrimônio Cultural Imaterial da Humanidade...",
    locationId: "3",
    userId: "1",
    media: ["https://images.unsplash.com/photo-1583855282680-6dbdc69b0932"],
    votes: 51,
    views: 203,
    school: "Escola Municipal Recife",
    tags: ["Cultura", "Música", "Carnaval"],
    createdAt: new Date("2023-11-20")
  }
];

// Sample user
export const currentUser: User | null = {
  id: "1",
  name: "Maria Silva",
  email: "maria@example.com",
  role: "user",
  avatar: "https://i.pravatar.cc/150?img=32"
};

// Sample user profile
export const userProfile: UserProfile = {
  userId: "1",
  bio: "Estudante de história, apaixonada pela cultura pernambucana.",
  school: "Escola Municipal Recife",
  avatar: "https://i.pravatar.cc/150?img=32",
  points: 250,
  achievements: ["1", "3"]
};

// Sample comments
export const comments: Comment[] = [
  {
    id: "1",
    storyId: "1",
    content: "Excelente conteúdo histórico! Aprendi muito com esta história.",
    authorName: "João Pereira",
    reported: false,
    createdAt: new Date("2023-09-16")
  },
  {
    id: "2",
    storyId: "1",
    content: "Minha avó me contava sobre como o Marco Zero era diferente nos anos 50. Que saudade!",
    authorName: "Ana Costa",
    reported: false,
    createdAt: new Date("2023-09-18")
  }
];

// Sample achievements
export const achievements: Achievement[] = [
  {
    id: "1",
    title: "Contador de Histórias",
    description: "Publicou sua primeira história",
    icon: "pencil",
    type: "stories",
    threshold: 1
  },
  {
    id: "2",
    title: "Historiador Iniciante",
    description: "Publicou 5 histórias",
    icon: "book",
    type: "stories",
    threshold: 5
  },
  {
    id: "3",
    title: "História Popular",
    description: "Recebeu 10 votos em uma história",
    icon: "thumbs-up",
    type: "votes",
    threshold: 10
  }
];

// Helper functions
export const getLocationById = (id: string): Location | undefined => {
  return locations.find(location => location.id === id);
};

export const getStoriesByLocationId = (locationId: string): Story[] => {
  return stories.filter(story => story.locationId === locationId);
};

export const getStoryById = (id: string): Story | undefined => {
  return stories.find(story => story.id === id);
};

export const getCommentsByStoryId = (storyId: string): Comment[] => {
  return comments.filter(comment => comment.storyId === storyId);
};

// Authentication utilities (mock)
export const isAuthenticated = (): boolean => {
  return !!currentUser;
};
