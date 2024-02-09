//KN02_Display
//FG v202103 2024/02/09 18:04:40
//Z_KeyNValue 入力フォームを表示

C_LONGINT($wRef)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="KN02_Input"

$wref:=Open form window([Z_KeyNValue];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title)

DIALOG([Z_KeyNValue];$frmName)
CLOSE WINDOW($wRef)

$0:=OK
