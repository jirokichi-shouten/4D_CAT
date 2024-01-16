//%attributes = {}
//JCL_D01_Display
//D01_Display
//テーブル色選択　ダイアログ　を表示

C_LONGINT:C283($winRef)
C_LONGINT:C283($0)

$winRef:=Open form window:C675("JCL_D01_Select"; Modal form dialog box:K39:7; \
Horizontally centered:K39:1; Vertically centered:K39:4; *)
SET WINDOW TITLE:C213("テーブル色選択")

DIALOG:C40("JCL_D01_Select")  //ウィンドウにフォームを表示する

CLOSE WINDOW:C154  //ウィンドウを閉じる

$0:=OK
