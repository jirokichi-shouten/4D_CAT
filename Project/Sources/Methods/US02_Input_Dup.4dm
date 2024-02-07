//US02_Input_Dup
//FG v202402 2024/02/07 20:51:08
//USERS レコード複製フォーム

//C_LONGINT($1)//ID
//$US_id:=$1
//C_POINTER($2)
//C_LONGINT($new_US_id)
//C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
//US02_DefInit 
//US02_varMode_Set ("dup")

//READ ONLY([USERS])
//QUERY([USERS];[USERS]US_ID=$US_id)
//US02_LoadValues 

//$dlg_ok:=US02_Display (->$new_US_id)//OK変数の値を保持
//If ($dlg_ok#1)
	//保存はOKボタン

//End if 

//$2->:=$new_US_id//IDを返す
//$0:=$dlg_ok
