//%attributes = {}
//JCL_prj_fg_fldNextPos
//20210606 wat
//次のフィールドの位置（top, left, ）を返す
//20240201 ike wat $default_topを追加、トップの戻るところ 

C_OBJECT:C1216($1; $inObj)
$inObj:=$1
C_LONGINT:C283($2; $default_top)
$default_top:=$2
C_OBJECT:C1216($0; $outObj)
$outObj:=$inObj
C_LONGINT:C283($top)
C_LONGINT:C283($v_offset; $h_offset)
$v_offset:=26
$h_offset:=246
$h_offset:=398
C_LONGINT:C283($form_height)
$form_height:=674
$form_height:=178  //debug

$top:=$inObj.top+$v_offset
If ($top>=$form_height)
	//フォームの高さからはみ出している。次の列の一番上の座標
	$outObj.top:=$default_top
	$outObj.left:=$inObj.left+$h_offset
	$outObj.label_left:=$inObj.label_left+$h_offset
	
Else 
	//はみ出さなければ、一つ下の座標
	$outObj.top:=$inObj.top+$v_offset
	$outObj.left:=$inObj.left
	$outObj.label_left:=$inObj.label_left
	
End if 

$0:=$outObj
