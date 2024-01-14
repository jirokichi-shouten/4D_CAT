//%attributes = {"shared":true}
//JCL_table_Generate
//20111005 wat
//20121001 wat rename, 20130429 wat mod
//外部テキストファイルのフィールド定義を読み込んでテーブル作成
//20150826 yabe フォーム作成フラグ追加
//20210811 ike wat 改行コードをCRに統一する、全角文字を置き換える
//20221227 ike wat 改行コード統一をLFに変更、GitでテンプレートがLFにされてしまったため
//20240114 yabe wat refactor エラーチェエック導入、エラーメッセージ表示

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
ARRAY TEXT:C222($aryBlock; 0)  //フィールド名のプリフィックスの配列
C_LONGINT:C283($i; $numOfTables)
C_LONGINT:C283($errFlag)
C_TEXT:C284($msg)

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
			//テーブルを作成 //インデックスを作成
			JCL_tbl_CreateTable($aryBlock{$i})
			
			//モデルメソッド群をテンプレートから作成
			JCL_tbl_Create_method($aryBlock{$i})
			
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
