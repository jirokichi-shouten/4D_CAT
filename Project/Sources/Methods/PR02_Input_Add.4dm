//PR02_Input_Add
//FG v202402 2024/02/07 20:50:34
//PASSWORD_RESETS レコード追加フォーム
//新規レコードを作成しないで、DLGでOKされたときだけOKボタンメソッドで作成する

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($PR_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

PR02_DefInit 
PR02_varMode_Set ("add")

//初期値代入
PR02_InitValues 

//画面表示
$dlg_ok:=PR02_Display ($PR_id)
If ($dlg_ok#1)
	//保存はOKボタン

End if 

$1->:=$PR_id//IDを返す
$0:=$dlg_ok
