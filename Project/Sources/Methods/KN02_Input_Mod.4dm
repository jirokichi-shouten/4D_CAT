//KN02_Input_Mod
//FG v202402 2024/02/07 21:00:49
//Z_KeyNValue レコード編集フォーム

C_LONGINT($1;$KN_id)
$KN_id:=$1
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KN02_DefInit 
KN02_varMode_set ("mod")
KN02_varKN_ID_set ($KN_id)

READ ONLY([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
KN02_LoadValues 
$dlg_ok:=KN02_Display ($KN_id)//OK変数の値を保持
If ($dlg_ok=1)
	//保存はOKボタン

End if 

$0:=$dlg_ok
