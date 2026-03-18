//JCL_Importer_PostgreSQL
//20260109 wat
//PostgreSQLのDumpファイルを取り込む。
//　Create Table部からfields.txtを作成、インポートメソッドを生成
//　COPY部からレコードデータを作成
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
	//dumpファイルを読込んで、fields.txtを出力、インポートメソッドを出力
	
	C_TEXT:C284($fileText)
	C_LONGINT:C283($numOfBlocks; $b)
	ARRAY TEXT:C222($aryBlocks; 0)
	C_TEXT:C284($outBuf)
	C_TEXT:C284($block)
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		//dumpのCREATE TABLE部のブロックからテーブルフィールズを取得
		$outBuf:=$outBuf+This:C1470.getTableFields($block)
		
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
	
Function creater
	//20260314 wat@tottori
	//dumpファイルを読込んで, テーブル作成
	
	C_TEXT:C284($fileText)
	C_LONGINT:C283($numOfBlocks; $b)
	ARRAY TEXT:C222($aryBlocks; 0)
	C_LONGINT:C283($numOfLines; $i)
	C_TEXT:C284($block; $fieldsBlock)
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "CREATE TABLE "; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		$block:=JCL_str_unifyLF($aryBlocks{$b})
		
		$valid:=This:C1470.tableIsValid($block)
		If ($valid=True:C214)
			//dumpのCREATE TABLE部のブロックからテーブルフィールズを取得
			$fieldsBlock:=This:C1470.getTableFields($block)
			
			This:C1470.createTable($fieldsBlock)
			
		End if 
	End for 
	
