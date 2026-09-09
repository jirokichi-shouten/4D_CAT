//JCL_Importer_PostgreSQL
//20260109 wat
//20260909 Codex/wat修正 PostgreSQLのDumpファイルのCREATE TABLE部からfields.txtを作成する機能に限定。
//20260909 Codex/wat修正 テーブル作成、インポートメソッド生成、COPY部からのレコードデータ作成は対象外。
//CREATE TABLE: データ型変換：日付はtimestamp型：日付部と時刻部がある。どうやらTWTでは時刻の部分を使っていない。日付部だけ取得する
//
//fieldsの列：フィールド名、データ型、データ長、
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
	//20260909 Codex/wat修正 dumpファイルを読込んで、CREATE TABLE部からfields.txtのみを出力
	
	C_TEXT:C284($fileText)
	C_LONGINT:C283($numOfBlocks; $b)
	ARRAY TEXT:C222($aryBlocks; 0)
	C_TEXT:C284($outBuf)
	C_TEXT:C284($block)
	C_BOOLEAN:C305($valid)
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		//20260909 Codex/wat修正 対応外の型を含むテーブルはfields.txt出力対象から除外
		$valid:=This:C1470.tableIsValid($block)
		If ($valid=True:C214)
			//dumpのCREATE TABLE部のブロックからテーブルフィールズを取得
			$outBuf:=$outBuf+This:C1470.getTableFields($block)
			
		End if 
	End for 
	
	//fields.txtに書き出し //ファイル保存ダイアログを表示
	C_TIME:C306($docRef)
	$docRef:=Create document:C266(""; "txt")
	If (OK=1)  // ドキュメントが正常に作成された場合、
		CLOSE DOCUMENT:C267($docRef)
		JCL_file_Text2Document(Document; $outBuf)  // ドキュメントに書き込み
		
	Else 
		// エラー管理
	End if 
	
Function tableIsValid($block : Text) : Boolean
	//20260314 wat@tottori
	//テーブルブロックが妥当か？taskのようにフィールドがないテーブルを排除
	//20260909 Codex/wat修正 fields.txt生成専用の妥当性チェックとして使用
	
	C_BOOLEAN:C305($0; $valid)
	$valid:=True:C214
	C_TEXT:C284($fldName)
	C_LONGINT:C283($pos1; $pos2)
	C_TEXT:C284($fieldsBlock)
	C_LONGINT:C283($cnt)
	
	//フィールド情報を取得　ブロックテキストから（）で囲まれているところを取り出す
	$pos1:=Position:C15("("; $block)
	$pos2:=Position:C15(");"; $block)
	$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
	
	$cnt:=This:C1470.countFields($fieldsBlock)
	If ($cnt=0)
		$valid:=False:C215
		
	Else 
		$valid:=True:C214
		
	End if 
	
	$0:=$valid
	
Function getTableFields($block : Text) : Text
	//20260314 wat@tottori
	//dumpのCREATE TABLE部のブロックからテーブルフィールズを取得
	
	C_TEXT:C284($0; $outBuf)
	C_TEXT:C284($tableName; $tablePrefix; $name)
	C_LONGINT:C283($pos1; $pos2)
	C_TEXT:C284($fieldsBlock)
	C_TEXT:C284($separator)
	$separator:="-"  //テーブル情報区切り文字はハイフン
	
	//dumpのCREATE TABLE部のブロックからテーブル名を取得
	$tableName:=This:C1470.getTableName($block)
	
	//テーブル名を出力
	$outBuf:=$outBuf+$tableName+Char:C90(Tab:K15:37)
	
	//テーブルプリフィックスを出力
	$tablePrefix:=This:C1470.getTablePrefix($block)
	$outBuf:=$outBuf+$tablePrefix+Char:C90(13)
	
	//フィールド情報を取得　ブロックテキストから（）で囲まれているところを取り出す
	$pos1:=Position:C15("("; $block)
	$pos2:=Position:C15(");"; $block)
	$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
	
	$outBuf:=$outBuf+This:C1470.getFields($fieldsBlock; $tablePrefix)
	
	//区切り文字を出力
	$outBuf:=$outBuf+$separator+Char:C90(13)
	//$outBuf:=$outBuf+$separator
	
	$0:=$outBuf
	
Function countFields($fieldsBlock : Text) : Integer
	//20260314 wat@tottori
	//フィールズブロックからフィールド情報を取得、有効なフィールド数を帰す
	
	C_LONGINT:C283($0; $cnt)
	$cnt:=0
	ARRAY TEXT:C222($aryLines; 0)
	C_LONGINT:C283($numOfLines; $i)
	C_OBJECT:C1216($objField)
	C_TEXT:C284($name)
	
	DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
	$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
	For ($i; 2; $numOfLines-1)
		//フィールド情報を取得
		$fieldText:=$aryLines{$i}
		$objField:=This:C1470.getFieldInfo($fieldText)
		
		If (Position:C15("XXXX"; $objField.data_type)>0)
			//無効なデータ型
			$cnt:=0
			$i:=$numOfLines-1
			
		Else 
			//カウントアップ
			$cnt:=$cnt+1
			
		End if 
	End for 
	
	$0:=$cnt
	
