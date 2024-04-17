//%attributes = {}
//zz_test_setRGBColor
//20240416 wat
//色変更　テスト

C_TEXT:C284($table_name)
C_TEXT:C284($color_text)
C_TEXT:C284($tbl_prefix)
C_TEXT:C284($form_name)
C_LONGINT:C283($tblNr)
C_POINTER:C301($tblPtr)

$table_name:="JUCHUU_DETAIL"
$color_text:="#F4CB43"

//プレフィックス
$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)

$tblNr:=JCL_tbl_GetNumber($table_name)
$tblPtr:=Table:C252($tblNr)


$form_name:=$tbl_prefix+"01_List"
$rec_name:="v"+$tbl_prefix+"01_rectTitle"
$exist:=JCL_frm_isExist($tblPtr; $form_name)
If ($exist=True:C214)
	//フォームのファイルを取得
	C_OBJECT:C1216($frmDef)
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$form_name+"/form.4DForm")
	$def01:=JSON Parse:C1218($file.getText("UTF-8"; Document with LF:K24:22))
	
	$def01.pages[1].objects[$rec_name].fill:=$color_text
	$def01.pages[1].objects[$rec_name].stroke:=$color_text
	
	$file.setText(JSON Stringify:C1217($def01; *))
	
	
	
	//OBJECT SET RGB COLORS(*; $rec_name; $color)
	
	
End if 
