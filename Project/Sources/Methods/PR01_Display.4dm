//PR01[--PREFIX]01_Display
//FG v20230103 2024/02/07 17:28:37
//PASSWORD_RESETS 一覧ウインドウ表示

C_LONGINT($wref)
C_LONGINT($0)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="PR01_List"

$wref:=Open form window([PASSWORD_RESETS];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title; $wref)

DIALOG([PASSWORD_RESETS];$frmName)
CLOSE WINDOW($Wref)//ウィンドウを閉じる 

$0:=OK
