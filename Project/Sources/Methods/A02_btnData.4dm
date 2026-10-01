//%attributes = {}
//A02_btnData
//20261001 wat
//データを作成

C_LONGINT:C283($i)

For ($i; 1; 1000)
	
	$str:="test data "+String:C10($i)
	APPEND TO ARRAY:C911(vA02_lstTB_NAME; $str)
	
	
End for 
