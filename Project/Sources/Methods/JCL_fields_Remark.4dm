//%attributes = {}
//JCL_fields_Remark
//20210208 wat
//fieldsのテーブルプリフィックス＆フィールド名から備考を取得

C_TEXT:C284($1; $fldName)
$fldName:=$1
C_TEXT:C284($0; $remark)
$remark:=""

C_LONGINT:C283($index)

$index:=Find in array:C230(vJCL_fields_name; $fldName)
If ($index#-1)
	$remark:=vJCL_fields_remark{$index}
	
End if 

$0:=$remark
