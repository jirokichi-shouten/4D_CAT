//KV02_Display
//FG v202103 2024/02/07 17:31:34
//Z_KeyValue 入力フォームを表示

C_LONGINT($wRef)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="KV02_Input"

$wref:=Open form window([Z_KeyValue];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title)

DIALOG([Z_KeyValue];$frmName)
CLOSE WINDOW($wRef)

$0:=OK
