//US02_Input_Add
//FG v202402 2024/02/07 20:51:09
//USERS レコード追加フォーム
//新規レコードを作成しないで、DLGでOKされたときだけOKボタンメソッドで作成する

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($US_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

US02_DefInit 
US02_varMode_Set ("add")

//初期値代入
US02_InitValues 

//画面表示
$dlg_ok:=US02_Display ($US_id)
If ($dlg_ok#1)
	//保存はOKボタン

End if 

$1->:=$US_id//IDを返す
$0:=$dlg_ok
