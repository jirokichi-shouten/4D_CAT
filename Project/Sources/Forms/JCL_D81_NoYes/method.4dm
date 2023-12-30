//フォームメソッド

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//ボタンテキストを変更
		OBJECT SET TITLE:C194(vJCL_D81_btnValidate; vJCL_D81_ok_str)
		OBJECT SET TITLE:C194(vJCL_D81_btnCancel; vJCL_D81_cancel_str)
		
		
End case 

