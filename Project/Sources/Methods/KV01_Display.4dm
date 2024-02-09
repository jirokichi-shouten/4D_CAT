//KV01_Display
//FG v202402 2024/02/09 18:05:58
//Z_KeyValue 一覧ウインドウ表示

C_LONGINT($wref)
C_LONGINT($0)
C_TEXT($title)
C_TEXT($frmName)
$frmName:="KV01_List"

$wref:=Open form window([Z_KeyValue];$frmName;Plain form dialog box;Horizontally Centered;Vertically Centered;*)

$title:=$frmName
SET WINDOW TITLE($title; $wref)

DIALOG([Z_KeyValue];$frmName)
CLOSE WINDOW($Wref)//ウィンドウを閉じる 

$0:=OK
