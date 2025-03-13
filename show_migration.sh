#!/bin/bash

# Script para mostrar o conteúdo de cada arquivo de migração

MIGRATIONS_DIR="supabase/migrations"

# Lista de migrações em ordem de execução
MIGRATIONS=(
    "20240601_schema.sql"
    "20240601_user_profiles.sql"
    "20240601_increment_function.sql"
    "20240601_sample_locations.sql"
    "20240602_capiba_rewards.sql"
    "20240602_more_locations.sql"
    "20240603_admin_functions.sql"
)

# Verificar se foi fornecido um número de migração
if [ -z "$1" ]; then
    echo "Por favor, forneça o número da migração (1-${#MIGRATIONS[@]})."
    echo "Exemplo: ./show_migration.sh 1"
    echo ""
    echo "Migrações disponíveis:"
    for i in "${!MIGRATIONS[@]}"; do
        echo "$(($i+1)): ${MIGRATIONS[$i]}"
    done
    exit 1
fi

# Validar o número da migração
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Por favor, forneça um número válido."
    exit 1
fi

# Calcular o índice da migração (arrays em bash começam em 0)
MIGRATION_INDEX=$(($1-1))

# Verificar se o índice é válido
if [ $MIGRATION_INDEX -lt 0 ] || [ $MIGRATION_INDEX -ge ${#MIGRATIONS[@]} ]; then
    echo "Número de migração inválido. Deve estar entre 1 e ${#MIGRATIONS[@]}."
    exit 1
fi

# Obter o nome do arquivo de migração
MIGRATION_FILE="${MIGRATIONS[$MIGRATION_INDEX]}"
MIGRATION_PATH="$MIGRATIONS_DIR/$MIGRATION_FILE"

# Verificar se o arquivo existe
if [ ! -f "$MIGRATION_PATH" ]; then
    echo "Arquivo de migração não encontrado: $MIGRATION_PATH"
    exit 1
fi

# Mostrar o conteúdo da migração
echo "==================================================================="
echo "Migração $(($MIGRATION_INDEX+1))/${#MIGRATIONS[@]}: $MIGRATION_FILE"
echo "==================================================================="
echo ""
cat "$MIGRATION_PATH"
echo "==================================================================="
echo "Copie o conteúdo acima e cole no SQL Editor do Supabase."
echo "Depois de executar, rode ./show_migration.sh $(($1+1)) para a próxima migração."
echo "===================================================================" 