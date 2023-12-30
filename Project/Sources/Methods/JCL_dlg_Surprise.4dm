//%attributes = {"shared":true}
//JCL_dlg_Surprise
//20100918 wat new
//驚きのサープライズダイアログ

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str)
$title:=$1
$msg:=$2
$ok_str:=$3

C_TEXT:C284(vJCL_D83_txtTitle)
C_TEXT:C284(vJCL_D83_txtMsg)
C_TEXT:C284(vJCL_D83_ok_str)

vJCL_D83_txtTitle:="注意！"
If ($title#"")
	vJCL_D83_txtTitle:=$title
End if 

vJCL_D83_txtMsg:="できませんでした。"
If ($msg#"")
	vJCL_D83_txtMsg:=$msg
End if 

//OKボタンの名前を変える
vJCL_D83_ok_str:="OK"
If ($ok_str#"")
	vJCL_D83_ok_str:=$ok_str
End if 

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D83_btnValidate)

C_LONGINT:C283($wref)

//入力フォームを表示し、変更可能にする
$wref:=Open form window:C675("JCL_D83_Surprise"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D83_Surprise")

CLOSE WINDOW:C154($wref)

$dialog_ok:=OK

$0:=$dialog_ok
