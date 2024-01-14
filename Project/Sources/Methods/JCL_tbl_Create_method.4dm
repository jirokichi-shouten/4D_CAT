//%attributes = {}
//JCL_tbl_Create_method
//20211228 jiro
//モデルメソッド群をテンプレートから作成

C_TEXT:C284($1; $inBlockText)
$inBlockText:=$1  //ブロックの中身
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
