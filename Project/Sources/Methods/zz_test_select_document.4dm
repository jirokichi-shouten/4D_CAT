//%attributes = {}
//zz_test_select_document
//20260110 wat

C_TEXT:C284($outBuf)
$outBuf:=""
C_OBJECT:C1216($myFile)
$myFile:=New object:C1471
C_TEXT:C284($fileText)
C_LONGINT:C283($numOfBlocks; $b)
C_LONGINT:C283($pos)
ARRAY TEXT:C222($aryBlocks; 0)
ARRAY TEXT:C222($aryLines; 0)
C_LONGINT:C283($numOfLines; $i)
C_TEXT:C284($tableName; $tablePrefix; $name)

$document_path:=Select document:C905(111; ""; "PostgreSQLのDumpファイルを選択してください。"; 0)
$open_ok:=OK
If ($open_ok=1)
	//システム変数Documentにプラットフォームパスが返されている
	$myFile:=File:C1566(Document; fk platform path:K87:2)
	$fileText:=$myFile.getText("UTF-8"; Document with LF:K24:22)
	
	JCL_file_Logout("["+$myFile.name+"]")
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		C_OBJECT:C1216($csImporter_PostgreSQL)
		$csImporter_PostgreSQL:=cs:C1710.JCL_Importer_PostgreSQL.new()
		
		//dumpのCREATE TABLE部のブロックからテーブル名を取得
		$tableName:=$csImporter_PostgreSQL.getTableName($block)
		
		//テーブル名を出力
		$outBuf:=$outBuf+$tableName+Char:C90(Tab:K15:37)
		
		//テーブルプリフィックスを出力
		$tablePrefix:=$csImporter_PostgreSQL.getTablePrefix($block)
		$outBuf:=$outBuf+$tablePrefix+Char:C90(13)
		
		//フィールド情報を取得　ブロックテキストから（）で囲まれているところを取り出す
		$pos1:=Position:C15("("; $block)
		$pos2:=Position:C15(");"; $block)
		$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
		
		DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
		$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
		For ($i; 2; $numOfLines-1)
			//フィールド情報を取得
			$fieldText:=$aryLines{$i}
			
			C_OBJECT:C1216($objField)
			$objField:=$csImporter_PostgreSQL.getFieldInfo($fieldText)
			
			//フィールド情報を出力
			$name:=Replace string:C233($objField.name; $tablePrefix+"_"; "")  //プリフィクスをトル
			$outBuf:=$outBuf+$name+Char:C90(Tab:K15:37)
			$outBuf:=$outBuf+$objField.data_type+Char:C90(Tab:K15:37)
			$outBuf:=$outBuf+String:C10($objField.length)+Char:C90(Tab:K15:37)
			$outBuf:=$outBuf+"4D_CAT"+Char:C90(13)
			
		End for 
	End for 
	
	//ファイル保存ダイアログを表示
	C_TIME:C306($docRef)
	//$docRef:=Create document("fields"; "txt")
	$docRef:=Create document:C266(""; "txt")
	If (OK=1)  // ドキュメントが正常に作成された場合、
		CLOSE DOCUMENT:C267($docRef)
		JCL_file_Text2Document(Document; $outBuf)  // ドキュメントに書き込み
		
	Else 
		// エラー管理
	End if 
	
	//create index部を探す
	DELETE FROM ARRAY:C228($aryBlocks; 1; Size of array:C274($aryBlocks))
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE INDEX "; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		//dumpのCREATE INDEX 部のブロックからインデックスフィールド名を取得
		C_OBJECT:C1216($objIndex)
		$objIndex:=$csImporter_PostgreSQL.getIndexName($block)
		
		JCL_file_Logout("["+$objIndex.table_name+"]")
		JCL_file_Logout("["+$objIndex.field_name+"]")
		JCL_file_Logout("["+$objIndex.index_type+"]")
		
	End for 
	
	
	
	JCL_file_Logout("end")
	
	
	C_TEXT:C284($m)
	$m:=$m+"$numOfBlocks:=["+String:C10($numOfBlocks)+"]"+Char:C90(13)
	$m:=$m+"Document=["+Document+"]"+Char:C90(13)
	$m:=$m+"path=["+$myFile.path+"]"+Char:C90(13)
	$m:=$m+"contents=["+Substring:C12($fileText; 1; 100)+"]"
	ALERT:C41($m)
	
End if 

