//%attributes = {"shared":true}
//JCL_dlg_YesNo
//20101206 wat new
//確認用yes/noダイアログ
//デフォルトがOKの確認ダイアログ

C_LONGINT:C283($0)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str; $4; $cancel_str)
$title:=$1
$msg:=$2
$ok_str:=$3
$cancel_str:=$4

C_TEXT:C284(vJCL_D80_txtTitle)
C_TEXT:C284(vJCL_D80_txtMsg)
C_TEXT:C284(vJCL_D80_ok_str)
C_TEXT:C284(vJCL_D80_cancel_str)

vJCL_D80_txtTitle:="確認"
If ($title#"")
	vJCL_D80_txtTitle:=$title
End if 

vJCL_D80_txtMsg:="よろしいですか？"
If ($msg#"")
	vJCL_D80_txtMsg:=$msg
End if 

//OKボタンの名前を変える
If ($ok_str#"")
	vJCL_D80_ok_str:=$ok_str
End if 

//キャンセルボタンの名前を変える
If ($cancel_str#"")
	vJCL_D80_cancel_str:=$cancel_str
End if 

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D80_btnValidate)
C_LONGINT:C283(vJCL_D80_btnCancel)


//確認用yes/noダイアログ表示
C_LONGINT:C283($wref)

//フォームを表示
$wref:=Open form window:C675("JCL_D80_YesNo"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D80_YesNo")

CLOSE WINDOW:C154($wref)

$0:=OK

