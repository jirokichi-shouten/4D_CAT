//フォームメソッド
//20080605　矢部　新規作成

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//プログレスバーのオンロード
		
		<>JCL_D90_Meter:=0  //初期化
		<>JCL_D90_Msg:=""
		<>JCL_D90_Count:=""
		
		SET TIMER:C645(1)  //1/2秒
		
	: (Form event code:C388=On Timer:K2:25)
		
		//プログレスバーのオンタイマー
		
		If (<>JCL_D90_Cancel=True:C214)
			
			CANCEL:C270
			
		End if 
		
End case 
