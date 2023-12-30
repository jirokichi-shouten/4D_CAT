//%attributes = {"shared":true}
//%attributes = {"lang":"en"} comment added and reserved by 4D.
//JCL_dlg_Inform
//20100918 wat new
//インフォームダイアログ、OKボタンしかない

C_LONGINT:C283($0)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str)
$title:=$1
$msg:=$2
$ok_str:=$3

C_TEXT:C284(vJCL_D82_txtTitle)
C_TEXT:C284(vJCL_D82_txtMsg)
C_TEXT:C284(vJCL_D82_ok_str)

vJCL_D82_txtTitle:="確認"
If ($title#"")
	vJCL_D82_txtTitle:=$title
End if 

vJCL_D82_txtMsg:="できました。"
If ($msg#"")
	vJCL_D82_txtMsg:=$msg
End if 

//OKボタンの名前を変える
If ($ok_str#"")
	vJCL_D82_ok_str:=$ok_str
End if 

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D82_btnValidate)

C_LONGINT:C283($wref)

//入力フォームを表示し、変更可能にする
$wref:=Open form window:C675("JCL_D82_Inform"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D82_Inform")

CLOSE WINDOW:C154($wref)

$0:=OK
