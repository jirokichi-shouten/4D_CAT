//US02_Input_Mod
//FG v202402 2024/02/09 18:06:20
//USERS レコード編集フォーム

C_LONGINT($1;$US_id)
$US_id:=$1
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
US02_DefInit 
US02_varMode_set ("mod")
US02_varUS_ID_set ($US_id)

READ ONLY([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
US02_LoadValues 
$dlg_ok:=US02_Display ($US_id)//OK変数の値を保持
If ($dlg_ok=1)
	//保存はOKボタン

End if 

$0:=$dlg_ok
