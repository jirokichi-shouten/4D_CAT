//%attributes = {}
//JCL_D00_Generator
//20240328 Jirokichi
//ジェネレータメイン画面

////必要に応じてエラーハンドリング開始
//ON ERR CALL("JCL_err_OnErrCall")
//ON ERR CALL("")

//// メニューバーを適用
SET MENU BAR:C67(2)

// ジェネレータメイン画面表示
//D00_Display
C_OBJECT:C1216($d00)

$d00:=cs:C1710.JCL_D00.new()
