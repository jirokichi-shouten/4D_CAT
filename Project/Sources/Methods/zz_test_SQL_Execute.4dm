//%attributes = {}
//zz_test_SQL_Execute
//20240125 wat
//test for  execute generated SQL

$sql:="create table staff3(id INT32 , name varchar(20));"
$sql:="create table staff_PK(st_id INT32 PRIMARY KEY, name varchar(20));"
$sql:="create table staff_NotNull(st_id INT32 Not null, name varchar(20));"
$sql:="create table staff_UNIQUE(st_id INT32, st_name varchar(20) Not null UNIQUE);"
$sql:="create table staff_UNIQUE1(st_id INT32, st_name varchar(20) UNIQUE Not null);"
//$sql:="create table staff_NN(st_id INT32, name varchar(20) Not null);"
//$sql:="create table staff(id longint NOT NULL UNIQUE, name varchar(20));"
//$sql:="alter table staff add address text UNIQUE NOT NULL;"

//$sql:="create UNIQUE index name_idx on staff(name);"


JCL_err_OnErrCall_sql($sql)
SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
SQL EXECUTE:C820($sql)
SQL LOGOUT:C872
JCL_err_OnErrCall_stop