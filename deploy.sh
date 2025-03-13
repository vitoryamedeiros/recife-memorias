#!/bin/bash

# Script para publicar o projeto RecifeMemo no Netlify

echo "Preparando o projeto RecifeMemo para publicação no Netlify..."
echo "============================================================"

# Verificar se o Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não está instalado. Por favor, instale o Node.js para continuar."
    exit 1
fi

# Verificar se o npm está instalado
if ! command -v npm &> /dev/null; then
    echo "❌ npm não está instalado. Por favor, instale o npm para continuar."
    exit 1
fi

# Verificar se o Netlify CLI está instalado
if ! command -v netlify &> /dev/null; then
    echo "⚠️ Netlify CLI não está instalado. Deseja instalar agora? (s/n)"
    read INSTALL_NETLIFY
    
    if [ "$INSTALL_NETLIFY" = "s" ]; then
        echo "📦 Instalando Netlify CLI..."
        npm install -g netlify-cli
        
        if [ $? -ne 0 ]; then
            echo "❌ Erro ao instalar Netlify CLI. Verifique os logs acima."
            exit 1
        fi
        
        echo "✅ Netlify CLI instalado com sucesso!"
    else
        echo "❌ Netlify CLI é necessário para publicar o projeto. Instalação cancelada."
        exit 1
    fi
fi

# Verificar se as dependências estão instaladas
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependências..."
    npm install
    
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao instalar dependências. Verifique os logs acima."
        exit 1
    fi
    
    echo "✅ Dependências instaladas com sucesso!"
else
    echo "✅ Dependências já instaladas."
fi

# Verificar se o arquivo .env.local existe
if [ ! -f ".env.local" ]; then
    echo "❌ Arquivo .env.local não encontrado."
    echo "Por favor, crie o arquivo .env.local com suas credenciais do Supabase antes de continuar."
    exit 1
else
    echo "✅ Arquivo .env.local encontrado."
fi

# Construir o projeto
echo "🏗️ Construindo o projeto..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Erro ao construir o projeto. Verifique os logs acima."
    exit 1
fi

echo "✅ Projeto construído com sucesso!"

# Publicar no Netlify
echo "🚀 Publicando no Netlify..."
echo "Você será solicitado a fazer login no Netlify (se ainda não estiver logado)."
echo "Pressione Enter para continuar..."
read

netlify deploy --prod

echo "✅ Processo de publicação concluído!"
echo "Lembre-se de configurar as variáveis de ambiente no painel do Netlify:"
echo "- VITE_SUPABASE_URL"
echo "- VITE_SUPABASE_ANON_KEY" 