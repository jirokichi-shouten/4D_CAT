//%attributes = {}
//JCL_D02_lstTB_remove_temporary
//20240121 wat
//テンポラリーのfields行を削除

C_LONGINT:C283($i; $sizeOfAry)
C_TEXT:C284($status)

$sizeOfAry:=Size of array:C274(vJCL_D02_lstTB_status)
For ($i; $sizeOfAry; 1; -1)
	$status:=vJCL_D02_lstTB_status{$i}
	If ($status="temporary")
		//配列から削除
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_status; $i; 1)
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_LABEL; $i; 1)
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NAME; $i; 1)
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_PREFIX; $i; 1)
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_DESCRIPTION; $i; 1)
		DELETE FROM ARRAY:C228(vJCL_D02_lstTB_Block; $i; 1)
		
	End if 
End for 
