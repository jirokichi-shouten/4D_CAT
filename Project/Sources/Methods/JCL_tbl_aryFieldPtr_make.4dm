//%attributes = {}
//JCL_tbl_aryFieldPtr_make
//20221013 wat
//フィールドポインタの配列を作成
//これではフィールドの特定ができない、未実績、おそらく使う場面はない

C_LONGINT:C283($1; $tblNr)  //テーブル番号を得る
$tblNr:=$1
C_POINTER:C301($2; $aryFldPtr)
$aryFldPtr:=$2
C_LONGINT:C283($0; $numOfFlds)
$numOfFlds:=0
C_LONGINT:C283($numOfFields; $i)

//フィールド情報取得
$numOfFields:=Get last field number:C255($tblNr)
For ($i; 1; $numOfFields)
	
	If (Is field number valid:C1000($tblNr; $i)=True:C214)
		
		$fldPtr:=Field:C253($tblNr; $i)
		APPEND TO ARRAY:C911($aryFldPtr->; $fldPtr)
		
		
	End if 
	
End for 

$0:=$numOfFields
