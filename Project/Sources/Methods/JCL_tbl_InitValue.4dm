//%attributes = {"shared":true}
//JCL_tbl_InitValue
//JCL_tbl_GetInitValue
//20130507 wat
//メソッド生成時、テンプレートの INITVALUE を変換

C_TEXT:C284($1; $fieldType)
$fieldType:=$1  //フィールド型
C_TEXT:C284($0; $initValue)

$initValue:=""
Case of 
	: ($fieldType="Is Alpha Field")
		$initValue:="\"\""
		
	: ($fieldType="Is Text")
		$initValue:="\"\""
		
	: ($fieldType="Is Real")
		$initValue:="0.0"
		
	: ($fieldType="Is Integer")
		$initValue:="0"
		
	: ($fieldType="Is LongInt")
		$initValue:="0"
		
	: ($fieldType="Is Date")
		$initValue:="Current date"
		
	: ($fieldType="Is Time")
		$initValue:="Current time"
		
	: ($fieldType="Is Boolean")
		$initValue:="false"
		
	: ($fieldType="Is Picture")
		$initValue:=""
		
	: ($fieldType="Is Subtable")
		$initValue:=""
		
	: ($fieldType="Is BLOB")
		$initValue:=""
End case 

$0:=$initValue
