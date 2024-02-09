//%attributes = {}
//zz_test_CAREATE_INDEX
//20240209 wat
//インデックス作成がうまくいかないのでテストを作る

//インデックス作成 4Dコマンドで作成
ARRAY POINTER:C280($fldAry; 0)
C_POINTER:C301($fldPtr)
C_TEXT:C284($indexName)
C_TEXT:C284($tblName; $fldFullName)
$tblName:="USERS"
$fldFullName:="US_EMAIL"

$tblPtr:=JCL_tbl_Ptr_byName($tblName)
$retCode:=JCL_tbl_Fld_GetPtr($tblPtr; $fldFullName; ->$fldPtr)
If ($retCode=0)
	//フィールドポインタの配列を作ってわたす
	DELETE FROM ARRAY:C228($fldAry; 1; Size of array:C274($fldAry))
	APPEND TO ARRAY:C911($fldAry; $fldPtr)
	
	$indexName:=$fldFullName+"_index"
	CREATE INDEX:C966($tblPtr->; $fldAry; 0; $indexName)
	
End if 

