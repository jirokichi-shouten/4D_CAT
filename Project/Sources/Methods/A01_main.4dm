//%attributes = {}
//A01_main
//20240110 jirokichi
// メインメソッド

//必要に応じてエラーハンドリング開始
//20261002 Codex/wat CAT側エラー処理のJCLERR_改名に追随
ON ERR CALL:C155("JCLERR_OnErrCall")
ON ERR CALL:C155("")

// メニューバーを適用
SET MENU BAR:C67(2)

// メイン画面表示
A01_DefInit

A01_Display
