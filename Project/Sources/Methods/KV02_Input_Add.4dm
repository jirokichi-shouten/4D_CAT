//KV02_Input_Add
//FG v202103 2024/02/07 17:31:34
//Z_KeyValue レコード追加フォーム

C_POINTER($1)//ポインタ引数にIDを返す
C_LONGINT($KV_id)
C_LONGINT($dlg_ok)//システム変数OKを保持

KV02_DefInit 
KV02_varMode_Set ("add")

//レコードを作成して、初期値代入
READ WRITE([Z_KeyValue])
$KV_id:=KV_Add_byInitValues 

//画面表示
KV02_LoadValues 
$dlg_ok:=KV02_Display ($KV_id)
If ($dlg_ok#1)
//addモードの場合は、追加したレコードを完全に削除する
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
DELETE SELECTION([Z_KeyValue])

else
//更新日をＤＢに保存
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
KV02_SaveValues 
[Z_KeyValue]KV_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyValue])

End if 

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

$1->:=$KV_id//IDを返す
$0:=$dlg_ok
