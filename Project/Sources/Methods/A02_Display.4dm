//%attributes = {}
//A02_Display
//20261001 wat
// admin画面をウインドウに表示

C_LONGINT:C283($winRef)
C_TEXT:C284($frmName; $title)
$frmName:="A02_admin"
$title:="管理画面("+$frmName+")"

// クローズボックスなし、タイトルバー付のウインドウを作成する
$winRef:=Open form window:C675($frmName; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)

SET WINDOW TITLE:C213($title)

DIALOG:C40($frmName)  //ウインドウにフォームを表示する

CLOSE WINDOW:C154  // ウインドウを閉じる
