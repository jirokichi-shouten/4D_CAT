//%attributes = {}
//JCL_D02_Display
//20240116 wat
//ログインダイアログを表示

C_LONGINT:C283($winRef)
C_LONGINT:C283($0)
C_TEXT:C284($frmName)
$frmName:="JCL_D02_Fields"
C_TEXT:C284($title)
$title:=$frmName

$winRef:=Open form window:C675($frmName; Movable form dialog box:K39:8; \
Horizontally centered:K39:1; Vertically centered:K39:4; *)
SET WINDOW TITLE:C213("ログインダイアログ")

SET WINDOW TITLE:C213($title)
DIALOG:C40($frmName)  //ウィンドウにフォームを表示する

CLOSE WINDOW:C154  //ウィンドウを閉じる

$0:=OK
