//PR02_Input_Dup
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS レコード複製フォーム

C_LONGINT($1)//ID
$PR_id:=$1
C_POINTER($2)
C_LONGINT($new_PR_id)
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
PR02_DefInit 
PR02_varMode_Set ("dup")

READ WRITE([PASSWORD_RESETS])
$new_PR_id:=PR_Duplicate($PR_id)
PR02_LoadValues 

$dlg_ok:=PR02_Display ($new_PR_id)//OK変数の値を保持
If ($dlg_ok#1)
//dupモードの場合は、追加したレコードを完全に削除する
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$new_PR_id)
DELETE SELECTION([PASSWORD_RESETS])

Else 
//更新日をＤＢに保存
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$new_PR_id)
PR02_SaveValues 
[PASSWORD_RESETS]PR_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([PASSWORD_RESETS])

End if 

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

$2->:=$new_PR_id//IDを返す
$0:=$dlg_ok
