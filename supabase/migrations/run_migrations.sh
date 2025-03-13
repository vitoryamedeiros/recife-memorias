#!/bin/bash

# Script para executar todas as migrações SQL em ordem usando psql

echo "Executando migrações SQL para o projeto RecifeMemo..."

# Definir variáveis
MIGRATIONS_DIR="$(dirname "$0")"
CURRENT_USER=$(whoami)

# Verificar se o PostgreSQL está instalado
if ! command -v psql &> /dev/null; then
    echo "Erro: psql não está instalado. Por favor, instale o PostgreSQL CLI."
    exit 1
fi

# Usar valores padrão para desenvolvimento local
echo "Usando valores padrão para desenvolvimento local..."
SUPABASE_URL="localhost"
SUPABASE_DB="postgres"
SUPABASE_USER="$CURRENT_USER"
SUPABASE_PASSWORD=""

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

echo "Este script executará as migrações SQL no banco de dados PostgreSQL local."
echo "Host: $SUPABASE_URL"
echo "Banco de dados: $SUPABASE_DB"
echo "Usuário: $SUPABASE_USER"

# Executar cada migração na ordem definida
for migration in "${MIGRATIONS[@]}"; do
    if [ -f "$MIGRATIONS_DIR/$migration" ]; then
        echo "Executando migração: $migration"
        
        # Usar o psql para executar a migração
        psql -h $SUPABASE_URL -U $SUPABASE_USER -d $SUPABASE_DB -f "$MIGRATIONS_DIR/$migration"
        
        if [ $? -eq 0 ]; then
            echo "✅ Migração $migration executada com sucesso."
        else
            echo "❌ Erro ao executar a migração $migration."
            exit 1
        fi
    else
        echo "⚠️ Arquivo de migração não encontrado: $migration"
    fi
done

echo "✅ Todas as migrações foram executadas com sucesso!"
echo "O banco de dados RecifeMemo está pronto para uso." 