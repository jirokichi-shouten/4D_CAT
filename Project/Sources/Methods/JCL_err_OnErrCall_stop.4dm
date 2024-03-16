//%attributes = {}
//JCL_err_OnErrCall_stop
//20240128 wat
//空の文字列でエラーのトラップ停止
//20240316 エラーコードを返す仕組みを追加

ON ERR CALL:C155("")

$0:=vJCL_ERROR

