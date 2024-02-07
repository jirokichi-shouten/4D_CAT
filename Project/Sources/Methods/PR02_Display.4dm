//PR02_Display
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS 入力フォームを表示

C_LONGINT($wRef)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="PR02_Input"

$wref:=Open form window([PASSWORD_RESETS];$frmName;Movable form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title)

DIALOG([PASSWORD_RESETS];$frmName)
CLOSE WINDOW($wRef)

$0:=OK
