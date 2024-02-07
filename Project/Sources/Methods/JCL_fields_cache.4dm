//%attributes = {}
//JCL_fields_cache
//20210210 ike wat
//キャッシュからラベルを取得
//20240114 yabe wat テーブル区切りはアンダースコアではなくハイフンに統一

C_TEXT:C284($folderPath; $filePath)
C_TEXT:C284($fileText)
C_LONGINT:C283($i; $numOfLines)
C_TEXT:C284($fldName; $label; $prefix)
ARRAY TEXT:C222(vJCL_fields_tblName; 0)
ARRAY TEXT:C222(vJCL_fields_tblLabel; 0)
ARRAY TEXT:C222(vJCL_fields_name; 0)
ARRAY TEXT:C222(vJCL_fields_label; 0)
C_LONGINT:C283($numOfItems)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)

//リソースフォルダからフィールズを読み込む
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "JCL4D_Resources")
$filePath:=JCL_file_MakeFilePath($folderPath; "field_labels.txt")  //20240207

$fileText:=Document to text:C1236($filePath; UTF8 text without length:K22:17)
If ($fileText#"")
	//改行コードをLFに統一
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221228
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($fileText; ->$aryLines)  //add_ikeda 20221227
	
	
	//最初のテーブル名を取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryItems)
	APPEND TO ARRAY:C911(vJCL_fields_tblName; $aryItems{1})  // テーブル名
	$prefix:=$aryItems{2}
	APPEND TO ARRAY:C911(vJCL_fields_tblLabel; $aryItems{6})  // ラベル
	
	//ヘッダなし、１行目からテーブル名を探す
	For ($i; 2; $numOfLines-1)
		
		DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
		If ($aryItems{1}="-")
			//-（ハイフン）の次の行からテーブル名を取得
			DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
			$numOfItems:=JCL_str_Extract($aryLines{$i+1}; Char:C90(Tab:K15:37); ->$aryItems)
			If ($aryItems{1}#"")
				
				APPEND TO ARRAY:C911(vJCL_fields_tblName; $aryItems{1})  // テーブル名
				$prefix:=$aryItems{2}
				APPEND TO ARRAY:C911(vJCL_fields_tblLabel; $aryItems{6})  // ラベル
				$i:=$i+1  //20210210 次の行はテーブル名なので飛ばす
				
			End if 
		Else 
			//ハイフンじゃなかったらフィールド名の配列に追加
			$fldName:=$prefix+"-"+$aryItems{1}
			$label:=$aryItems{6}
			
			APPEND TO ARRAY:C911(vJCL_fields_name; $fldName)  //フィールド名
			APPEND TO ARRAY:C911(vJCL_fields_label; $label)  //フィールドラベル
			
		End if 
	End for 
End if 
//ALERT("end")