Function getFields($fieldsBlock : Text; $tablePrefix : Text) : Text
	//20260314 wat@tottori
	//フィールズブロックからフィールド情報を取得して出力
	
	C_TEXT:C284($0; $outBuf)
	ARRAY TEXT:C222($aryLines; 0)
	C_LONGINT:C283($numOfLines; $i)
	C_OBJECT:C1216($objField)
	C_TEXT:C284($name)
	
	DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
	$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
	For ($i; 2; $numOfLines-1)
		//フィールド情報を取得
		$fieldText:=$aryLines{$i}
		$objField:=This:C1470.getFieldInfo($fieldText)
		
		//フィールド情報を出力
		$name:=Replace string:C233($objField.name; $tablePrefix+"_"; "")  //プリフィクスをトル
		$outBuf:=$outBuf+$name+Char:C90(Tab:K15:37)
		$outBuf:=$outBuf+$objField.data_type+Char:C90(Tab:K15:37)
		$outBuf:=$outBuf+String:C10($objField.length)+Char:C90(Tab:K15:37)
		$outBuf:=$outBuf+"0"+Char:C90(Tab:K15:37)  //インデックス
		$outBuf:=$outBuf+"0"+Char:C90(Tab:K15:37)  //ユニーク
		$outBuf:=$outBuf+"from PG Dump file"+Char:C90(Tab:K15:37)  //コメント
		$outBuf:=$outBuf+"4D_CAT"+Char:C90(13)
		
	End for 
	
	$0:=$outBuf
	
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
	
Function getTablePrefix($inBlockText : Text) : Text
	//20260313 wat
	//dumpのCREATE TABLE部のブロックからテーブルプリフィックスを取得
	//フィールド情報を取得して、最初のフィールド名からアンダーバーまでの文字列を取得
	
	C_TEXT:C284($block)
	$block:=$inBlockText
	C_LONGINT:C283($pos1; $pos2)
	C_TEXT:C284($fieldsBlock)
	ARRAY TEXT:C222($aryLines; 0)
	C_LONGINT:C283($numOfLines)
	C_OBJECT:C1216($objField)
	
	//フィールド情報を取得　ブロックテキストから（）で囲まれているところを取り出す
	$pos1:=Position:C15("("; $block)
	$pos2:=Position:C15(");"; $block)
	$fieldsBlock:=Substring:C12($block; $pos1; ($pos2-$pos1)+Length:C16(");"))
	$numOfLines:=JCL_str_Extract_byReturn($fieldsBlock; ->$aryLines)
	$fieldText:=$aryLines{2}
	C_OBJECT:C1216($objField)
	$objField:=This:C1470.getFieldInfo($fieldText)
	
	//アンダーバーまでがテーブルプリフィクス
	$pos:=Position:C15("_"; $objField.name)
	$0:=Substring:C12($objField.name; 1; $pos-1)
	
Function getFieldInfo($inText : Text) : Object
	//20260114 wat
	//dumpのフィールドブロックテキストからフィールド情報を取得、オブジェクト型で返す
	
	C_OBJECT:C1216($0; $objField)
	$objField:=New object:C1471
	C_TEXT:C284($dataType)
	C_LONGINT:C283($pos1; $pos2)
	
	//initial
	$objField.length:=0
	$objField.data_type:="XXXX"
	
	Case of 
		: (Position:C15(" integer"; $inText)>0)
			$dataType:="integer"
			$objField.data_type:="Is LongInt"
			
		: (Position:C15(" timestamp "; $inText)>0)
			$dataType:="timestamp"
			$objField.data_type:="Is Date"
			
		: (Position:C15("character varying"; $inText)>0)
			$dataType:="character varying"
			$pos1:=Position:C15("("; $inText)
			$pos2:=Position:C15(")"; $inText)
			$lengthText:=Substring:C12($inText; $pos1+1; ($pos2-$pos1)-1)
			$objField.length:=Num:C11($lengthText)
			$objField.data_type:="Is Alpha Field"
			
		: (Position:C15(" text"; $inText)>0)
			$dataType:="text"
			$objField.data_type:="Is Text"
			
		: (Position:C15(" date"; $inText)>0)
			$dataType:="date"
			$objField.data_type:="Is Date"
			
		Else 
			//JCL_file_Logout("else $inText=["+$inText+"]")
			
	End case 
	
	If ($objField.data_type="XXXX")
		JCL_file_Logout("XXXX: $inText=["+$inText+"]")
		
	End if 
	
	//名前を切り出す、スペースを取り除く
	$objField.name:=This:C1470.extractName($inText)
	
	$0:=$objField
	
Function extractName($inText : Text) : Text
	//20260315 wat@tottori
	//名前を切り出す、スペースを取り除く
	
	C_TEXT:C284($0; $outText)
	C_LONGINT:C283($pos)
	C_LONGINT:C283($len; $i)
	C_TEXT:C284($buf)
	$buf:=$inText
	
	//前のスペースをトル
	$len:=Length:C16($buf)
	For ($i; 1; $len)
		//1文字目を評価
		$char:=Substring:C12($buf; 1; 1)
		If ($char=" ")
			//1文字目を削除
			$buf:=Substring:C12($buf; 2)
			
		End if 
	End for 
	
	//名前のあとのスペースを探す
	$pos:=Position:C15(" "; $buf)
	$outText:=Substring:C12($buf; 1; $pos-1)
	
	$0:=$outText
