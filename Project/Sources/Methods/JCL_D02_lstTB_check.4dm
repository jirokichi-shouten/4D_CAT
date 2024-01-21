//%attributes = {}
//JCL_D02_lstTB_check
//20240121 wat
//テーブル情報チェック、既存テーブルは重複していない

C_LONGINT:C283($i; $sizeOfAry)
C_TEXT:C284($status)
ARRAY TEXT:C222($aryTemporary; 0)
ARRAY TEXT:C222($aryExist; 0)

$sizeOfAry:=Size of array:C274(vJCL_D02_lstTB_status)
For ($i; 1; $sizeOfAry)
	$status:=vJCL_D02_lstTB_status{$i}
	If ($status="temporary")
		//テンポラリーの場合だけ、重複チェック
		$cnt:=Count in array:C907(vJCL_D02_lstTB_NAME; vJCL_D02_lstTB_NAME{$i})
		If ($cnt>1)
			//重複エラー
			vJCL_D02_lstTB_error{$i}:="テーブル名重複"
			
		End if 
	End if 
End for 
