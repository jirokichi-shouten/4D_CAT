//JCL_Importer_PostgreSQL
//20260109 wat
//PostgreSQLのDumpファイルを取り込む。
//　Create Table部からfields.txtを作成、インポートメソッドを生成
//　COPY部からレコードデータを作成
//CREATE TABLE: データ型変換：日付はtimestamp型：日付部と時刻部がある。どうやらTWTでは時刻の部分を使っていない。日付部だけ取得する
//
//前提条件：テーブル名、フィールド名はすべて英字で始まる半角英数字
//　データの中に改行コードは含まれていないこと
//　日付がtimestamp型の場合、時刻は0時0分0秒とする。時刻部分は

Class constructor
	
Function readDumpFile
	//20260110 dumpファイルをバッファに取得
	
	C_OBJECT:C1216($myFile)
	$myFile:=New object:C1471
	C_TEXT:C284($0; $fileText)
	
	$document_path:=Select document:C905(111; ""; "PostgreSQLのDumpファイルを選択してください。"; 0)
	$open_ok:=OK
	If ($open_ok=1)
		//システム変数Documentにプラットフォームパスが返されている
		$myFile:=File:C1566(Document; fk platform path:K87:2)
		
		$fileText:=$myFile.getText("UTF-8"; Document with LF:K24:22)
		
	End if 
	
	$0:=$fileText
	
Function importer
	//20260111 wat
	//dumpファイルを読込んで、fields.txtを出力、インポートメソッドを出力
	
	C_TEXT:C284($fileText)
	C_LONGINT:C283($numOfBlocks)
	ARRAY TEXT:C222($aryBlocks; 0)
	C_LONGINT:C283($b)
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($b; 1; $numOfBlocks)
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		//dumpのCREATE TABLE部のブロックからテーブル名を取得
		$tableName:=This:C1470.getTableName($block)
		
		//フィールドブロックを取得
		$pos1:=Position:C15("("; $block)
		$pos2:=Position:C15(");"; $block)
		$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
		
		DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
		$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
		For ($i; 2; $numOfLines-1)
			//フィールド情報は最初の行は（だけ、最後の行は）だけなので無視
			$fieldText:=$aryLines{$i}
			
			//フィールド情報を取得
			C_OBJECT:C1216($objField)
			$objField:=$csImporter_PostgreSQL.getFieldInfo($fieldText)
			
			
		End for 
		
	End for 
	
	
	//fields.txtに書き出し
	
	//ループ：インポートメソッドを出力
	
	
Function getTableName($inBlockText : Text) : Text
	//20260112 wat
	//dumpのCREATE TABLE部のブロックからテーブル名を取得
	//ピリオドからスペースまでがテーブル名
	
	C_TEXT:C284($block)
	$block:=$inBlockText
	C_LONGINT:C283($pos)
	
	//ピリオドまでの文字列をトル
	$pos:=Position:C15("."; $block)
	$block:=Replace string:C233($block; Substring:C12($block; 1; $pos); "")
	
	//スペースまでがテーブル名
	$pos:=Position:C15(" "; $block)
	$0:=Substring:C12($block; 1; $pos-1)
	
Function getFieldInfo($inText : Text) : Object
	//20260114 wat
	
	C_OBJECT:C1216($0; $objField)
	$objField:=New object:C1471
	C_TEXT:C284($dataType)
	C_LONGINT:C283($pos1; $pos2)
	
	//initial
	$objField.length:=0
	$objField.data_type:="XXXX"
	
	Case of 
		: (Position:C15("integer"; $inText)>0)
			$dataType:="integer"
			$objField.data_type:="Is LongInt"
			
		: (Position:C15("timestamp"; $inText)>0)
			$dataType:="timestamp"
			$objField.data_type:="Is Date"
			
		: (Position:C15("character varying"; $inText)>0)
			$dataType:="character varying"
			$pos1:=Position:C15("("; $inText)
			$pos2:=Position:C15(")"; $inText)
			$lengthText:=Substring:C12($inText; $pos1+1; ($pos2-$pos1)-1)
			$objField.length:=Num:C11($lengthText)
			$objField.data_type:="Is Alpha Field"
			
		: (Position:C15("text"; $inText)>0)
			$dataType:="text"
			$objField.data_type:="Is Text"
			
		: (Position:C15("Date"; $inText)>0)
			$dataType:="Date"
			$objField.data_type:="Is Date"
			
	End case 
	
	//名前を切り出す、スペースを取り除く
	$pos:=Position:C15($dataType; $inText)
	$name:=Substring:C12($inText; 1; $pos-1)  //データ型の前の文字列を取り出す
	$objField.name:=Replace string:C233($name; " "; "")  //スペースをトル
	
	$0:=$objField
	
Function getAryFields($inBlockText : Text; $inAryObjPtr : Pointer) : Text
	//20260112 wat
	
	C_TEXT:C284($block)
	$block:=$inBlockText
	C_LONGINT:C283($pos1; $pos2)
	C_TEXT:C284($fieldsBlock)
	ARRAY TEXT:C222($aryLines; 0)
	C_LONGINT:C283($i; $numOfLines)
	
	$pos1:=Position:C15("("; $block)
	$pos2:=Position:C15(");"; $block)
	$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
	
	$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
	For ($i; 2; $numOfLines-1)
		
	End for 
	
	
	
	
	