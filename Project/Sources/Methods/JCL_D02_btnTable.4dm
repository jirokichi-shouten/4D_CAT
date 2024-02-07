//%attributes = {}
//JCL_D02_btnTable
//20240206 wat
//テーブル作成　ボタン　未作成のテーブルを作成

C_LONGINT:C283($i; $sizeOfAry)
C_TEXT:C284($status)
C_TEXT:C284($block)
C_LONGINT:C283($cnt)
$cnt:=0
C_TEXT:C284($msg)

//テーブルリストをループして
$sizeOfAry:=Size of array:C274(vJCL_D02_lstTB_status)
For ($i; 1; $sizeOfAry)
	//ステータスで未作成を判断
	$status:=vJCL_D02_lstTB_status{$i}
	If ($status="temporary")
		//テーブル作成
		$block:=vJCL_D02_lstTB_Block{$i}
		
		//テーブルを作成 //インデックスを作成
		JCL_tbl_CreateTable($block)
		
		//モデルメソッド群をテンプレートから作成
		JCL_tbl_Create_method($block)
		
		$cnt:=$cnt+1
		
	End if 
End for 

If ($cnt>0)
	$msg:="完了"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+String:C10($cnt)+"個のテーブルを作成しました。"
	ALERT:C41($msg)
	
End if 

JCL_D02_SetControlsValues
