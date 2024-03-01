//%attributes = {}
//JCL_tbl_StrValue
//20240301 wat
//メソッド生成時、テンプレートの STRVALUE を変換

C_TEXT:C284($1; $field_name)
$field_name:=$1
C_TEXT:C284($2; $fieldType)
$fieldType:=$2
C_TEXT:C284($0; $retStr)
$retStr:=""

Case of 
	: ($fieldType="Is Alpha Field")
		$retStr:=$field_name
		
	: ($fieldType="Is Text")
		$retStr:=$field_name
		
	: ($fieldType="Is Real")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is Integer")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is LongInt")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is Date")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is Time")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is Boolean")
		$retStr:="String("+$field_name+")"
		
	: ($fieldType="Is Picture")
		$retStr:=""
		
	: ($fieldType="Is Subtable")
		$retStr:=""
		
	: ($fieldType="Is BLOB")
		$retStr:=""
		
End case 

$0:=$retStr
