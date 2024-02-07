//PR02_Input_Add
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS レコード追加フォーム

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($PR_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

PR02_DefInit 
PR02_varMode_Set ("add")

//レコードを作成して、初期値代入
READ WRITE([PASSWORD_RESETS])
$PR_id:=PR_Add_byInitValues 

//画面表示
PR02_LoadValues 
$dlg_ok:=PR02_Display ($PR_id)
If ($dlg_ok#1)
//addモードの場合は、追加したレコードを完全に削除する
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
DELETE SELECTION([PASSWORD_RESETS])

else
//更新日をＤＢに保存
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
PR02_SaveValues 
[PASSWORD_RESETS]PR_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([PASSWORD_RESETS])

End if 

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

$1->:=$PR_id//IDを返す
$0:=$dlg_ok
