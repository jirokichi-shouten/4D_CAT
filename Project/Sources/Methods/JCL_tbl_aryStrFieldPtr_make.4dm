//%attributes = {}
//JCL_tbl_aryStrFieldPtr_make
//20240221 ike wat
//文字列系フィールドのポインタの配列を作成

C_TEXT:C284($1; $tbl_name)
$tbl_name:=$1
C_POINTER:C301($2; $aryFldPtr)
$aryFldPtr:=$2
C_LONGINT:C283($0)
C_LONGINT:C283($table_num)
C_LONGINT:C283($numOfFields; $i)
C_LONGINT:C283($type)
C_LONGINT:C283($len)
C_BOOLEAN:C305($index)
C_BOOLEAN:C305($unique)
C_BOOLEAN:C305($visible)

//テーブル番号を得る
$tblPtr:=JCL_tbl_Ptr_byName($tbl_name)
$table_num:=Table:C252($tblPtr)

//フィールド情報取得
$numOfFields:=Get last field number:C255($tblPtr)
For ($i; 1; $numOfFields)
	
	If (Is field number valid:C1000($tblPtr; $i)=True:C214)
		//フィールドプロパティ
		GET FIELD PROPERTIES:C258($table_num; $i; $type; $len; $index; $unique; $visible)
		If (($type=Is alpha field:K8:1) | ($type=Is text:K8:3))
			//文字列系なら
			$fldPtr:=Field:C253($table_num; $i)
			APPEND TO ARRAY:C911($aryFldPtr->; $fldPtr)
			
		End if 
	End if 
	
End for 

$0:=Size of array:C274($aryFldPtr->)
