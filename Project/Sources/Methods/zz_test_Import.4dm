//%attributes = {}
//zz_test_Import
C_TEXT:C284($1; $block)
$block:=$1  //対象文字列ブロック
ARRAY TEXT:C222($aryBlocks; 0)
ARRAY TEXT:C222($aryLines; 0)
C_LONGINT:C283($i; $numOfRecs)
ARRAY TEXT:C222($aryItems; 0)
C_LONGINT:C283($numOfFields; $numOfItems)
//$numOfFields:=9
$numOfFields:=Get last field number:C255([assign:18]->)
//フィールドは生成されたテーブルのまま、削除されていないと仮定して

READ WRITE:C146([assign:18])

JCL_str_Extract($block; "\\."; ->$aryBlocks)
$numOfRecs:=JCL_str_Extract($aryBlocks{1}; Char:C90(Line feed:K15:40); ->$aryLines)-1
For ($i; 1; $numOfRecs)
	DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i+1}; Char:C90(Tab:K15:37); ->$aryItems)
	If ($numOfItems>=$numOfFields)
		CREATE RECORD:C68([assign:18])
		[assign:18]as_del_date:6:=Num:C11($aryItems{4})
		[assign:18]as_reg_date:4:=$aryItems{2}
		[assign:18]as_up_date:5:=$aryItems{3}
		[assign:18]as_pr_id:1:=Num:C11($aryItems{7})
		[assign:18]as_wo_id:2:=Num:C11($aryItems{8})
		[assign:18]as_assigner:3:=Num:C11($aryItems{9})
		[assign:18]as_unreg_date:7:=$aryItems{6}
		SAVE RECORD:C53([assign:18])
	End if 
End for 

UNLOAD RECORD:C212([assign:18])
READ ONLY:C145([assign:18])
