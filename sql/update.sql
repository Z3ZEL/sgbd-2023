-- INSERT INTO $tableName ($columnNames) VALUES ($placeholders)

CREATE OR REPLACE FUNCTION public.insert_into_table(table_name text, column_names text, placeholders text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    EXECUTE format('INSERT INTO %I (%s) VALUES (%s)', table_name, column_names, placeholders);
END;
$function$
;

