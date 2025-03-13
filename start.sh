#!/bin/bash

# Script para iniciar o projeto RecifeMemo localmente

echo "Iniciando o projeto RecifeMemo..."
echo "=================================="

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
    echo "⚠️ Arquivo .env.local não encontrado."
    echo "Criando arquivo .env.local com valores padrão..."
    
    cat > .env.local << EOF
VITE_SUPABASE_URL=https://grsfooprpyguzjmpetbh.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdyc2Zvb3BycHlndXpqbXBldGJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE4MzYwNzUsImV4cCI6MjA1NzQxMjA3NX0.oQJyCKr1JZV_ESiyyTTEzHITTVPCejckobiv_2zruY4
VITE_SUPABASE_SERVICE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdyc2Zvb3BycHlndXpqbXBldGJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE4MzYwNzUsImV4cCI6MjA1NzQxMjA3NX0.oQJyCKr1JZV_ESiyyTTEzHITTVPCejckobiv_2zruY4
EOF
    
    echo "⚠️ Por favor, edite o arquivo .env.local com suas credenciais do Supabase antes de continuar."
    echo "Pressione Enter para continuar ou Ctrl+C para cancelar..."
    read
else
    echo "✅ Arquivo .env.local encontrado."
fi

# Iniciar o servidor de desenvolvimento
echo "🚀 Iniciando o servidor de desenvolvimento..."
npm run dev

# Se o servidor for encerrado, mostrar mensagem
echo "Servidor encerrado."
echo "Para iniciar novamente, execute: npm run dev" 