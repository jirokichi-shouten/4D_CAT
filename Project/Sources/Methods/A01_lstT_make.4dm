//%attributes = {}
//A01_lstT_make
//20240204 wat
//テーブル一覧　リストボックス

C_POINTER:C301($tblPtr)
C_TEXT:C284($table_name)
C_LONGINT:C283($numOfRecs)
C_LONGINT:C283($numOfTables; $i)

$numOfTables:=Get last table number:C254
For ($i; 1; $numOfTables)
	
	If (Is table number valid:C999($i)=True:C214)
		APPEND TO ARRAY:C911(vA01_lstT_nr; $i)
		
		$table_name:=Table name:C256($i)
		APPEND TO ARRAY:C911(vA01_lstT_name; $table_name)
		
		$tblPtr:=Table:C252($i)
		ALL RECORDS:C47($tblPtr->)
		$numOfRecs:=Records in selection:C76($tblPtr->)
		APPEND TO ARRAY:C911(vA01_lstT_numOfRecs; $numOfRecs)
		
	End if 
End for 
