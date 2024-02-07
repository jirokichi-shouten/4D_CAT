//US02_Display
//FG v202103 2024/02/07 17:24:49
//USERS 入力フォームを表示

C_LONGINT($wRef)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="US02_Input"

$wref:=Open form window([USERS];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title)

DIALOG([USERS];$frmName)
CLOSE WINDOW($wRef)

$0:=OK
