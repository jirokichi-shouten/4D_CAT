//%attributes = {}
//JCLERR_4D_Error
//旧名 JCL_err_4D_Error
//20240128 yabe wat
//4Dのエラーコードページのエラーテキストを返す。
//sqlのコードが重複しているため、別ファイルにした。
//さらなる重複として、-1は複数ある。複数あったら文字連結
//20261002 Codex/wat エラーコードを完全一致で検索し、未該当時の処理を安全化

C_LONGINT:C283($1; $code)
$code:=$1
C_TEXT:C284($2; $fileName)
$fileName:=$2
C_TEXT:C284($0; $retStr)
$retStr:=""
C_TEXT:C284($errText)
C_TEXT:C284($codeText; $itemCode)
$codeText:=String:C10($code)

C_TEXT:C284($folderPath; $filePath)
C_TEXT:C284($fileText)
C_LONGINT:C283($i; $numOfLines; $numOfItems)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)

//リソースフォルダからエラーコード表を読み込む
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "JCL4D_Resources")
$filePath:=JCL_file_MakeFilePath($folderPath; $fileName)

If (Test path name:C476($filePath)=Is a document:K24:1)
	$fileText:=Document to text:C1236($filePath; UTF8 text without length:K22:17)
	If ($fileText#"")
		//改行コードをLFに統一
		$fileText:=JCL_str_unifyLF($fileText)
		
		//タブ区切りのコード列を完全一致で検索
		$numOfLines:=JCL_str_Extract_byReturn($fileText; ->$aryLines)
		For ($i; 1; $numOfLines)
			DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
			$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
			If ($numOfItems>=2)
				$itemCode:=Replace string:C233($aryItems{1}; Char:C90(65279); "")
				If ($itemCode=$codeText)
					$errText:=$aryItems{2}
					If ($retStr#"")
						$retStr:=$retStr+","
					End if 
					$retStr:=$retStr+$errText
				End if 
			End if 
		End for 
	End if 
End if 

$0:=$retStr
