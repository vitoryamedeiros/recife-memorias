#!/bin/bash

# Script para verificar o status do projeto RecifeMemo

echo "Verificando o status do projeto RecifeMemo..."
echo "============================================="

# Verificar se o Node.js está instalado
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js instalado: $NODE_VERSION"
else
    echo "❌ Node.js não está instalado."
fi

# Verificar se o npm está instalado
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    echo "✅ npm instalado: $NPM_VERSION"
else
    echo "❌ npm não está instalado."
fi

# Verificar se as dependências estão instaladas
if [ -d "node_modules" ]; then
    NODE_MODULES_COUNT=$(find node_modules -type f | wc -l)
    echo "✅ Dependências instaladas: $NODE_MODULES_COUNT arquivos"
else
    echo "❌ Dependências não instaladas."
fi

# Verificar se o arquivo .env.local existe
if [ -f ".env.local" ]; then
    ENV_VARS_COUNT=$(grep -c "=" .env.local)
    echo "✅ Arquivo .env.local encontrado: $ENV_VARS_COUNT variáveis"
    
    # Verificar se as variáveis necessárias estão definidas
    if grep -q "VITE_SUPABASE_URL" .env.local && grep -q "VITE_SUPABASE_ANON_KEY" .env.local; then
        echo "  ✅ Variáveis do Supabase configuradas"
    else
        echo "  ⚠️ Variáveis do Supabase não configuradas corretamente"
    fi
else
    echo "❌ Arquivo .env.local não encontrado."
fi

# Verificar se o Netlify CLI está instalado
if command -v netlify &> /dev/null; then
    NETLIFY_VERSION=$(netlify --version | head -n 1)
    echo "✅ Netlify CLI instalado: $NETLIFY_VERSION"
else
    echo "⚠️ Netlify CLI não está instalado."
fi

# Verificar se o Supabase CLI está instalado
if command -v supabase &> /dev/null; then
    SUPABASE_VERSION=$(supabase --version)
    echo "✅ Supabase CLI instalado: $SUPABASE_VERSION"
else
    echo "⚠️ Supabase CLI não está instalado."
fi

# Verificar se o servidor de desenvolvimento está rodando
if pgrep -f "vite" > /dev/null; then
    echo "✅ Servidor de desenvolvimento está rodando"
else
    echo "⚠️ Servidor de desenvolvimento não está rodando"
fi

# Verificar se o diretório dist existe (build)
if [ -d "dist" ]; then
    DIST_FILES_COUNT=$(find dist -type f | wc -l)
    echo "✅ Build encontrado: $DIST_FILES_COUNT arquivos"
else
    echo "⚠️ Build não encontrado (diretório dist não existe)"
fi

echo ""
echo "Status do projeto: RecifeMemo"
echo "Diretório: $(pwd)"
echo "Data: $(date)" 