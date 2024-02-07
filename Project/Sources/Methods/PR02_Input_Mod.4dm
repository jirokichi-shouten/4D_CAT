//PR02_Input_Mod
//FG v202402 2024/02/07 20:50:34
//PASSWORD_RESETS レコード編集フォーム

C_LONGINT($1;$PR_id)
$PR_id:=$1
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
PR02_DefInit 
PR02_varMode_set ("mod")
PR02_varPR_ID_set ($PR_id)

READ ONLY([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
PR02_LoadValues 
$dlg_ok:=PR02_Display ($PR_id)//OK変数の値を保持
If ($dlg_ok=1)
	//保存はOKボタン

End if 

$0:=$dlg_ok
