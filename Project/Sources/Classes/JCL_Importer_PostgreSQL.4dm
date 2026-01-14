//JCL_Importer_PostgreSQL
//20260109 wat
//PostgreSQLのDumpファイルを取り込む。
//　Create Table部からfields.txtを作成、インポートメソッドを生成
//　COPY部からレコードデータを作成
//CREATE TABLE: データ型変換：日付はtimestamp型：日付部と時刻部がある。どうやらTWTでは時刻の部分を使っていない。日付部だけ取得する

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
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($i; 1; $numOfBlocks)
		$block:=JCL_str_unifyLF($aryBlocks{$i})
		
		//dumpのCREATE TABLE部のブロックからテーブル名を取得
		$tableName:=This:C1470.getTableName($block)
		
		
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
	
Function getFieldInfo($inText : Text; $outObj : Object) : Boolean
	//20260114 wat
	
	C_TEXT:C284($dataType)
	C_LONGINT:C283($pos1; $pos2)
	
	Case of 
		: (Position:C15("integer"; $inText)>0)
			$dataType:="integer"
			
		: (Position:C15("date"; $inText)>0)
			$dataType:="date"
			
		: (Position:C15("timestamp"; $inText)>0)
			$dataType:="timestamp"
			
		: (Position:C15("character varying"; $inText)>0)
			$dataType:="character varying"
			$pos1:=Position:C15("("; $inText)
			$pos2:=Position:C15(")"; $inText)
			$lengthText:=Substring:C12($inText; $pos1+1; ($pos2-$pos1)-1)
			$length:=Num:C11($lengthText)
			
	End case 
	$pos:=Position:C15($dataType; $inText)
	
	//切り出す、スペースを取り除く
	$name:=Substring:C12($inText; 1; $pos)
	$name:=Replace string:C233($name; " "; "")
	
	
	
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
	
	
	
	
	