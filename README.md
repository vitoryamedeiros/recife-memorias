# RecifeMemo - Sistema de Histórias de Recife

RecifeMemo é uma plataforma para compartilhar histórias e memórias sobre locais históricos e culturais de Recife-PE. O sistema permite que usuários criem, compartilhem e interajam com histórias relacionadas a locais específicos da cidade.

## Publicação

Para publicar o projeto, siga os passos abaixo:

### 1. Criar um projeto Supabase

1. Acesse [https://supabase.com/dashboard](https://supabase.com/dashboard) e crie uma conta ou faça login.
2. Crie um novo projeto.
3. Anote a URL do projeto e a chave anônima (anon key).
4. Execute as migrações SQL no SQL Editor do Supabase. Os arquivos de migração estão na pasta `supabase/migrations`.

### 2. Configurar as variáveis de ambiente

1. Crie um arquivo `.env.local` na raiz do projeto com as seguintes variáveis:

```
VITE_SUPABASE_URL=https://seu-projeto.supabase.co
VITE_SUPABASE_ANON_KEY=sua-chave-anon
```

### 3. Publicar no Netlify

1. Execute o script de publicação:

```bash
./deploy.sh
```

Este script irá:
- Verificar se Node.js, npm e Netlify CLI estão instalados
- Instalar as dependências do projeto (se necessário)
- Construir o projeto
- Publicar no Netlify

Alternativamente, você pode seguir estes passos manualmente:
1. Crie uma conta no [Netlify](https://www.netlify.com/).
2. Conecte seu repositório GitHub.
3. Configure as variáveis de ambiente no Netlify:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Implante o projeto.

## Desenvolvimento local

Para executar o projeto localmente, siga os passos abaixo:

1. Clone o repositório.
2. Execute o script de inicialização:

```bash
./start.sh
```

Este script irá:
- Verificar se Node.js e npm estão instalados
- Instalar as dependências do projeto (se necessário)
- Criar um arquivo `.env.local` (se não existir)
- Iniciar o servidor de desenvolvimento

Alternativamente, você pode executar os comandos manualmente:

```bash
# Instalar dependências
npm install

# Criar arquivo .env.local (se necessário)
# Editar com suas credenciais do Supabase

# Iniciar o servidor de desenvolvimento
npm run dev
```

## Funcionalidades Principais

- **Histórias Geolocalizadas**: Compartilhe histórias vinculadas a locais específicos de Recife
- **Upload de Imagens**: Adicione fotos às suas histórias para enriquecê-las
- **Interação Social**: Comente e vote nas histórias de outros usuários
- **Exploração de Locais**: Descubra locais históricos e culturais de Recife
- **Moeda Digital Capiba**: Ganhe recompensas pelas histórias mais votadas
- **Ranking Mensal**: Competição mensal para destacar as melhores histórias
- **Painel de Administração**: Gerencie usuários, histórias, locais e configurações do sistema

## Tecnologias Utilizadas

- **Frontend**: React, TypeScript, TailwindCSS, Shadcn/UI
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Functions)
- **Bibliotecas**: React Router, React Query, Recharts, Lucide Icons

## Instalação e Configuração

### Pré-requisitos

- Node.js 18+
- npm ou yarn
- Conta no Supabase

### Configuração do Ambiente

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/recife-storyteller.git
   cd recife-storyteller
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Configure as variáveis de ambiente:
   - Crie um arquivo `.env.local` na raiz do projeto
   - Adicione as seguintes variáveis:
     ```
     VITE_SUPABASE_URL=https://seu-projeto.supabase.co
     VITE_SUPABASE_ANON_KEY=sua-chave-anon
     ```

4. Execute o projeto em modo de desenvolvimento:
   ```bash
   npm run dev
   ```

### Configuração do Supabase

1. Crie um novo projeto no Supabase
2. Execute as migrações SQL localizadas na pasta `supabase/migrations`:
   ```bash
   cd supabase/migrations
   chmod +x run_migrations.sh
   ./run_migrations.sh
   ```
3. Configure as políticas de segurança (RLS) conforme definido nas migrações
4. Configure o armazenamento para permitir upload de imagens

## Sistema de Moeda Digital Capiba

O RecifeMemo implementa um sistema de recompensas baseado na moeda digital Capiba, exclusiva da plataforma:

### Como Funciona

- **Ranking Mensal**: As histórias são classificadas com base nos votos recebidos durante o mês
- **Distribuição de Recompensas**: No início de cada mês, as histórias mais votadas do mês anterior recebem Capibas:
  - 1º Lugar: 50 Capibas
  - 2º Lugar: 30 Capibas
  - 3º Lugar: 20 Capibas
- **Utilização**: As Capibas podem ser utilizadas para destacar histórias, acessar recursos exclusivos e participar de eventos especiais

### Visualização do Ranking

- Acesse a aba "Ranking" no Dashboard para ver:
  - Ranking atual do mês
  - Histórico de recompensas recebidas
  - Saldo atual de Capibas

## Sistema de Administração

O RecifeMemo possui um sistema completo de administração para gerenciar todos os aspectos da plataforma.

### Acesso ao Painel de Administração

Para acessar o painel de administração, um usuário precisa ter permissões de administrador. O primeiro administrador deve ser definido diretamente no banco de dados:

```sql
UPDATE auth.users
SET raw_user_meta_data = raw_user_meta_data || '{"role": "admin"}'::jsonb
WHERE email = 'email-do-admin@exemplo.com';
```

### Páginas de Administração

- **Painel Principal**: Visão geral com estatísticas e acesso rápido a todas as funcionalidades
- **Gerenciamento de Locais**: Adicionar, editar e remover locais históricos e culturais
- **Gerenciamento de Histórias**: Moderar, aprovar e gerenciar histórias dos usuários
- **Gerenciamento de Usuários**: Administrar usuários e conceder permissões de administrador
- **Gerenciamento de Comentários**: Moderar e gerenciar comentários dos usuários
- **Relatórios e Estatísticas**: Visualizar dados e métricas sobre o uso da plataforma

### Configurações do Sistema

O painel de administração permite configurar aspectos importantes do sistema:

- **Registro de Usuários**: Habilitar ou desabilitar novos registros
- **Moderação de Histórias**: Exigir aprovação de administradores para novas histórias
- **Moderação de Comentários**: Exigir aprovação de administradores para novos comentários

## Estrutura do Projeto

```
recife-storyteller/
├── public/              # Arquivos públicos
├── src/                 # Código fonte
│   ├── components/      # Componentes React
│   ├── hooks/           # Hooks personalizados
│   ├── lib/             # Bibliotecas e configurações
│   ├── pages/           # Páginas da aplicação
│   ├── types/           # Definições de tipos TypeScript
│   └── App.tsx          # Componente principal
├── supabase/            # Configurações do Supabase
│   ├── functions/       # Edge Functions
│   └── migrations/      # Migrações SQL
└── README.md            # Documentação
```

## Locais Históricos Incluídos

O sistema já vem com vários locais históricos e culturais de Recife pré-cadastrados:

- **Marco Zero**: Centro histórico do Recife e ponto inicial de contagem das distâncias
- **Rua do Bom Jesus**: Antiga Rua dos Judeus, abrigou a primeira sinagoga das Américas
- **Paço do Frevo**: Museu dedicado ao frevo, Patrimônio Imaterial da Humanidade
- **Capela Dourada**: Importante monumento do barroco brasileiro
- **Instituto Ricardo Brennand**: Complexo cultural com acervo de arte e artefatos históricos
- **Oficina Cerâmica Francisco Brennand**: Museu a céu aberto com obras do artista
- **Mercado de São José**: Primeiro mercado público construído no Brasil
- **Parque das Esculturas**: Museu a céu aberto com obras de Francisco Brennand
- **Teatro de Santa Isabel**: Um dos mais importantes teatros do Brasil
- **Cais do Sertão**: Museu interativo dedicado à cultura do sertão nordestino

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Faça commit das suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Faça push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Scripts Utilitários

O projeto inclui vários scripts utilitários para facilitar o desenvolvimento e a publicação:

- **`./start.sh`**: Inicia o projeto localmente, instalando dependências se necessário.
- **`./status.sh`**: Verifica o status do projeto, incluindo dependências e configurações.
- **`./deploy.sh`**: Publica o projeto no Netlify.
- **`./clean.sh`**: Limpa o projeto, removendo dependências, build e arquivos de cache.
- **`./supabase/migrations/run_migrations_online.sh`**: Fornece instruções para executar migrações SQL no Supabase.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para mais detalhes.

## Próximos Passos

Para finalizar a configuração do projeto, siga estas etapas:

1. **Verificar o status do projeto**:
   ```bash
   ./status.sh
   ```
   Este script verifica se todas as dependências e configurações necessárias estão presentes.

2. **Criar um projeto Supabase**:
   - Acesse [https://supabase.com/dashboard](https://supabase.com/dashboard)
   - Crie um novo projeto
   - Anote a URL e a chave anônima do projeto

3. **Executar as migrações SQL**:
   - Siga as instruções do script `supabase/migrations/run_migrations_online.sh`
   - Execute cada arquivo SQL na ordem indicada no SQL Editor do Supabase

4. **Configurar as variáveis de ambiente**:
   - Atualize o arquivo `.env.local` com suas credenciais do Supabase

5. **Definir um usuário como administrador**:
   - Após criar uma conta no aplicativo, acesse a página `/set-admin`
   - Insira o email do usuário que deseja tornar administrador
   - Clique no botão "Definir como Administrador"

6. **Publicar no Netlify**:
   - Conecte seu repositório GitHub ao Netlify
   - Configure as variáveis de ambiente no Netlify
   - Implante o projeto

Após seguir esses passos, seu projeto RecifeMemo estará completamente configurado e pronto para uso!
