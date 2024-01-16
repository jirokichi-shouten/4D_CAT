//%attributes = {}
//JCL_D02_btnImport
//20240116 wat
//ファイル選択ダイアログ、fields読み込み

//定義ファイルを選択
$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)
If ($dlg_ok=1)
	//読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227
	$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
	$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える
	
	$errFlag:=JCL_tbl_Check_fieldsFile($fileText)
	If ($errFlag=0)
		$numOfTables:=JCL_tbl_Blocks_fromFile($fileText; ->$aryBlock)
		For ($i; 1; $numOfTables)
			//テーブルリストボックス用配列を作成
			JCL_D02_lstTB_make(->$aryBlock{$i})
			
			//フィールドリストボックス用配列作成
			JCL_D02_lstFL_make(->$aryBlock{$i})
			
			
			//モデルメソッド群をテンプレートから作成
			//JCL_tbl_Create_method($aryBlock{$i})
			
		End for 
		
		$msg:="完了"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+String:C10($numOfTables)+"個のテーブルを作成しました。"
		ALERT:C41($msg)
	End if 
	
Else 
	$msg:="エラー"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+"テーブルは作成されていません。"
	ALERT:C41($msg)
	
End if 
