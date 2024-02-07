//KV02_Input_Dup
//FG v202103 2024/02/07 17:31:34
//Z_KeyValue レコード複製フォーム

C_LONGINT($1)//ID
$KV_id:=$1
C_POINTER($2)
C_LONGINT($new_KV_id)
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KV02_DefInit 
KV02_varMode_Set ("dup")

READ WRITE([Z_KeyValue])
$new_KV_id:=KV_Duplicate($KV_id)
KV02_LoadValues 

$dlg_ok:=KV02_Display ($new_KV_id)//OK変数の値を保持
If ($dlg_ok#1)
//dupモードの場合は、追加したレコードを完全に削除する
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$new_KV_id)
DELETE SELECTION([Z_KeyValue])

Else 
//更新日をＤＢに保存
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$new_KV_id)
KV02_SaveValues 
[Z_KeyValue]KV_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyValue])

End if 

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

$2->:=$new_KV_id//IDを返す
$0:=$dlg_ok
