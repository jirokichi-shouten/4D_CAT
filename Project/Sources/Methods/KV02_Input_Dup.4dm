//KV02_Input_Dup
//FG v202402 2024/02/09 18:05:58
//Z_KeyValue レコード複製フォーム

//C_LONGINT($1)//ID
//$KV_id:=$1
//C_POINTER($2)
//C_LONGINT($new_KV_id)
//C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
//KV02_DefInit 
//KV02_varMode_Set ("dup")

//READ ONLY([Z_KeyValue])
//QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
//KV02_LoadValues 

//$dlg_ok:=KV02_Display (->$new_KV_id)//OK変数の値を保持
//If ($dlg_ok#1)
	//保存はOKボタン

//End if 

//$2->:=$new_KV_id//IDを返す
//$0:=$dlg_ok
