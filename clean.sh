#!/bin/bash

# Script para limpar o projeto RecifeMemo

echo "Limpando o projeto RecifeMemo..."
echo "================================="

# Perguntar ao usuário se deseja continuar
echo "⚠️ Este script irá remover:"
echo "  - Diretório node_modules"
echo "  - Diretório dist (build)"
echo "  - Arquivos de cache (.cache, .netlify)"
echo "  - Arquivos de log (*.log)"
echo ""
echo "Os seguintes arquivos NÃO serão removidos:"
echo "  - Arquivos de código fonte"
echo "  - Arquivos de configuração (.env.local, etc.)"
echo ""
read -p "Deseja continuar? (s/n): " CONTINUE

if [ "$CONTINUE" != "s" ]; then
    echo "Operação cancelada pelo usuário."
    exit 0
fi

# Remover diretório node_modules
if [ -d "node_modules" ]; then
    echo "🗑️ Removendo diretório node_modules..."
    rm -rf node_modules
    echo "✅ Diretório node_modules removido."
else
    echo "ℹ️ Diretório node_modules não encontrado."
fi

# Remover diretório dist
if [ -d "dist" ]; then
    echo "🗑️ Removendo diretório dist..."
    rm -rf dist
    echo "✅ Diretório dist removido."
else
    echo "ℹ️ Diretório dist não encontrado."
fi

# Remover arquivos de cache
echo "🗑️ Removendo arquivos de cache..."
rm -rf .cache .netlify
echo "✅ Arquivos de cache removidos."

# Remover arquivos de log
echo "🗑️ Removendo arquivos de log..."
find . -name "*.log" -type f -delete
echo "✅ Arquivos de log removidos."

echo ""
echo "✅ Limpeza concluída!"
echo "Para reinstalar as dependências, execute: npm install"
echo "Para reconstruir o projeto, execute: npm run build" 