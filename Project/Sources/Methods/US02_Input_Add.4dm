//US02_Input_Add
//FG v202103 2024/02/07 17:24:49
//USERS レコード追加フォーム

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($US_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

US02_DefInit 
US02_varMode_Set ("add")

//レコードを作成して、初期値代入
READ WRITE([USERS])
$US_id:=US_Add_byInitValues 

//画面表示
US02_LoadValues 
$dlg_ok:=US02_Display ($US_id)
If ($dlg_ok#1)
//addモードの場合は、追加したレコードを完全に削除する
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
DELETE SELECTION([USERS])

else
//更新日をＤＢに保存
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
US02_SaveValues 
[USERS]US_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([USERS])

End if 

UNLOAD RECORD([USERS])
READ ONLY([USERS])

$1->:=$US_id//IDを返す
$0:=$dlg_ok
