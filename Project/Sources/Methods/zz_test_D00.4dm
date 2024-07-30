//%attributes = {}
//zz_test_D00
//20240721 wat
//usage:

C_LONGINT:C283($formNr)
$formNr:=2

Case of 
	: ($formNr=0)
		//ジェネレータメインダイアログ
		
		$d00:=cs:C1710.JCL_D00.new()
		
	: ($formNr=1)
		//色変更ダイアログ
		C_OBJECT:C1216($dlg)
		$dlg:=cs:C1710.JCL_D01.new()
		If ($dlg.dlg_ok=1)
			//do something
		End if 
		
	: ($formNr=2)
		//テーブル作成
		
		C_LONGINT:C283($dlgOK)
		C_OBJECT:C1216(vD02)
		vD02:=cs:C1710.JCL_D02.new()
		$dlgOk:=vD02.display()
		If ($dlgOk=1)
		End if 
End case 
