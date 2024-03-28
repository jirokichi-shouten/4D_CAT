//%attributes = {}
//D00_frm
//20240204 wat
//フォームメソッド

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Load:K2:1)
		D00_frmOnLoad
		
End case 