Function data_loader
	//20260317 wat@tottori
	//dumpファイルを読込んで、データインサート。テーブルは作成されてある前提
	//COPY public.client (cl_code, ...でフィールド名を切り出す
	//メソッドテンプレートを読込んでメソッドを生成　続くデータブロックで値を切り出す
	
	C_TEXT:C284($fileText)
	C_TEXT:C284($methodName; $templateFileName)
	ARRAY TEXT:C222($aryBlocks; 0)
	C_LONGINT:C283($numOfBlocks; $b)
	C_TEXT:C284($block)
	C_LONGINT:C283($pos; $pos1; $pos2; $pos3; $pos4)
	C_TEXT:C284($tableName)
	C_TEXT:C284($fieldsBlock; $dataBlock)
	ARRAY TEXT:C222($aryLines; 0)
	C_LONGINT:C283($numOfLines; $i)
	ARRAY TEXT:C222($aryItems; 0)
	C_LONGINT:C283($numOfItems; $k)
	C_TEXT:C284($buf)
	C_OBJECT:C1216($file)
	
	$templateFileName:="[--TBL_PREFIX]_Add_byPG_Dump"
	
	$fileText:=This:C1470.readDumpFile()
	
	$numOfBlocks:=JCL_str_Extract($fileText; "COPY public."; ->$aryBlocks)
	For ($b; 2; $numOfBlocks)
		//テーブル情報を2つ目以降の配列要素から取得
		$block:=$aryBlocks{$b}
		$block:=Replace string:C233($block; Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40); Char:C90(13))  //先にCRLFを置き換える
		$block:=Replace string:C233($block; Char:C90(Line feed:K15:40); Char:C90(13))  //残ったLFを置き換える
		
		$pos:=Position:C15(" "; $block)
		$tableName:=Substring:C12($block; 1; $pos-1)
		
		$file:=File:C1566("/RESOURCES/JCL4D_Resources/method_templates_PG/"+$templateFileName)
		$methodName:=$file.name
		$buf:=$file.getText("UTF-8"; Document with LF:K24:22)
		$buf:=Replace string:C233($buf; "[--TABLE]"; $tableName)
		
		//dumpのCOPY部のブロックからフィールド列挙（フィールズ）ブロックを取得
		$pos1:=Position:C15("("; $block)
		$pos2:=Position:C15(")"; $block)
		$fieldsBlock:=Substring:C12($block; $pos1; $pos2-$pos1+1)
		
		$numOfItems:=JCL_str_Extract($fieldsBlock; Char:C90(Tab:K15:37); ->$aryItems)
		//テーブル接頭辞を取得
		$pos:=Position:C15("_"; $aryItems{1})
		$tbl_prefix:=Substring:C12($aryItems{1}; 1; $pos-1)
		$buf:=Replace string:C233($buf; "[--TBL_PREFIX]"; $tbl_prefix)
		
		For ($i; 1; $numOfItems)
			$fieldName:=$aryItems{$i}
			
			//[assign]as_pr_id:=Num($aryItems{1}
			$itemValue:=This:C1470.getValue($fieldType; 
			
			
			$fields_buf:="["+$tableName+"]"+$fieldName+":=$aryItems{"+String:C10($i)+"}"
			$importItem:=cs:C1710.JCL_tbl.new().importItem($aryFieldTypePtr->{$k}; "$aryItemPtr->{"+String:C10($k)+"}")
			$newRow:=Replace string:C233($newRow; "[--IMPORTITEM]"; $importItem)
			
		End for 
		$buf:=Replace string:C233($buf; "[--FIELD]"; $tbl_prefix)
		
		
		
		//データブロックはstdinの次の行に続くスペース区切りの文字列
		$key:="stdin;"
		$pos3:=Position:C15($key; $block; $pos2)+2
		$pos4:=Position:C15("\\."; $block; $pos3)
		$dataBlock:=Substring:C12($block; $pos3+Length:C16($key); $pos4-$pos3)
		
		$numOfLines:=JCL_str_Extract($dataBlock; Char:C90(13); ->$aryLines)
		For ($i; 1; $numOfLines)
			$values:=$aryLines{$i}
			$numOfItems:=JCL_str_Extract($values; Char:C90(Tab:K15:37); ->$aryItems)
			For ($k; 1; $numOfItems)
				
			End for 
			
			//$sql:=$sql+"("+Substring($values; 1; Length($values)-1)+"), "
			$sql:=$sql+"("+$values+"), "
			
		End for 
		//最後のカンマをトル
		$sql:=Substring:C12($sql; 1; Length:C16($sql)-2)
		
		JCL_file_Logout($sql)
		
		JCL_err_OnErrCall_sql($sql)
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		SQL EXECUTE:C820($sql)
		SQL LOGOUT:C872
		$error:=JCL_err_OnErrCall_stop
		
	End for 
	
	
Function tableIsValid($block : Text) : Boolean
	//20260314 wat@tottori
	//テーブルブロックが妥当か？taskのようにフィールドがないテーブルを排除
	
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
	
Function createTable($block : Text) : Integer
	//20260314 wat@tottori
	//フィールズブロックからテーブル作成
	
	C_LONGINT:C283($0; $numOfTbls)
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	ARRAY TEXT:C222($aryFieldItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	C_TEXT:C284($sql)
	C_TEXT:C284($fldName; $tblName; $prefix; $fldFullName)
	C_BOOLEAN:C305($id_exist)  //20260317
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract($block; Char:C90(13); ->$aryLines)
	
	//１行目からテーブル情報取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
	$tblName:=$aryTableItems{1}  //テーブル名
	$prefix:=$aryTableItems{2}  //プリフィックス
	
	//テーブル作成　２行目以降のフィールド情報でSQL文を組み立てて実行
	$sql:="CREATE TABLE "+$tblName+"("
	
	For ($i; 2; $numOfLines-2)
		//フィールド名とか切り出し
		DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
		
		//ＳＱＬのカラム定義節を組み立て
		$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")  //フィールド名にスペースがあったらアンダースコアに置き換える
		If ($fldName="")
			JCL_file_Logout("NO NAME? $fldName=["+$fldName+"]"+$aryLines{$i})
			
		End if 
		$fldFullName:=$prefix+"_"+$fldName
		$typeStr:=JCL_tbl_Type_SQL($aryFieldItems{2}; $aryFieldItems{3}; $aryFieldItems{5})  //20240121
		$sql:=$sql+$fldFullName+$typeStr
		
		//idフィールドがあるかどうかを判定 20260317
		If ($fldName="id")
			$id_exist:=True:C214
			
		End if 
	End for 
	
	//最後のカンマのあとにプライマリーキーを追加して括弧とセミコロンを追加
	If ($id_exist=True:C214)
		//idフィールドがある場合だけ
		$sql:=$sql+" PRIMARY KEY("+$prefix+"_ID));"
		
	Else 
		//idフィールドがない場合、最後のカンマをトル、カッコで閉じる
		$sql:=Substring:C12($sql; 1; Length:C16($sql)-1)
		$sql:=$sql+");"
		
	End if 
	
	JCL_file_Logout($sql)
	
	JCL_err_OnErrCall_sql($sql)
	SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
	SQL EXECUTE:C820($sql)
	SQL LOGOUT:C872
	$error:=JCL_err_OnErrCall_stop
	$0:=$numOfTbls
	
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
		$outBuf:=$outBuf+"from PG Dump file"+Char:C90(Tab:K15:37)  //ユニーク
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
	
Function getIndexName($inBlockText : Text) : Object
	//20260112 wat
	//dumpのインデックスブロックテキストからインデックス情報を取得、オブジェクト型で返す
	
	C_OBJECT:C1216($0; $objIndex)
	$objIndex:=New object:C1471
	C_TEXT:C284($block)
	$block:=$inBlockText
	ARRAY TEXT:C222($aryLines; 0)
	
	$objIndex.table_name:=This:C1470.getTableName($inBlockText)
	
	$pos1:=Position:C15("("; $block)
	$pos2:=Position:C15(");"; $block)
	$objIndex.field_name:=Substring:C12($inBlockText; $pos1+1; ($pos2-$pos1)-1)
	
	//index type
	$pos:=Position:C15("USING "; $block)
	//USINGまでの文字列をトル
	$block:=Replace string:C233($block; Substring:C12($block; 1; $pos+Length:C16("USING ")-1); "")
	
	//スペースまでがテーブル名
	$pos:=Position:C15(" "; $block)
	$objIndex.index_type:=Substring:C12($block; 1; $pos-1)
	
	$0:=$objIndex
	
Function createImportMethod()
	//20260316 wat@tottori
	//インポートメソッド作成、テンプレートと読込んで
	
	$numOfFields:=Get last field number:C255([assign:18]->)
	
	