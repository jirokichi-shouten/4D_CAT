//JCL_tg
//JCL Table Generator and related functions
//20240316 yabe wat
//JCLのうちテーブル関連のメソッド群

Class constructor
	
Function createTable($inBlockText : Text)
	//fieldsのテキストブロックからSQL文を作成、実行してテーブル作成
	//20240121 yabe wat UNIQUE 追加。
	//20240209 wat PRIMARY KEY追加。INDEX修正。
	
	//C_TEXT($1; $inBlockText)
	//$inBlockText:=$1  //ブロックの中身
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	ARRAY TEXT:C222($aryFieldItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	C_TEXT:C284($sql)
	C_TEXT:C284($fldName; $tblName; $prefix; $fldFullName)
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)
	
	//テーブル情報取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
	$tblName:=$aryTableItems{1}  //テーブル名
	$prefix:=$aryTableItems{2}  //プリフィックス
	
	//テーブル作成　SQLで作成
	$sql:="CREATE TABLE "+$tblName+"("
	
	For ($i; 2; $numOfLines)
		//フィールド名とか切り出し
		DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
		
		//ＳＱＬのカラム定義節を組み立て
		$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")  //フィールド名にスペースがあったらアンダースコアに置き換える
		$fldFullName:=$prefix+"_"+$fldName
		$typeStr:=JCL_tbl_Type_SQL($aryFieldItems{2}; $aryFieldItems{3}; $aryFieldItems{5})  //20240121
		$sql:=$sql+$fldFullName+$typeStr
		
	End for 
	
	//最後のカンマのあとにプライマリーキーを追加して括弧とセミコロンを追加
	$sql:=$sql+" PRIMARY KEY("+$prefix+"_ID));"
	
	JCL_err_OnErrCall_sql($sql)
	SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
	SQL EXECUTE:C820($sql)
	SQL LOGOUT:C872
	$error:=JCL_err_OnErrCall_stop
	
	return $error
	
Function createLabelFile($inBlockText : Text)
	//fieldsのテキストブロックからラベルファイルを作成
	//20240316 wat 
	
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	ARRAY TEXT:C222($aryFieldItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	C_TEXT:C284($file_name)
	C_TEXT:C284($fldName; $tblName; $prefix; $fldFullName)
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)
	
	//テーブル情報取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
	$tblName:=$aryTableItems{1}  //テーブル名
	$file_name:=$tblName+".txt"  //ファイル名
	
	//ファイル作成
	C_OBJECT:C1216($folder)
	$folder:=New object:C1471
	$folder:=Folder:C1567("/RESOURCES/JCL4D_Resources/fields_labels/")
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	$file:=$folder.file($file_name)
	//$file:=File("/RESOURCES/JCL4D_Resources/fields_labels/"+$file_name).create()
	$file.setText($inBlockText)
	
	return $error
	
Function deleteLabelFile($tblName : Text)
	//リソースフォルダのラベルファイルを削除
	//20240316 wat 
	
	C_TEXT:C284($file_name)
	$file_name:=$tblName+".txt"  //ファイル名
	
	//ファイル削除
	C_OBJECT:C1216($folder)
	$folder:=New object:C1471
	$folder:=Folder:C1567("/RESOURCES/JCL4D_Resources/fields_labels/")
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	$file:=File:C1566("/RESOURCES/JCL4D_Resources/fields_labels/"+$file_name).delete()
	
	return $error
	
Function getTableLabel($tblName : Text)
	
	return 
	
