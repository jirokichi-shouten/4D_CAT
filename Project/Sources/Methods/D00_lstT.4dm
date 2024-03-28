//%attributes = {}
//D00_lstT
//20240204 wat
//リストボックス オブジェクトメソッド

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Double Clicked:K2:5)
		
		D00_lstT_OnDblClicked
		
	: ($frmEvnt=On Selection Change:K2:29)
		
		D00_lstT_OnSelChange
		
End case 
