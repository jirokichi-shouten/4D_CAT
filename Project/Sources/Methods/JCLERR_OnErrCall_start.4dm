//%attributes = {}
//JCLERR_OnErrCall_start
//旧名 JCL_err_OnErrCall_start
//20240128 wat
//標準的なエラー処理
//20261002 Codex/wat CAT側のJCLエラー処理としてJCLERR_へ改名

ON ERR CALL:C155("JCLERR_OnErrCall")
