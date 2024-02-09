//KN02_Input_Add
//FG v202402 2024/02/09 18:04:40
//Z_KeyNValue レコード追加フォーム
//新規レコードを作成しないで、DLGでOKされたときだけOKボタンメソッドで作成する

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($KN_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

KN02_DefInit 
KN02_varMode_Set ("add")

//初期値代入
KN02_InitValues 

//画面表示
$dlg_ok:=KN02_Display ($KN_id)
If ($dlg_ok#1)
	//保存はOKボタン

End if 

$1->:=$KN_id//IDを返す
$0:=$dlg_ok
