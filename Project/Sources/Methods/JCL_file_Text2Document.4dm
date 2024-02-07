//%attributes = {}
//JCL_file_Text2Document
//20240207 hisa wat
//TEXT TO DOCUMENTはプロセス終了時までクローズしないため、これを作成

C_TEXT:C284($1; $filePath)
$filePath:=$1
C_TEXT:C284($2; $method)
$method:=$2
C_TIME:C306($doc)

$doc:=Create document:C266($filePath)

SEND PACKET:C103($doc; $method)

CLOSE DOCUMENT:C267($doc)
