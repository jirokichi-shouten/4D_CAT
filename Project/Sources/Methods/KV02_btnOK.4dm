//KV02_btnOK
//FG v202402 2024/02/07 21:01:46
//Z_KeyValue 保存

C_TEXT($mode)
C_LONGINT($KV_id)

READ WRITE([Z_KeyValue])

$mode:=KV02_varMode_Get 
If ($mode="add")
$KV_id:=KV_Add_byInitValues
KV02_SaveValues

Else 
vKV_id:=KV02_varKV_ID_get
KV02_SaveValues
//[Z_KeyValue]KV_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

End if 

SAVE RECORD([Z_KeyValue])

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

ACCEPT

