//KN02_btnOK
//FG v202402 2024/02/07 21:00:49
//Z_KeyNValue 保存

C_TEXT($mode)
C_LONGINT($KN_id)

READ WRITE([Z_KeyNValue])

$mode:=KN02_varMode_Get 
If ($mode="add")
$KN_id:=KN_Add_byInitValues
KN02_SaveValues

Else 
vKN_id:=KN02_varKN_ID_get
KN02_SaveValues
//[Z_KeyNValue]KN_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

End if 

SAVE RECORD([Z_KeyNValue])

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

ACCEPT

