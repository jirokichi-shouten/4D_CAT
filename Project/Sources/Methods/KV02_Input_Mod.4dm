//KV02_Input_Mod
//FG v202402 2024/02/07 21:01:46
//Z_KeyValue レコード編集フォーム

C_LONGINT($1;$KV_id)
$KV_id:=$1
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KV02_DefInit 
KV02_varMode_set ("mod")
KV02_varKV_ID_set ($KV_id)

READ ONLY([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
KV02_LoadValues 
$dlg_ok:=KV02_Display ($KV_id)//OK変数の値を保持
If ($dlg_ok=1)
	//保存はOKボタン

End if 

$0:=$dlg_ok
