//%attributes = {}
//JCL_err_OnErrCall_sql
//20240128 wat
//SQLエラーをハンドリングするためのオンエラーコール

C_TEXT:C284($1; $sql)
$sql:=$1

C_TEXT:C284(vSQL)
vSQL:=$sql

ON ERR CALL:C155("JCL_err_OnErrCall_SQL_EXECUTE")
