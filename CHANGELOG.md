# Changelog - RecifeMemo

## [1.0.0] - 2024-06-01

### Adicionado

- **Sistema de Moeda Digital Capiba**
  - Implementação da moeda digital Capiba como sistema de recompensas
  - Distribuição automática de Capibas para histórias mais votadas do mês
  - Ranking mensal de histórias com base em votos
  - Histórico de recompensas recebidas
  - Interface para visualização do saldo e histórico de Capibas

- **Exploração de Locais**
  - Nova página para explorar locais históricos e culturais de Recife
  - Busca e filtragem de locais por nome e descrição
  - Visualização detalhada de cada local com histórias relacionadas
  - Integração com o banco de dados Supabase para buscar locais reais

- **Dashboard do Usuário**
  - Redesign completo do dashboard para melhor visibilidade
  - Nova aba de ranking para visualizar competição mensal
  - Melhorias visuais com cores mais contrastantes
  - Exibição de estatísticas do usuário (pontos, ranking, histórias)

- **Banco de Dados**
  - Criação de tabela `user_profiles` com campo `capiba_coins`
  - Criação de tabela `capiba_rewards` para registro de recompensas
  - Funções SQL para distribuição automática de recompensas
  - Funções SQL para consulta de ranking e histórico de recompensas

- **Dados de Exemplo**
  - 10 locais históricos e culturais de Recife com descrições detalhadas
  - 3 usuários de exemplo com histórias e comentários
  - Histórias de exemplo para cada local com tags e votos
  - Comentários e interações entre os usuários de exemplo

### Corrigido

- Erros de lint no arquivo AdminDashboard.tsx (substituição de `any` por tipos específicos)
- Visibilidade do texto no Dashboard (melhor contraste)
- Cores dos botões para maior destaque e consistência visual
- Exibição de histórias do usuário no Dashboard

### Melhorado

- Documentação atualizada com informações sobre a moeda Capiba
- Script para execução automática de todas as migrações SQL
- Interface de usuário com melhor feedback visual
- Responsividade em dispositivos móveis

## [0.1.0] - 2024-05-15

### Adicionado

- Estrutura inicial do projeto
- Autenticação de usuários com Supabase
- Componentes básicos de UI
- Esquema inicial do banco de dados 