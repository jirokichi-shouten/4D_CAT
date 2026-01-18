//%attributes = {}
//zz_test_select_document
//20260110 wat

C_OBJECT:C1216($myFile)
$myFile:=New object:C1471
C_TEXT:C284($fileText)
C_LONGINT:C283($numOfBlocks; $b)
C_LONGINT:C283($pos)
ARRAY TEXT:C222($aryBlocks; 0)
ARRAY TEXT:C222($aryLines; 0)
C_LONGINT:C283($numOfLines; $i)

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
		//フィールド情報を出力
		
		//$pos:=Position("."; $block)
		//$block:=Replace string($block; Substring($block; 1; $pos); "")
		
		//$pos:=Position(" "; $block)
		//$tableName:=Substring($block; 1; $pos-1)
		JCL_file_Logout("["+$tableName+"]")
		
		//dumpのCOPY部のブロックからフィールド情報を取得
		//ARRAY OBJECT($aryObj; 0)
		//$cnt:=$csImporter_PostgreSQL.getAryFields($block; ->$aryObj)
		
		$pos1:=Position:C15("("; $block)
		$pos2:=Position:C15(");"; $block)
		$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
		
		DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
		$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
		For ($i; 2; $numOfLines-1)
			//データ型
			$fieldText:=$aryLines{$i}
			
			C_OBJECT:C1216($objField)
			$objField:=$csImporter_PostgreSQL.getFieldInfo($fieldText)
			
			
			//JCL_file_Logout("["+$objField.name+"]")
			//JCL_file_Logout("["+$objField.data_type+"]")
			//JCL_file_Logout("["+String($objField.length)+"]")
			
		End for 
		
		//If ($pos>0)
		//$block:=Substring($block; $pos+1)
		
		JCL_file_Logout("")
		
		//End if 
		
		
	End for 
	
	C_TEXT:C284($m)
	$m:=$m+"$numOfBlocks:=["+String:C10($numOfBlocks)+"]"+Char:C90(13)
	$m:=$m+"Document=["+Document+"]"+Char:C90(13)
	$m:=$m+"path=["+$myFile.path+"]"+Char:C90(13)
	$m:=$m+"contents=["+Substring:C12($fileText; 1; 100)+"]"
	ALERT:C41($m)
	
End if 

