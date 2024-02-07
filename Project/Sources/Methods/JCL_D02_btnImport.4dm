//%attributes = {}
//JCL_D02_btnImport
//20240116 wat
//ファイル選択ダイアログ、fields読み込み

ARRAY TEXT:C222($aryBlock; 0)  //20240114
C_LONGINT:C283($dlg_ok)
C_TEXT:C284($fileText)
C_LONGINT:C283($errFlag)
C_LONGINT:C283($i; $numOfTables)

//定義ファイル（fieldsフォーマット）を選択
$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)
If ($dlg_ok=1)
	//読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227
	$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
	$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える
	
	$errFlag:=JCL_tbl_Check_fieldsFile($fileText)
	If ($errFlag=0)
		//一時テーブルを削除
		JCL_D02_lstTB_remove_all
		
		$numOfTables:=JCL_tbl_Blocks_fromFile($fileText; ->$aryBlock)
		For ($i; 1; $numOfTables)
			//テーブルリストボックス用配列を作成
			JCL_D02_lstTB_make($aryBlock{$i}; "temporary")
			
			//テーブル情報チェック
			JCL_D02_lstTB_check
			
			//フィールドリストボックス用配列作成
			//JCL_D02_lstFL_make($aryBlock{$i})
			
			//fields内容チェック
			JCL_tbl_Check_fields
			
			JCL_D02_SetControlsValues
			
		End for 
		
		JCL_D02_SetControlsValues
		
		//$msg:="完了"+Char(Carriage return)
		//$msg:=$msg+String($numOfTables)+"個のテーブルを作成しました。"
		//ALERT($msg)
	End if 
Else 
	//$msg:="エラー"+Char(Carriage return)
	//$msg:=$msg+"テーブルは作成されていません。"
	//ALERT($msg)
	
End if 