Function createIndex($inBlockText : Text)
	//インデックス作成は４Dのコマンドで作成する
	//引数１：ブロックの中身
	//C_TEXT($1; $inBlockText)
	//$inBlockText:=$1  //ブロックの中身
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	ARRAY TEXT:C222($aryFieldItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	C_TEXT:C284($fldName; $tblName; $prefix; $fldFullName)
	ARRAY POINTER:C280($fldAry; 0)
	C_POINTER:C301($fldPtr)
	C_LONGINT:C283($retCode)
	C_TEXT:C284($indexName)
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)
	
	//テーブル情報取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
	$tblName:=$aryTableItems{1}  //テーブル名
	$prefix:=$aryTableItems{2}  //プリフィックス
	
	For ($i; 2; $numOfLines)
		//フィールド名切り出し
		DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
		
		//インデックス作成
		If ($aryFieldItems{4}="1")
			
			$tblPtr:=JCL_tbl_Ptr_byName($tblName)
			$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")
			$fldFullName:=$prefix+"_"+$fldName
			$retCode:=JCL_tbl_Fld_GetPtr($tblPtr; $fldFullName; ->$fldPtr)
			If ($retCode=0)
				//フィールドポインタの配列を作ってわたす
				DELETE FROM ARRAY:C228($fldAry; 1; Size of array:C274($fldAry))
				APPEND TO ARRAY:C911($fldAry; $fldPtr)
				
				$indexName:=$fldFullName+"_index"
				CREATE INDEX:C966($tblPtr->; $fldAry; 0; $indexName)
				
			End if 
		End if 
	End for 
	
	return 
	
Function createMethod($inBlockText : Text)
	//JCL_tbl_Create_method
	//20211228 jiro
	//モデルメソッド群をテンプレートから作成
	
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)
	
	//テーブル情報取得
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
	
	
	ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
	ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
	ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
	ARRAY TEXT:C222($aryFieldIndex; 0)
	JCL_tbl_Fields_withAttr($aryTableItems{1}; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	
	//テンプレートフォルダの場所
	$templateFolderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
	$templateFolderPath:=JCL_file_MakeFilePath($templateFolderPath; "JCL4D_Resources")
	$templateFolderPath:=JCL_file_MakeFilePath($templateFolderPath; "method_templates_model")
	DOCUMENT LIST:C474($templateFolderPath; $aryFileName; Ignore invisible:K24:16)  //.DS_Storeを除く
	For ($i; 1; Size of array:C274($aryFileName))
		//テンプレートの中身を取得
		$templateFileName:=$aryFileName{$i}
		$templateFilePath:=JCL_file_MakeFilePath($templateFolderPath; $aryFileName{$i})
		DOCUMENT TO BLOB:C525($templateFilePath; $blob)
		$body:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
		
		// タグを置き換えて、所定のフォルダに書き出す
		JCL_prj_FG_methods_One($body; $aryTableItems{1}; $aryTableItems{2}; $templateFileName; ->$aryFieldName; ->$aryFieldType)
		
	End for 
	
	return 
	
Function blocks_extract($inFileText : Text; $outAryBlokPtr : Pointer) : Integer
	//JCL_tbl_Blocks_fromFile
	//20240114 yabe wat
	//fields.txtからテーブル文字列ブロックを切り出して配列で取得
	//読み込んだファイルの中身
	//C_POINTER($2; $outAryBlokPtr)
	//$outAryBlokPtr:=$2  //フィールド定義行のテキストブロック、タブ改行区切り
	C_LONGINT:C283($cnt)  //戻り値
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	C_TEXT:C284($block; $separator)
	$block:=""
	$separator:="-"  //テーブル情報区切り文字はハイフン
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$aryLines)  //add_ikeda 20221227
	For ($i; 1; $numOfLines)
		//
		DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
		If ($aryItems{1}=$separator)
			//最後の改行を削除
			$block:=Substring:C12($block; 1; Length:C16($block)-1)
			
			//配列に追加
			APPEND TO ARRAY:C911($outAryBlokPtr->; $block)
			$block:=""  //バッファクリア
			$cnt:=$cnt+1
			
		Else 
			//文字連結で返す
			$block:=$block+$aryLines{$i}+Char:C90(Line feed:K15:40)
			
		End if 
	End for 
	
	return $cnt
	
