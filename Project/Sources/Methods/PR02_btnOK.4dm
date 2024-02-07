//PR02_btnOK
//FG v202402 2024/02/07 20:50:34
//PASSWORD_RESETS 保存

C_TEXT($mode)
C_LONGINT($PR_id)

READ WRITE([PASSWORD_RESETS])

$mode:=PR02_varMode_Get 
If ($mode="add")
$PR_id:=PR_Add_byInitValues
PR02_SaveValues

Else 
vPR_id:=PR02_varPR_ID_get
PR02_SaveValues
//[PASSWORD_RESETS]PR_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

End if 

SAVE RECORD([PASSWORD_RESETS])

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

ACCEPT

