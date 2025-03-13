-- Função para incrementar valores em colunas
CREATE OR REPLACE FUNCTION increment(value integer, column_value integer)
RETURNS integer
LANGUAGE sql
AS $$
  SELECT value + coalesce(column_value, 0)
$$; 