
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (vJCL_D84_ok_str#"")
			OBJECT SET TITLE:C194(vJCL_D84_btnValidate; vJCL_D84_ok_str)
		End if 
		
		If (vJCL_D84_cancel_str#"")
			OBJECT SET TITLE:C194(vJCL_D84_btnCancel; vJCL_D84_cancel_str)
		End if 
		
		
End case 
