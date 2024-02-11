//US02_btnOK
//FG v202402 2024/02/11 21:23:57
//USERS 保存

C_TEXT($mode)
C_LONGINT($US_id)

READ WRITE([USERS])

$mode:=US02_varMode_Get 
If ($mode="add")
$US_id:=US_Add_byInitValues
US02_SaveValues

Else 
$US_id:=US02_varUS_ID_get
QUERY([USERS];[USERS]US_ID=$US_id)
US02_SaveValues
//[USERS]US_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

End if 

SAVE RECORD([USERS])

UNLOAD RECORD([USERS])
READ ONLY([USERS])

ACCEPT

