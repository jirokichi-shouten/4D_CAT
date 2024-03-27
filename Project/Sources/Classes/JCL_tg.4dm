//JCL_tg
//JCL Table Generator and related functions
//20240316 yabe wat
//JCLのうちテーブル生成関連のメソッド群をクラス化

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
	
	$0:=$error
	
	
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
	
	