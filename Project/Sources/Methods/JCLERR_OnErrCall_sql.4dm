//%attributes = {}
//JCLERR_OnErrCall_sql
//旧名 JCL_err_OnErrCall_sql
//20240128 wat
//SQLエラーをハンドリングするためのオンエラーコール
//20240316 エラーコードを返す仕組みを追加
//20261002 Codex/wat CAT側のJCLエラー処理としてJCLERR_へ改名

C_TEXT:C284($1; $sql)
$sql:=$1

C_LONGINT:C283(vJCL_ERROR)
vJCL_ERROR:=0

C_TEXT:C284(vSQL)
vSQL:=$sql

ON ERR CALL:C155("JCLERR_OnErrCall_SQL_EXECUTE")
