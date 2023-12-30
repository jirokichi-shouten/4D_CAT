//%attributes = {"shared":true}
//%attributes = {"lang":"en"} comment added and reserved by 4D.
//JCL_dlg_Inform_ShowOnDisk
//20220223 wat new
//インフォームダイアログ、書き出しの後で使う

C_TEXT:C284($1; $title)
$title:=$1
C_TEXT:C284($2; $msg)
$msg:=$2
C_TEXT:C284($3; $ok_str)
$ok_str:=$3
C_TEXT:C284($4; $filePath)
$filePath:=$4
C_LONGINT:C283($0; $dialog_ok)

C_TEXT:C284(vJCL_D85_txtTitle)
C_TEXT:C284(vJCL_D85_txtMsg)
C_TEXT:C284(vJCL_D85_ok_str)
C_TEXT:C284(vJCL_D85_filePath)

vJCL_D85_txtTitle:="確認"
If ($title#"")
	vJCL_D85_txtTitle:=$title
End if 

vJCL_D85_txtMsg:="できました。"
If ($msg#"")
	vJCL_D85_txtMsg:=$msg
End if 

//OKボタンの名前を変える
If ($ok_str#"")
	vJCL_D85_ok_str:=$ok_str
End if 

vJCL_D85_filePath:=$filePath

//ボタン　20180808 wat
C_LONGINT:C283(vJCL_D85_btnValidate)

//アイコンなしアラートダイアログ表示

C_LONGINT:C283($wref)

//入力フォームを表示し、変更可能にする
$wref:=Open form window:C675("JCL_D85_Inform_ShowOnDisk"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D85_Inform_ShowOnDisk")

CLOSE WINDOW:C154($wref)

$dialog_ok:=OK

$0:=$dialog_ok
