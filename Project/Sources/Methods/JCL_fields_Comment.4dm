//%attributes = {}
//JCL_fields_Comment
//20240308 wat
//fieldsのテーブルプリフィックス＆フィールド名からコメントを取得

C_TEXT:C284($1; $fldName)
$fldName:=$1
C_TEXT:C284($0; $comment)
$comment:=""

C_LONGINT:C283($index)

$index:=Find in array:C230(vJCL_fields_name; $fldName)
If ($index#-1)
	$comment:=vJCL_fields_comment{$index}
	
End if 

$0:=$comment
