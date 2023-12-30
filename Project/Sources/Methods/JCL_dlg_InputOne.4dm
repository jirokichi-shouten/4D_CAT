//%attributes = {"shared":true}
//JCL_dlg_InputOne
//20110112 wat new
//入力フィールドが一個のダイアログ

C_LONGINT:C283($0)
C_TEXT:C284($1; $title; $2; $prompt; $3; $ok_str; $4; $cancel_str)
$title:=$1
$prompt:=$2
$ok_str:=$3
$cancel_str:=$4
C_POINTER:C301($5; $strPtr)
$strPtr:=$5

C_TEXT:C284(vJCL_D84_txtTitle)
C_TEXT:C284(vJCL_D84_txtMsg)
C_TEXT:C284(vJCL_D84_fldInput)
C_TEXT:C284(vJCL_D84_ok_str)
C_TEXT:C284(vJCL_D84_cancel_str)

vJCL_D84_txtTitle:="入力"
If ($title#"")
	vJCL_D84_txtTitle:=$title
End if 

vJCL_D84_txtMsg:="値："
If ($prompt#"")
	vJCL_D84_txtMsg:=$prompt
End if 

vJCL_D84_ok_str:="OK"
If ($ok_str#"")
	vJCL_D84_ok_str:=$ok_str
End if 

vJCL_D84_cancel_str:="Cancel"
If ($cancel_str#"")
	vJCL_D84_cancel_str:=$cancel_str
End if 

vJCL_D84_fldInput:=""
If ($strPtr->#"")
	vJCL_D84_fldInput:=$strPtr->
End if 

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D84_btnValidate)
C_LONGINT:C283(vJCL_D84_btnCancel)

//入力用ダイアログ表示
C_LONGINT:C283($wref)
C_LONGINT:C283($0)

//入力フォームを表示する
$wref:=Open form window:C675("JCL_D84_InputOne"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)

DIALOG:C40("JCL_D84_InputOne")

CLOSE WINDOW:C154($wref)
If (OK=1)
	//入力された文字列を得る
	$strPtr->:=vJCL_D84_fldInput
	
End if 

$0:=OK
