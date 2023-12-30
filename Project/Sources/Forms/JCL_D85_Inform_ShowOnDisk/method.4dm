//フォームメソッド

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//フォームオンロードのとき、
		
		//ボタンテキストを変更
		OBJECT SET TITLE:C194(vJCL_D85_btnValidate; vJCL_D85_ok_str)
		
End case 
