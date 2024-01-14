//%attributes = {"shared":true}
//JCL_method_Generate
//20130318 yabe
//外部テキストファイルのフィールド定義を読み込んでメソッド作成
//メソッドが既にある場合削除しない。
//20150826 yabe フォーム作成フラグ追加
//20240114 yabe wat refactor

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
ARRAY TEXT:C222($aryBlock; 0)  //fieldsのブロック
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryTableItems; 0)
C_LONGINT:C283($numOfLines; $numOfItems)


ARRAY TEXT:C222($aryFormsFlag; 0)  //20150826 フォームを作るかどうかのフラグの配列「フォーム作る」なら作成
C_LONGINT:C283($i; $numOfTables)
C_TEXT:C284($dir)
ARRAY TEXT:C222($aryFileName; 0)  //の配列
ARRAY TEXT:C222($aryFileContents; 0)  //の配列
C_TEXT:C284($buf)
C_BLOB:C604($blob)
C_LONGINT:C283($tableCount)
$tableCount:=0
C_LONGINT:C283($errFlag)
C_TEXT:C284($msg)

//定義ファイル「fields」を選択 //ファイルオープンダイアログ
$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)
If ($dlg_ok=1)
	//読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227//LFに統一するようにした
	$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
	$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える
	
	//テンプレートファイルフォルダを選択
	$dir:=Select folder:C670("")
	DOCUMENT LIST:C474($dir; $aryFileName)
	For ($i; 1; Size of array:C274($aryFileName))
		
		//v14
		DOCUMENT TO BLOB:C525($dir+$aryFileName{$i}; $blob)
		$buf:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
		
		APPEND TO ARRAY:C911($aryFileContents; $buf)
		
	End for 
	
	$errFlag:=JCL_tbl_Check_fieldsFile($fileText)
	If ($errFlag=0)
		//テーブル名の配列を得る
		$numOfTables:=JCL_tbl_Blocks_fromFile($inFileText; ->$aryBlock)
		For ($i; 1; $numOfTables)
			//改行で切り分ける
			$numOfLines:=JCL_str_Extract_byReturn($aryBlock{$i}; ->$aryLines)
			
			//テーブル情報取得
			$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
			If ($aryTableItems{3}#"NoForm")  // フォーム作らない, NoForm
				//メソッドを作成
				JCL_method_GenerateOne($aryBlock{$i}; $aryTableItems{1}; $aryTableItems{2}; ->$aryFileName; ->$aryFileContents)
				
			End if 
		End for 
		
		//２回メソッドを作成することで、4Dの自動認識機能をオンにする。
		//For ($i; 1; $numOfTables)
		//If ($aryFormsFlag{$i}#"NoForm")
		////If ($aryFormsFlag{$i}="フォーム作る")
		//$tableCount:=$tableCount+1
		////メソッドを作成
		//JCL_method_GenerateOne($fileText; $aryTableName{$i}; $aryStartLineNr{$i}; $aryPrefix{$i}; ->$aryFileName; ->$aryFileContents)
		//End if 
		//End for 
		
		$msg:="完了"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+String:C10($tableCount)+"/"+String:C10($numOfTables)+"個のテーブル分のメソッドを作成しました。"
		ALERT:C41($msg)
		
	End if 
Else 
	//fieldsファイルにエラー
	$msg:="エラー"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+"メソッドとフォームは作成されていません。"
	ALERT:C41($msg)
	
End if 
