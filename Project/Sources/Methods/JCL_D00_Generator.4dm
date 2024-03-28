//%attributes = {}
//JCL_D00_Generator
//20240328 Jirokichi
//ジェネレータメイン画面

//必要に応じてエラーハンドリング開始
ON ERR CALL:C155("JCL_err_OnErrCall")
ON ERR CALL:C155("")

// メニューバーを適用
SET MENU BAR:C67(2)

// メイン画面表示

D00_Display
