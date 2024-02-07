//%attributes = {}
//A01_frm
//20240204 wat
//フォームメソッド

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Load:K2:1)
		A01_frmOnLoad
		
End case 
