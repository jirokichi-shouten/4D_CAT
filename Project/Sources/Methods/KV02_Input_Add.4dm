//KV02_Input_Add
//FG v202402 2024/02/09 18:05:59
//Z_KeyValue レコード追加フォーム
//新規レコードを作成しないで、DLGでOKされたときだけOKボタンメソッドで作成する

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($KV_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

KV02_DefInit 
KV02_varMode_Set ("add")

//初期値代入
KV02_InitValues 

//画面表示
$dlg_ok:=KV02_Display ($KV_id)
If ($dlg_ok#1)
	//保存はOKボタン

End if 

$1->:=$KV_id//IDを返す
$0:=$dlg_ok
