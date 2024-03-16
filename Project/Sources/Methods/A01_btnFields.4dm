//%attributes = {}
//A01_btnFields
//20240121 yabe wat
//fields表示

vD02:=cs:C1710.JCL_D02.new()
$dlgOk:=vD02.display()
If ($dlgOk=1)
	//リスト再作成
	RELOAD PROJECT:C1739
	A01_lstT_make
	
	A01_SetControlsValues
	
End if 
