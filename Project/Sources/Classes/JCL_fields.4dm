//JCL_fields
//JCL Table Generator and related functions
//20240316 yabe wat
//JCLのうちテーブル関連のメソッド群

Class constructor
	
	
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
	
	$0:=$error
	
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
	
	$0:=$error
	
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
		//タブで切り分ける
		DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
		If ($numOfItems<8)  //20240503
			//列数不足
			$i:=$numOfLines
			//break 
			
		Else 
			//テーブル情報を取得
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
		End if 
	End for 
	
	$0:=$cnt
	
Function check_format($block : Text) : Integer
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
	
	//テーブル名の配列を得る
	//$numOfTables:=JCL_tbl_Blocks_fromFile($inFileText; ->$aryBlock)
	$numOfTables:=This:C1470.blocks_extract($inFileText; ->$aryBlock)
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
					$found_reserved:=This:C1470.check_sql_reserved($aryTableItems{1})
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
	
	$0:=$errFlag
	
Function check_sql_reserved($tbl_name : Text) : Boolean
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
	
	$0:=$found_reserved
	
Function cache_make
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
	ARRAY TEXT:C222(vJCL_fields_comment; 0)
	ARRAY TEXT:C222(vJCL_fields_remark; 0)
	C_LONGINT:C283($numOfItems)
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryTblItems; 0)
	ARRAY TEXT:C222($aryFldItems; 0)
	
	//リソースフォルダからfields_labelsファイル群を読み込む
	C_COLLECTION:C1488($files)
	$files:=New collection:C1472
	$files:=Folder:C1567("/RESOURCES/JCL4D_Resources/fields_labels/").files(fk ignore invisible:K87:22)
	For ($i; 1; $files.length)
		// ファイルの中身を取得
		$fileText:=$files[$i-1].getText("UTF-8"; Document with LF:K24:22)
		
		//改行コードをLFに統一
		$fileText:=JCL_str_ReplaceReturn($fileText)
		
		//改行で切り分ける
		DELETE FROM ARRAY:C228($aryLines; 1; Size of array:C274($aryLines))
		$numOfLines:=JCL_str_Extract_byReturn($fileText; ->$aryLines)
		
		//１行目からテーブルラベルを取得
		DELETE FROM ARRAY:C228($aryTblItems; 1; Size of array:C274($aryTblItems))
		$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTblItems)
		APPEND TO ARRAY:C911(vJCL_fields_tblName; $aryTblItems{1})  // テーブル名
		$prefix:=$aryTblItems{2}
		APPEND TO ARRAY:C911(vJCL_fields_tblLabel; $aryTblItems{6})  // テーブルラベル
		
		//ヘッダなし、２行目以降からフィールドラベルを取得
		For ($k; 2; $numOfLines)
			//フィールド名切り出し
			DELETE FROM ARRAY:C228($aryFldItems; 1; Size of array:C274($aryFldItems))
			$numOfItems:=JCL_str_Extract($aryLines{$k}; Char:C90(Tab:K15:37); ->$aryFldItems)
			If ($aryFldItems{1}="-")
				//-（ハイフン）だったらフィールド一覧の終わり
			Else 
				//ハイフンじゃなかったらフィールド名の配列に追加（連結文字はアンダーバー）
				$fldName:=$prefix+"_"+$aryFldItems{1}
				$label:=$aryFldItems{6}
				
				APPEND TO ARRAY:C911(vJCL_fields_name; $fldName)  //フィールド名
				APPEND TO ARRAY:C911(vJCL_fields_label; $label)  //フィールドラベル
				APPEND TO ARRAY:C911(vJCL_fields_comment; $aryFldItems{7})  //説明
				APPEND TO ARRAY:C911(vJCL_fields_remark; $aryFldItems{8})  //備考
				
			End if 
		End for 
	End for 
	
	
Function cache_TableLabel_get($inputTblName : Text) : Text
	//JCL_fields_cache_TableLabel
	//2024319 wat
	//キャッシュからテーブルラベルを取得
	
	C_LONGINT:C283($index)
	$label:=""
	
	$index:=Find in array:C230(vJCL_fields_tblName; $inputTblName)
	If ($index#-1)
		$label:=vJCL_fields_tblLabel{$index}
		
	Else 
		$label:="ClassUnknown"
		
	End if 
	
	$0:=$label
	
Function cache_FieldLabel_get($fldName : Text) : Text
	//JCL_fields_Label
	//2024319 wat
	//キャッシュからフィールドラベルを取得
	
	C_LONGINT:C283($index)
	$label:=""
	
	$index:=Find in array:C230(vJCL_fields_name; $fldName)
	If ($index#-1)
		$label:=vJCL_fields_label{$index}
		
	End if 
	
	$0:=$label
	
Function cache_FieldComment_get($fldName : Text) : Text
	//JCL_fields_Label
	//2024319 wat
	//キャッシュからフィールドラベルを取得
	
	C_LONGINT:C283($index)
	$label:=""
	
	$index:=Find in array:C230(vJCL_fields_name; $fldName)
	If ($index#-1)
		$label:=vJCL_fields_comment{$index}
		
	End if 
	
	$0:=$label
	
Function cache_FieldRemark_get($fldName : Text) : Text
	//JCL_fields_Label
	//2024319 wat
	//キャッシュからフィールドラベルを取得
	
	C_LONGINT:C283($index)
	$label:=""
	
	$index:=Find in array:C230(vJCL_fields_name; $fldName)
	If ($index#-1)
		$label:=vJCL_fields_remark{$index}
		
	End if 
	
	$0:=$label
	