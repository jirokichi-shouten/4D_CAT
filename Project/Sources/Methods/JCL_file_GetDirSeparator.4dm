//%attributes = {"preemptive":"capable"}
//JCL_file_GetDirSeparator
//20231230 yabe wat
//OSに合わせたフォルダの区切りを返す
//$0:OSに合わせたフォルダの区切り

C_TEXT:C284($0; $separator)
$separator:=""

//実行されているのが
If (Is Windows:C1573)
	//winなら
	$separator:="\\"
	
Else 
	//macなら
	$separator:=":"
	
End if 

$0:=$separator
