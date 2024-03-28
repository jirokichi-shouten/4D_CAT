//%attributes = {}
//D00_Display
//20240328 wat
// メイン画面をウインドウに表示

C_LONGINT:C283($winRef)
C_TEXT:C284($frmName; $title)
$frmName:="JCL_D00_Generator"
$title:="ジェネレータ("+$frmName+")"

// クローズボックスなし、タイトルバー付のウインドウを作成する
$winRef:=Open form window:C675($frmName; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)

SET WINDOW TITLE:C213($title)

DIALOG:C40($frmName)  //ウインドウにフォームを表示する

CLOSE WINDOW:C154  // ウインドウを閉じる
