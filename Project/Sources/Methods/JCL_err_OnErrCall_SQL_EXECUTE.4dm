//%attributes = {}
//JCL_err_OnErrCall_SQL_EXECUTE
//20240121 wat
//sql実行時のエラーハンドリング: all local or process variables must be declared

C_TEXT:C284($msg)
C_LONGINT:C283($i; $sizeOfAry)
ARRAY LONGINT:C221($aryCords; 0)
ARRAY TEXT:C222($aryComp; 0)
ARRAY TEXT:C222($aryText; 0)
C_TEXT:C284($errorText)

$msg:=$msg+vSQL+Char:C90(Tab:K15:37)

GET LAST ERROR STACK:C1015($aryCords; $aryComp; $aryText)
$sizeOfAry:=Size of array:C274($aryCords)
//$msg:="GET LAST ERROR STACK: $sizeOfAry=["+String($sizeOfAry)+"]"+Char(Carriage return)
For ($i; 1; $sizeOfAry)
	$msg:=$msg+"cord=["+String:C10($aryCords{$i})+"]"+Char:C90(Tab:K15:37)
	$msg:=$msg+"component=["+$aryComp{$i}+"]"+Char:C90(Tab:K15:37)
	$msg:=$msg+"error text=["+$aryText{$i}+"]"+Char:C90(Tab:K15:37)
	
	$err_text:=JCL_err_4D_Error($aryCords{$i}; "error_codes_sql.txt")
	$msg:=$msg+"code text=["+$err_text+"]"+Char:C90(Tab:K15:37)
	
End for 
$msg:=$msg+"Error=["+String:C10(Error)+"]"+Char:C90(Tab:K15:37)
$msg:=$msg+"formula=["+Error formula+"]"+Char:C90(Tab:K15:37)
$msg:=$msg+"method["+Error method+"],"
$msg:=$msg+"line["+String:C10(Error line)+"]"+Char:C90(Tab:K15:37)
$msg:=$msg+vSQL+Char:C90(Carriage return:K15:38)

ALERT:C41($msg)
