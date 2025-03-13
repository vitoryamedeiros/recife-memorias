#!/bin/bash

# Definir variáveis de conexão
DB_URL="postgresql://postgres:postgres@localhost:54322/postgres"

# Verificar se o arquivo SQL existe
if [ ! -f "check_locations_table.sql" ]; then
    echo "Arquivo check_locations_table.sql não encontrado!"
    exit 1
fi

# Executar o script SQL
echo "Executando verificação da tabela locations..."
psql "$DB_URL" -f check_locations_table.sql

echo "Verificação concluída!" 