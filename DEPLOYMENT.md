# Guia de Implantação - RecifeMemo

Este documento contém instruções para implantar o RecifeMemo em um ambiente de produção.

## Pré-requisitos

- Node.js 18+ e npm
- Conta no Supabase (https://supabase.com)
- Servidor web (Vercel, Netlify, ou servidor próprio)
- PostgreSQL 14+ (se hospedar o Supabase localmente)

## Configuração do Supabase

1. Crie um novo projeto no Supabase
2. Execute as migrações SQL usando o script fornecido:
   ```bash
   cd supabase/migrations
   chmod +x run_migrations.sh
   ./run_migrations.sh
   ```
   Ou execute manualmente cada arquivo SQL na ordem correta através do Editor SQL do Supabase.

3. Configure as políticas de segurança (RLS) conforme definido nos arquivos de migração.

4. Crie um usuário administrador inicial:
   ```sql
   -- No Editor SQL do Supabase
   INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, raw_user_meta_data)
   VALUES (
     gen_random_uuid(),
     'admin@recifememo.com',
     crypt('senha_segura', gen_salt('bf')),
     now(),
     '{"role": "admin"}'::jsonb
   );
   ```

## Configuração do Frontend

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/recife-storyteller.git
   cd recife-storyteller
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Crie um arquivo `.env.production` com as seguintes variáveis:
   ```
   VITE_SUPABASE_URL=https://seu-projeto.supabase.co
   VITE_SUPABASE_ANON_KEY=sua-chave-anon-publica
   VITE_GOOGLE_MAPS_API_KEY=sua-chave-api-google-maps
   ```

4. Construa o projeto para produção:
   ```bash
   npm run build
   ```

5. O resultado da build estará na pasta `dist/`.

## Implantação no Vercel

1. Instale a CLI do Vercel:
   ```bash
   npm install -g vercel
   ```

2. Faça login na sua conta Vercel:
   ```bash
   vercel login
   ```

3. Implante o projeto:
   ```bash
   vercel
   ```

4. Configure as variáveis de ambiente no painel do Vercel.

## Implantação no Netlify

1. Instale a CLI do Netlify:
   ```bash
   npm install -g netlify-cli
   ```

2. Faça login na sua conta Netlify:
   ```bash
   netlify login
   ```

3. Implante o projeto:
   ```bash
   netlify deploy --prod
   ```

4. Configure as variáveis de ambiente no painel do Netlify.

## Implantação em Servidor Próprio

1. Transfira os arquivos da pasta `dist/` para o diretório do seu servidor web.

2. Configure o servidor web (Nginx, Apache) para servir os arquivos estáticos e redirecionar todas as rotas para o `index.html`.

   Exemplo de configuração para Nginx:
   ```nginx
   server {
     listen 80;
     server_name recifememo.com www.recifememo.com;
     root /caminho/para/dist;
     
     location / {
       try_files $uri $uri/ /index.html;
     }
   }
   ```

## Manutenção

### Atualizações do Banco de Dados

Para aplicar novas migrações após a implantação inicial:

1. Adicione novos arquivos SQL na pasta `supabase/migrations`
2. Atualize o script `run_migrations.sh` para incluir os novos arquivos
3. Execute o script atualizado ou aplique manualmente as migrações

### Monitoramento

1. Configure o monitoramento de erros usando serviços como Sentry
2. Implemente logs para rastrear atividades importantes
3. Configure alertas para falhas de sistema

### Backup

1. Configure backups regulares do banco de dados Supabase
2. Armazene backups em local seguro e separado

## Solução de Problemas

### Problemas de Autenticação

- Verifique se as chaves do Supabase estão configuradas corretamente
- Confirme que as políticas RLS estão aplicadas corretamente

### Problemas de Desempenho

- Otimize as consultas SQL
- Considere adicionar índices para consultas frequentes
- Implemente cache para dados estáticos

### Erros de Aplicação

- Verifique os logs do console do navegador
- Examine os logs do servidor Supabase
- Verifique se todas as migrações foram aplicadas corretamente 