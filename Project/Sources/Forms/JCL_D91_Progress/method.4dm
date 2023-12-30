//ウェイトダイアログのフォームメソッド

C_LONGINT:C283($FEvt)

$FEvt:=Form event code:C388
Case of 
	: ($FEvt=On Load:K2:1)
		//プログレスバーのオンロード
		//プロセス変数を真にして、ウェイトダイアログが開いたことを保持する
		
		<>JCL_D91_Msg:=""
		<>JCL_D91_Count:=""
		
		SET TIMER:C645(1)  //1/2秒
		
	: (Form event code:C388=On Timer:K2:25)
		//ウェイトダイアログのオンタイマー
		If (<>JCL_D91_Cancel=True:C214)
			
			CANCEL:C270
			
		End if 
		
		//OBJECT SET SCROLL POSITION(*; "<>JCL_D91_Msg"; 1000; 1000)//no effect
		
		//GOTO OBJECT(<>JCL_D91_Msg)//no effect
		
		
End case 
