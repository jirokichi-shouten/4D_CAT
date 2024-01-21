//%attributes = {}
//A00_Generator
//20211228 jiro
//テーブルとフォームをジェネレートする。手動で順番に実行

//JCL_table_Generate
//JCL_prj_FormGenerator01

$sql:="create table -staff(id int PRIMARY KEY, name varchar(10));"
//$sql:="create table staff(id int NOT NULL UNIQUE, name varchar(10));"
//$sql:="alter table staff add address text UNIQUE NOT NULL;"

//$sql:="create UNIQUE index name_idx on staff(name);"

vSQL:=$sql
ON ERR CALL:C155("JCL_D02_OnErrCall_SQL_EXECUTE")
SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
SQL EXECUTE:C820($sql)
SQL LOGOUT:C872
ON ERR CALL:C155("")
