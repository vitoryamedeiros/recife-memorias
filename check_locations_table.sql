-- Verificar se a tabela locations existe
SELECT EXISTS (
   SELECT FROM information_schema.tables 
   WHERE table_schema = 'public'
   AND table_name = 'locations'
) AS table_exists;

-- Verificar a estrutura da tabela locations
SELECT 
  column_name, 
  data_type, 
  is_nullable
FROM 
  information_schema.columns
WHERE 
  table_schema = 'public' 
  AND table_name = 'locations'
ORDER BY 
  ordinal_position;

-- Verificar as políticas de segurança da tabela locations
SELECT * FROM pg_policies WHERE tablename = 'locations';

-- Verificar se há dados na tabela locations
SELECT COUNT(*) FROM public.locations; 