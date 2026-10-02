//%attributes = {}
//JCLERR_OnErrCall_stop
//旧名 JCL_err_OnErrCall_stop
//20240128 wat
//空の文字列でエラーのトラップ停止
//20240316 エラーコードを返す仕組みを追加
//20261002 Codex/wat CAT側のJCLエラー処理としてJCLERR_へ改名し、戻り値を宣言

C_LONGINT:C283($0; vJCL_ERROR)

ON ERR CALL:C155("")

$0:=vJCL_ERROR
