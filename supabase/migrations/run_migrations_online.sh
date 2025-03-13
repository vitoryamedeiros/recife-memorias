#!/bin/bash

# Script para instruções sobre como executar migrações SQL no Supabase online

echo "Instruções para executar migrações SQL para o projeto RecifeMemo no Supabase online"
echo "===================================================================================="
echo ""
echo "Para executar as migrações SQL no seu projeto Supabase, siga estas etapas:"
echo ""
echo "1. Acesse o painel do Supabase: https://supabase.com/dashboard"
echo "2. Selecione seu projeto"
echo "3. Vá para a seção 'SQL Editor'"
echo "4. Crie uma nova consulta"
echo "5. Cole o conteúdo de cada arquivo de migração na ordem abaixo e execute-os um por um:"
echo ""

# Definir variáveis
MIGRATIONS_DIR="$(dirname "$0")"

# Ordem das migrações
MIGRATIONS=(
    "20240601_schema.sql"
    "20240601_user_profiles.sql"
    "20240601_increment_function.sql"
    "20240601_admin_function.sql"
    "20240601_set_admin_function.sql"
    "20240602_admin_by_email.sql"
    "20240601_system_settings.sql"
    "20240602_story_moderation.sql"
    "20240602_comment_moderation.sql"
    "20240601_sample_locations.sql"
    "20240602_more_locations.sql"
    "20240601_sample_users.sql"
    "20240602_capiba_rewards.sql"
    "20240602_set_admin_user.sql"
)

# Listar os arquivos de migração na ordem correta
for migration in "${MIGRATIONS[@]}"; do
    if [ -f "$MIGRATIONS_DIR/$migration" ]; then
        echo "- $migration"
    else
        echo "⚠️ Arquivo não encontrado: $migration"
    fi
done

echo ""
echo "Importante: Execute os arquivos na ordem exata listada acima."
echo "Após executar todas as migrações, seu banco de dados estará configurado corretamente."
echo ""
echo "Para definir um usuário como administrador, execute o arquivo 20240602_set_admin_user.sql"
echo "ou modifique-o antes para incluir o email do usuário que deseja tornar administrador."
echo ""
echo "Boa sorte com seu projeto RecifeMemo!" 