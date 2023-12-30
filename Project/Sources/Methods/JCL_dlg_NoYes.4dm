//%attributes = {"shared":true}
//JCL_dlg_NoYes
//20100830 wat new
//デフォルトがキャンセルの確認ダイアログ

//元は、zz_Dialog_NoYes
//20090528 wat new
//確認用yes/noダイアログ

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str; $4; $cancel_str)
$title:=$1
$msg:=$2
$ok_str:=$3
$cancel_str:=$4

C_TEXT:C284(vJCL_D81_txtTitle)
C_TEXT:C284(vJCL_D81_txtIMsg)
C_TEXT:C284(vJCL_D81_ok_str)
C_TEXT:C284(vJCL_D81_cancel_str)

vJCL_D81_txtTitle:="確認"
If ($title#"")
	vJCL_D81_txtTitle:=$title
End if 

vJCL_D81_txtMsg:="よろしいですか？"
If ($msg#"")
	vJCL_D81_txtMsg:=$msg
End if 

//OKボタンの名前を変える
If ($ok_str#"")
	vJCL_D81_ok_str:=$ok_str
End if 

//キャンセルボタンの名前を変える
If ($cancel_str#"")
	vJCL_D81_cancel_str:=$cancel_str
End if 

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D81_btnValidate)
C_LONGINT:C283(vJCL_D81_btnCancel)


C_LONGINT:C283($wref)

//フォームを表示
$wref:=Open form window:C675("JCL_D81_NoYes"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D81_NoYes")

CLOSE WINDOW:C154($wref)

$dialog_ok:=OK

$0:=$dialog_ok

