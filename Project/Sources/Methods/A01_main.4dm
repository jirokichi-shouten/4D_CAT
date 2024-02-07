//%attributes = {}
//A01_main
//20240110 jirokichi
// メインメソッド

ON ERR CALL:C155("JCL_err_OnErrCall")
ON ERR CALL:C155("")

// メニューバーを適用
SET MENU BAR:C67(2)

// メイン画面表示
A01_DefInit

A01_Display
