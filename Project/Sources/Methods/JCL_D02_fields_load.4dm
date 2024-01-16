//%attributes = {}
//JCL_D02_fields_load
//20240116 wat
//fieldsからテーブル情報とフィールド情報のブロックを取得


C_POINTER:C301($1; $aryBlockPtr)
$aryBlockPtr:=$1
C_LONGINT:C283($0; $numOfTables)
$numOfTables:=0
C_TEXT:C284($folderPath; $filePath)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
C_LONGINT:C283($errFlag)
C_TEXT:C284($msg)

//リソースフォルダからフィールズを読み込む
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "JCL4D_Resources")
$filePath:=JCL_file_MakeFilePath($folderPath; "fields.txt")

$fileText:=Document to text:C1236($filePath; UTF8 text without length:K22:17)


//読み込んだファイルの内容を4Dの文字セットにエンコード
$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227
$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える

$errFlag:=JCL_tbl_Check_fieldsFile($fileText)
If ($errFlag=0)
	$numOfTables:=JCL_tbl_Blocks_fromFile($fileText; $aryBlockPtr)
	
Else 
	$msg:="エラー"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+"firlds情報を取得できませんでした。"
	ALERT:C41($msg)
	
End if 
