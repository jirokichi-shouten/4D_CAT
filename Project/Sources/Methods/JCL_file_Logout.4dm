//%attributes = {"shared":true,"preemptive":"capable"}
//JCL_file_Logout
//20110527 wat
//ログをファイルに書き出す
//ファイルはデスクトップ、なければ作る
//20221207 wat パラメーターでファイル名をもらう、なければLogout.txt

C_TEXT:C284($1; $inMsg)
$inMsg:=$1  //書き出したい内容
C_TEXT:C284($2; $fileName)
C_LONGINT:C283($paramCnt)
$paramCnt:=Count parameters:C259
If ($paramCnt=1)
	$fileName:="Logout.txt"
End if 
If ($paramCnt=2)
	$fileName:=$2
End if 

C_TEXT:C284($folderPath; $filePath)
C_TIME:C306($FileRef)  //ファイル参照

$folderPath:=System folder:C487(Desktop:K41:16)
$filePath:=JCL_file_MakeFilePath($folderPath; $fileName)
If (Test path name:C476($filePath)=Is a document:K24:1)
	//ファイルがあれば開く
	$FileRef:=Append document:C265($filePath)
	$open_ok:=OK
	
Else 
	//なければ作る
	$FileRef:=Create document:C266($filePath)
	$open_ok:=OK
	
End if 

If ($open_ok=1)
	//ファイルに書き出す
	$dateStr:=JCL_str_Datemark(Current date:C33; Current time:C178)
	SEND PACKET:C103($FileRef; $dateStr)
	SEND PACKET:C103($FileRef; Char:C90(Tab:K15:37))
	SEND PACKET:C103($FileRef; $inMsg)
	SEND PACKET:C103($FileRef; Char:C90(Carriage return:K15:38))  //改行
	SEND PACKET:C103($FileRef; Char:C90(Line feed:K15:40))  //ラインフィード
	
	//ファイルを閉じる
	CLOSE DOCUMENT:C267($FileRef)
	
End if 

