//KN02_Input_Add
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue レコード追加フォーム

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($KN_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

KN02_DefInit 
KN02_varMode_Set ("add")

//レコードを作成して、初期値代入
READ WRITE([Z_KeyNValue])
$KN_id:=KN_Add_byInitValues 

//画面表示
KN02_LoadValues 
$dlg_ok:=KN02_Display ($KN_id)
If ($dlg_ok#1)
//addモードの場合は、追加したレコードを完全に削除する
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
DELETE SELECTION([Z_KeyNValue])

else
//更新日をＤＢに保存
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
KN02_SaveValues 
[Z_KeyNValue]KN_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyNValue])

End if 

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

$1->:=$KN_id//IDを返す
$0:=$dlg_ok
