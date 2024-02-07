//KN01[--PREFIX]01_Display
//FG v20230103 2024/02/07 18:10:39
//Z_KeyNValue 一覧ウインドウ表示

C_LONGINT($wref)
C_LONGINT($0)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="KN01_List"

$wref:=Open form window([Z_KeyNValue];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title; $wref)

DIALOG([Z_KeyNValue];$frmName)
CLOSE WINDOW($Wref)//ウィンドウを閉じる 

$0:=OK
