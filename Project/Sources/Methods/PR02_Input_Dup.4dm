//PR02_Input_Dup
//FG v202402 2024/02/11 21:27:48
//PASSWORD_RESETS レコード複製フォーム

//C_LONGINT($1)//ID
//$PR_id:=$1
//C_POINTER($2)
//C_LONGINT($new_PR_id)
//C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
//PR02_DefInit 
//PR02_varMode_Set ("dup")

//READ ONLY([PASSWORD_RESETS])
//QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
//PR02_LoadValues 

//$dlg_ok:=PR02_Display (->$new_PR_id)//OK変数の値を保持
//If ($dlg_ok#1)
	//保存はOKボタン

//End if 

//$2->:=$new_PR_id//IDを返す
//$0:=$dlg_ok
