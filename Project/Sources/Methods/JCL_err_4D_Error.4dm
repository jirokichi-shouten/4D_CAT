//%attributes = {}
//JCL_err_4D_Error
//20240128 yabe wat
//4Dのエラーコードページのエラーテキストを返す。
//sqlのコードが重複しているため、別ファイルにした。
//さらなる重複として、-1は複数ある。複数あったら文字連結

C_LONGINT:C283($1; $code)
$code:=$1
C_TEXT:C284($2; $fileName)
$fileName:=$2
C_TEXT:C284($0; $retStr)
$retStr:=""
C_TEXT:C284($errText)
C_TEXT:C284($findStr)
$findStr:=String:C10($code)+Char:C90(Tab:K15:37)

C_TEXT:C284($folderPath; $filePath)
C_TEXT:C284($fileText)
C_LONGINT:C283($i; $numOfLines)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)

//リソースフォルダからフィールズを読み込む
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "JCL4D_Resources")
$filePath:=JCL_file_MakeFilePath($folderPath; $fileName)

$fileText:=Document to text:C1236($filePath; UTF8 text without length:K22:17)
If ($fileText#"")
	//改行コードをLFに統一
	$fileText:=JCL_str_ReplaceReturn($fileText)
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($fileText; ->$aryLines)
	For ($i; 1; $numOfLines)
		//先頭文字列にコードがあれば
		$pos:=Position:C15($findStr; $aryLines{$i})
		If ($pos>0)
			$errText:=Substring:C12($aryLines{$i}; Length:C16($findStr)+1)
			$retStr:=$retStr+$errText+","
			//$i:=$numOfLines
			
		End if 
	End for 
End if 
$retStr:=Substring:C12($retStr; 1; Length:C16($retStr)-1)

$0:=$retStr
