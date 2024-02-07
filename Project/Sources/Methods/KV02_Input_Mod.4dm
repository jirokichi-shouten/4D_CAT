//KV02_Input_Mod
//FG v202103 2024/02/07 17:31:34
//Z_KeyValue レコード編集フォーム

C_LONGINT($1;$KV_id)
$KV_id:=$1
C_LONGINT($0;$display_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KV02_DefInit 
KV02_varMode_Set ("mod")

READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
KV02_LoadValues 
$display_ok:=KV02_Display ($KV_id)//OK変数の値を保持
If ($display_ok=1)

//更新日をＤＢに保存
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
KV02_SaveValues 
[Z_KeyValue]KV_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyValue])

End if 

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

$0:=$display_ok
