//%attributes = {}
//JCL_D02_frm
//20240116 wat

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Load:K2:1)
		JCL_D02_frmOnLoad
		
End case 
