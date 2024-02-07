//PR02_Input_Mod
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS レコード編集フォーム

C_LONGINT($1;$PR_id)
$PR_id:=$1
C_LONGINT($0;$display_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
PR02_DefInit 
PR02_varMode_Set ("mod")

READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
PR02_LoadValues 
$display_ok:=PR02_Display ($PR_id)//OK変数の値を保持
If ($display_ok=1)

//更新日をＤＢに保存
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
PR02_SaveValues 
[PASSWORD_RESETS]PR_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([PASSWORD_RESETS])

End if 

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

$0:=$display_ok
