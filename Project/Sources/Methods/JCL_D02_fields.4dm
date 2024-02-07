//%attributes = {}
//JCL_D02_fields
//20240116 wat
//fieldsを表示

C_LONGINT:C283($0; $dlgOk)

//画面表示
$dlgOk:=JCL_D02_Display
If ($dlgOk=1)
	//リスト再作成
	A01_lstT_make
	
	A01_SetControlsValues
	
End if 


$0:=$dlgOk