Function fieldsCheck($block : Text) : Integer
	//JCL_tbl_Check_fieldsFile
	//20111005 wat
	//20121001 wat rename, 20130429 wat mod , 20130430 mod
	//20150826 yabe フォーム作成フラグ追加
	//テーブル名の配列を得る
	//20240114 yabe wat テーブル区切りはアンダースコアではなくハイフンに統一
	//20240114 yabe wat refactor
	
	C_TEXT:C284($1; $inFileText)
	$inFileText:=$1  //読み込んだファイルの中身
	C_LONGINT:C283($errFlag)
	$errFlag:=0
	ARRAY TEXT:C222($arylines; 0)
	ARRAY TEXT:C222($aryTableItems; 0)
	ARRAY TEXT:C222($aryFieldItems; 0)
	C_LONGINT:C283($numOfLines; $numOfItems)
	ARRAY TEXT:C222($aryBlock; 0)  //20240114
	C_TEXT:C284($msg)
	C_OBJECT:C1216($jcl_tg)
	$jcl_tg:=cs:C1710.JCL_tg.new()
	
	//テーブル名の配列を得る
	//$numOfTables:=JCL_tbl_Blocks_fromFile($inFileText; ->$aryBlock)
	$numOfTables:=$jcl_tg.blocks_extract($inFileText; ->$aryBlock)
	If ($numOfTables=0)
		//エラーメッセージ
		$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+"fields.txtのファイルフォーマットを確認してください。"
		ALERT:C41($msg)
		$errFlag:=1
		
	Else 
		For ($k; 1; $numOfTables)
			//改行で切り分ける
			DELETE FROM ARRAY:C228($arylines; 1; Size of array:C274($arylines))
			$numOfLines:=JCL_str_Extract_byReturn($aryBlock{$k}; ->$arylines)
			If ($numOfLines>1)
				//テーブル情報取得
				DELETE FROM ARRAY:C228($aryTableItems; 1; Size of array:C274($aryTableItems))
				$numOfItems:=JCL_str_Extract($arylines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
				If ($numOfItems>6)
					//テーブル名に予約語が使われていないかチェック
					$found_reserved:=This:C1470.fields_check_sql_reserved($aryTableItems{1})
					If ($found_reserved=True:C214)
						//テーブル名がSQL予約語
						$msg:="テーブル名を変更してください"+Char:C90(Carriage return:K15:38)
						$msg:=$msg+"テーブル名「"+$aryTableItems{1}+"」にSQL予約語が使われています。"
						ALERT:C41($msg)
						
						//リストボックスの該当行のエラーを「あり」に変更
						
					End if 
				Else 
					//ブロックに配列要素が３個以上なかった
					$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
					$msg:=$msg+"テーブル名の行のフォーマットが正しくないようです。"
					ALERT:C41($msg)
					$k:=$numOfTables
					$errFlag:=1
					
				End if 
			Else 
				//ブロックに配列要素が２個以上なかった
				$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
				$msg:=$msg+"テーブル情報が不足しています。"
				ALERT:C41($msg)
				$k:=$numOfTables
				$errFlag:=1
				
			End if 
			
		End for 
	End if 
	
	return $errFlag
	
Function fields_check_sql_reserved($tbl_name : Text) : Boolean
	//20240313 wat
	//テーブル名にSQLの予約語が使われていないかチェック
	//Resourcesのsql_reservedフォルダに入っている複数のファイルについてチェックする
	
	ARRAY TEXT:C222($aryKeywords; 0)
	C_LONGINT:C283($i)
	C_COLLECTION:C1488($files)
	C_TEXT:C284($sql_keywords)
	C_LONGINT:C283($index)
	C_BOOLEAN:C305($found_reserved)
	$found_reserved:=False:C215
	
	$files:=New collection:C1472
	$files:=Folder:C1567("/RESOURCES/JCL4D_Resources/sql_reserved/").files(fk ignore invisible:K87:22)
	For ($i; 1; $files.length)
		// ファイルの中身を取得
		$sql_keywords:=$files[$i-1].getText("UTF-8"; Document with LF:K24:22)
		$cnt:=JCL_str_Extract($sql_keywords; Char:C90(Line feed:K15:40); ->$aryKeywords)
		$index:=Find in array:C230($aryKeywords; $tbl_name)
		If ($index#-1)
			$found_reserved:=True:C214
			//一つでも予約語が使われていたらループを抜ける
			$i:=$files.length
			
		End if 
	End for 
	
	return $found_reserved
	
	