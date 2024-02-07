//%attributes = {}
//JCL_method_isExist
//20240207 hisa wat
//メソッド名があるか？

C_TEXT:C284($1; $methodName)
$methodName:=$1
C_LONGINT:C283($0)

ARRAY TEXT:C222($aryNames; 0)

METHOD GET NAMES:C1166($aryNames; $methodName)

$0:=Size of array:C274($aryNames)
