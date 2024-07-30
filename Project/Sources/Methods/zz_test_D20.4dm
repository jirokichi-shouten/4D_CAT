//%attributes = {}
//zz_test_D20
//20240723 wat
//カレンダーアシスト

C_LONGINT:C283($dlgOK)
C_DATE:C307($date)
$date:=Current date:C33

C_OBJECT:C1216($dlg)
$dlg:=cs:C1710.JCL_D20.new(->$date; 100; 300; "入力")
If ($dlg.dlg_ok=1)
	vA01_varDate:=$date
	
End if 

//ALERT(String($date)+":::"+String(vA01_varDate))
