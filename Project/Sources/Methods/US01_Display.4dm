//US01[--PREFIX]01_Display
//FG v20230103 2024/02/07 17:24:49
//USERS 一覧ウインドウ表示

C_LONGINT($wref)
C_LONGINT($0)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="US01_List"

$wref:=Open form window([USERS];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title; $wref)

DIALOG([USERS];$frmName)
CLOSE WINDOW($Wref)//ウィンドウを閉じる 

$0:=OK
