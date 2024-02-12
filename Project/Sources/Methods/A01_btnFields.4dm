//%attributes = {}
//A01_btnFields
//20240121 yabe wat
//fields表示

C_LONGINT:C283($dlgOk)

$dlgOk:=JCL_D02_fields
If ($dlgOk=1)
	//リスト再作成
	RELOAD PROJECT:C1739
	A01_lstT_make
	
	A01_SetControlsValues
	
	
End if 
