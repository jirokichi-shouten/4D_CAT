//%attributes = {}
//JCL_D00_Generator
//20240328 Jirokichi
//ジェネレータメイン画面

////必要に応じてエラーハンドリング開始
//ON ERR CALL("JCL_err_OnErrCall")
//ON ERR CALL("")

//// メニューバーを適用
//SET MENU BAR(2)

// ジェネレータメイン画面表示
//D00_Display
C_OBJECT:C1216(vD00)

vD00:=cs:C1710.JCL_D00.new()
$dlgOk:=vD00.display()
