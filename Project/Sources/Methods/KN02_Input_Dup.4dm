//KN02_Input_Dup
//FG v202402 2024/02/07 21:00:49
//Z_KeyNValue レコード複製フォーム

//C_LONGINT($1)//ID
//$KN_id:=$1
//C_POINTER($2)
//C_LONGINT($new_KN_id)
//C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
//KN02_DefInit 
//KN02_varMode_Set ("dup")

//READ ONLY([Z_KeyNValue])
//QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
//KN02_LoadValues 

//$dlg_ok:=KN02_Display (->$new_KN_id)//OK変数の値を保持
//If ($dlg_ok#1)
	//保存はOKボタン

//End if 

//$2->:=$new_KN_id//IDを返す
//$0:=$dlg_ok
