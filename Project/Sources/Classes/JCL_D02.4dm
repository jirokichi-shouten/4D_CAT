//JCL_D02
//20240316 yabe wat
//fieldsを読み込んでテーブルを追加するフォームに関連するメソッドをクラス化

Class constructor
	//JCL_D02_fields
	//20240116 wat
	//fieldsを表示
	
	//C_LONGINT($0; $dlgOk)
	
	////画面表示
	//$dlgOk:=JCL_D02_Display
	//If ($dlgOk=1)
	
	//End if 
	
	//$0:=$dlgOk
	
	
Function frm()
	//JCL_D02_frm
	//20240116 wat
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Load:K2:1)
			This:C1470.frmOnLoad()
			
	End case 
	
	
Function frmOnLoad()
	//オンロード
	
	This:C1470.frmDefInit()
	This:C1470.lstTB_removeAll()
	
Function lstTB_removeAll()
	
	//テーブルリストボックスの配列を初期化
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_status; 1; Size of array:C274(vJCL_D02_lstTB_status))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_error; 1; Size of array:C274(vJCL_D02_lstTB_error))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_LABEL; 1; Size of array:C274(vJCL_D02_lstTB_LABEL))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NAME; 1; Size of array:C274(vJCL_D02_lstTB_NAME))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_PREFIX; 1; Size of array:C274(vJCL_D02_lstTB_PREFIX))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NO_FORM; 1; Size of array:C274(vJCL_D02_lstTB_NO_FORM))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_DESCRIPTION; 1; Size of array:C274(vJCL_D02_lstTB_DESCRIPTION))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_REMARK; 1; Size of array:C274(vJCL_D02_lstTB_REMARK))
	DELETE FROM ARRAY:C228(vJCL_D02_lstTB_Block; 1; Size of array:C274(vJCL_D02_lstTB_Block))
	
	DELETE FROM ARRAY:C228(vJCL_D20_lstTB_BakColor; 1; Size of array:C274(vJCL_D20_lstTB_BakColor))
	DELETE FROM ARRAY:C228(vJCL_D20_lstTB_FontColor; 1; Size of array:C274(vJCL_D20_lstTB_FontColor))
	
	
Function frmDefInit()
	//frmDefInit
	C_TEXT:C284(vJCL_D02_txtTitle)
	//OBJECT SET TITLE(*; "vJCL_D02_txtTitle"; "fields.txt")
	
	C_TEXT:C284(vJCL_D02_varTableName)
	vJCL_D02_varTableName:=""
	C_TEXT:C284(vJCL_D02_varNumOfTables)
	C_TEXT:C284(vJCL_D02_varNumOfFields)
	
	// リストボックス用配列
	ARRAY BOOLEAN:C223(vJCL_D02_lstFL; 0)  //リストボックス自身
	ARRAY TEXT:C222(vJCL_D02_lstFL_NAME; 0)
	ARRAY TEXT:C222(vJCL_D02_lstFL_LABEL; 0)
	ARRAY TEXT:C222(vJCL_D02_lstFL_DATA_TYPE; 0)
	
	ARRAY LONGINT:C221(vJCL_D02_lstFL_LENGTH; 0)
	ARRAY LONGINT:C221(vJCL_D02_lstFL_INDEX; 0)
	ARRAY LONGINT:C221(vJCL_D02_lstFL_UNIQUE; 0)
	ARRAY TEXT:C222(vJCL_D02_lstFL_COMMENT; 0)
	ARRAY TEXT:C222(vJCL_D02_lstFL_REMARK; 0)
	
	//テーブル　リストボックス用配列
	ARRAY BOOLEAN:C223(vJCL_D02_lstTB; 0)  //リストボックス自身
	ARRAY TEXT:C222(vJCL_D02_lstTB_status; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_error; 0)  //エラー表示用
	ARRAY TEXT:C222(vJCL_D02_lstTB_NAME; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_PREFIX; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_NO_FORM; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_LABEL; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_DESCRIPTION; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_REMARK; 0)
	ARRAY TEXT:C222(vJCL_D02_lstTB_Block; 0)
	ARRAY LONGINT:C221(vJCL_D20_lstTB_BakColor; 0)
	ARRAY LONGINT:C221(vJCL_D20_lstTB_FontColor; 0)
	
	
Function display()
	//JCL_D02_Display
	//20240116 wat
	//ログインダイアログを表示
	
	C_LONGINT:C283($winRef)
	C_LONGINT:C283($0)
	C_TEXT:C284($frmName)
	$frmName:="JCL_D02_Fields"
	C_TEXT:C284($title)
	$title:=$frmName
	
	$winRef:=Open form window:C675($frmName; Movable form dialog box:K39:8; \
		Horizontally centered:K39:1; Vertically centered:K39:4; *)
	SET WINDOW TITLE:C213("ログインダイアログ")
	
	SET WINDOW TITLE:C213($title)
	DIALOG:C40($frmName)  //ウィンドウにフォームを表示する
	
	CLOSE WINDOW:C154  //ウィンドウを閉じる
	
	$0:=OK
	
Function lstTB_make($block : Text)
	//JCL_D02_lstTB_make
	//20240116 wat
	//テーブル情報のブロックから、テーブル情報を取り出して配列要素に追加
	
	C_LONGINT:C283($i; $numOfLines)
	C_LONGINT:C283($numOfLines; $numOfItems)
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryItems; 0)
	C_TEXT:C284($tbl_name)
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($status)
	$status:="temporary"
	$error:="なし"
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	
	If ($block#"")
		$block:=JCL_str_ReplaceReturn($block)  //改行コードをLFに統一
		$numOfLines:=JCL_str_Extract_byReturn($block; ->$aryLines)  //改行で切り分ける
		
		//最初の要素はテーブル情報
		$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryItems)
		If ($numOfItems>5)
			$tbl_name:=$aryItems{1}
			If ($tbl_name#"")
				//テーブルが作成されているか？
				$tblNr:=JCL_tbl_GetNumber($tbl_name)
				If ($tblNr#0)
					$status:=String:C10($tblNr)
					APPEND TO ARRAY:C911(vJCL_D02_lstTB_error; "作成済み")  //エラー文字
					
				Else 
					If ($jcl_fields.check_sql_reserved($tbl_name)=True:C214)
						APPEND TO ARRAY:C911(vJCL_D02_lstTB_error; "SQL予約語")  //エラー文字
						
					Else 
						APPEND TO ARRAY:C911(vJCL_D02_lstTB_error; $error)  //エラー文字
						
					End if 
				End if 
			End if 
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_status; $status)  //fields情報ステータス：Nr, NA, temporary
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_NAME; $aryItems{1})  // テーブル名
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_PREFIX; $aryItems{2})  // プリフィックス
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_NO_FORM; $aryItems{3})  // NoFormでなければフォームを作る
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_LABEL; $aryItems{6})  // テーブルラベル（論理名）
			If ($numOfItems>6)
				APPEND TO ARRAY:C911(vJCL_D02_lstTB_DESCRIPTION; $aryItems{7})  // 説明
			Else 
				APPEND TO ARRAY:C911(vJCL_D02_lstTB_DESCRIPTION; "")  // 説明
			End if 
			If ($numOfItems>7)
				APPEND TO ARRAY:C911(vJCL_D02_lstTB_REMARK; $aryItems{8})  // サンプルデータ等
			Else 
				APPEND TO ARRAY:C911(vJCL_D02_lstTB_REMARK; "")  // 説明
			End if 
		End if 
		
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_Block; $block)  // フィールド情報
		
		If ($status#"temporary")
			APPEND TO ARRAY:C911(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
			APPEND TO ARRAY:C911(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(255; 0; 0))  // フォントカラー
		Else 
			APPEND TO ARRAY:C911(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
			APPEND TO ARRAY:C911(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(0; 0; 0))  // フォントカラー
		End if 
		
	End if 
	
	return 
	
Function btnTable()
	//JCL_D02_btnTable
	//20240206 wat
	//テーブル作成　ボタン　未作成のテーブルを作成
	
	C_LONGINT:C283($i; $sizeOfAry)
	C_TEXT:C284($fields_error_text)
	C_TEXT:C284($block)
	C_LONGINT:C283($error)
	C_LONGINT:C283($cnt)
	$cnt:=0
	C_TEXT:C284($msg)
	C_OBJECT:C1216($jcl_tg)
	$jcl_tg:=cs:C1710.JCL_tg.new()
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	
	//テーブルリストをループして
	$sizeOfAry:=Size of array:C274(vJCL_D02_lstTB_error)
	For ($i; 1; $sizeOfAry)
		//ステータスで未作成を判断
		$fields_error_text:=vJCL_D02_lstTB_error{$i}
		If ($fields_error_text="なし")
			//テーブル作成
			$block:=vJCL_D02_lstTB_Block{$i}
			
			//テーブルを作成
			$error:=$jcl_tg.createTable($block)
			If ($error=0)
				//インデックスを作成
				$jcl_tg.createIndex($block)
				
				//モデルメソッド群をテンプレートから作成
				$jcl_tg.createMethod($block)
				
				//ラベルファイルを作成
				$jcl_fields.createLabelFile($block)
				
				$cnt:=$cnt+1
				
			End if 
		End if 
	End for 
	
	If ($cnt>0)
		$msg:="完了"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+String:C10($cnt)+"個のテーブルを作成しました。"
		ALERT:C41($msg)
		
	End if 
	
	This:C1470.setControlsValues()
	
	return 
	
	
Function lstFL()
	//JCL_D02_lstFL
	//20240116 wat
	return 
	
	
Function lstFL_make($fieldBlock : Text)
	//JCL_D02_lstFL_make
	//20240116 wat
	//テーブル情報のブロックから、フィールド情報を取り出して配列要素に追加
	
	C_LONGINT:C283($i; $numOfLines)
	C_TEXT:C284($fldName; $label; $prefix)
	C_LONGINT:C283($numOfItems)
	ARRAY TEXT:C222($aryLines; 0)
	ARRAY TEXT:C222($aryItems; 0)
	
	If ($fieldBlock#"")
		//配列初期化
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_NAME; 1; Size of array:C274(vJCL_D02_lstFL_NAME))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_LABEL; 1; Size of array:C274(vJCL_D02_lstFL_LABEL))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_DATA_TYPE; 1; Size of array:C274(vJCL_D02_lstFL_DATA_TYPE))
		
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_LENGTH; 1; Size of array:C274(vJCL_D02_lstFL_LENGTH))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_INDEX; 1; Size of array:C274(vJCL_D02_lstFL_INDEX))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_UNIQUE; 1; Size of array:C274(vJCL_D02_lstFL_UNIQUE))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_COMMENT; 1; Size of array:C274(vJCL_D02_lstFL_COMMENT))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_REMARK; 1; Size of array:C274(vJCL_D02_lstFL_REMARK))
		
		//フィールド一覧作成
		$fieldBlock:=JCL_str_ReplaceReturn($fieldBlock)  //改行コードをLFに統一
		$numOfLines:=JCL_str_Extract_byReturn($fieldBlock; ->$aryLines)  //改行で切り分ける
		
		//１行目はテーブル情報
		For ($i; 2; $numOfLines)
			//フィールド情報を取得
			DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
			$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
			If ($numOfItems>5)
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_NAME; $aryItems{1})  // フィールド名
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_DATA_TYPE; $aryItems{2})  // データ型
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_LENGTH; Num:C11($aryItems{3}))  // 文字長さ
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_INDEX; Num:C11($aryItems{4}))  // インデックス対象かどうか
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_UNIQUE; Num:C11($aryItems{5}))  // ユニークフィールド
				APPEND TO ARRAY:C911(vJCL_D02_lstFL_LABEL; $aryItems{6})  // フィールドラベル（論理名）
				If ($numOfItems>6)
					APPEND TO ARRAY:C911(vJCL_D02_lstFL_COMMENT; $aryItems{7})  // 説明
				Else 
					APPEND TO ARRAY:C911(vJCL_D02_lstFL_COMMENT; "")  // 説明
				End if 
				If ($numOfItems>7)
					APPEND TO ARRAY:C911(vJCL_D02_lstFL_REMARK; $aryItems{8})  // サンプルデータ等
				Else 
					APPEND TO ARRAY:C911(vJCL_D02_lstFL_REMARK; "")  // 説明
				End if 
				
			End if 
		End for 
	End if 
	
	return 
	
Function lstTB()
	//JCL_D02_lstTB
	//20240116 wat
	//テーブル　リストボックス
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Selection Change:K2:29)
			//テーブル名
			vJCL_D02_varTableName:=JCL_lst_Selected_Str(->vJCL_D02_lstTB; ->vJCL_D02_lstTB_NAME)
			
			//エラー情報表示
			
			//フィールド情報ブロックを取得、リストボックスに保持させてある
			$fieldBlock:=JCL_lst_Selected_Str(->vJCL_D02_lstTB; ->vJCL_D02_lstTB_Block)
			
			//フィールド配列作成
			This:C1470.lstFL_make($fieldBlock)
			
	End case 
	
	return 
	
Function btnImport()
	//JCL_D02_btnImport
	//20240116 wat
	//ファイル選択ダイアログ、fields読み込み
	
	ARRAY TEXT:C222($aryBlock; 0)  //20240114
	C_LONGINT:C283($dlg_ok)
	C_TEXT:C284($fileText)
	C_LONGINT:C283($errFlag)
	C_LONGINT:C283($i; $numOfTables)
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	
	//定義ファイル（fieldsフォーマット）を選択
	$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)
	If ($dlg_ok=1)
		//読み込んだファイルの内容を4Dの文字セットにエンコード
		$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
		$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227
		$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
		$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える
		
		$errFlag:=$jcl_fields.check_format($fileText)
		If ($errFlag=0)
			//配列を削除
			This:C1470.lstTB_removeAll()
			
			$numOfTables:=$jcl_fields.blocks_extract($fileText; ->$aryBlock)
			For ($i; 1; $numOfTables)
				//テーブルリストボックス用配列を作成
				This:C1470.lstTB_make($aryBlock{$i})
				//JCL_D02_lstTB_make($aryBlock{$i})
				
				//テーブル情報チェック
				This:C1470.lstTB_check()
				
			End for 
			
			This:C1470.setControlsValues()
			
		End if 
	End if 
	
	return 
	
Function lstTB_check()
	//JCL_D02_lstTB_check
	//20240121 wat
	//テーブル情報チェック、既存テーブルは重複していない
	
	C_LONGINT:C283($i; $sizeOfAry)
	C_TEXT:C284($tbl_name)
	ARRAY TEXT:C222($aryTemporary; 0)
	ARRAY TEXT:C222($aryExist; 0)
	
	$sizeOfAry:=Size of array:C274(vJCL_D02_lstTB_NAME)
	For ($i; 1; $sizeOfAry)
		$tbl_name:=vJCL_D02_lstTB_NAME{$i}
		$cnt:=Count in array:C907(vJCL_D02_lstTB_NAME; $tbl_name)
		If ($cnt>1)
			//重複エラー
			vJCL_D02_lstTB_error{$i}:="テーブル名重複"
			
		End if 
	End for 
	
	return 
	
Function setControlsValues()
	//JCL_D02_SetControlsValues
	//20240121 yabe wat
	
	//テーブル　リストボックスに色付
	C_LONGINT:C283($i; $sizeOfAry)
	C_LONGINT:C283($red)
	$red:=JCL_num_GetRGB(255; 0; 0)
	
	//$sizeOfAry:=Size ?OfAry)
	//ステータスで未作成を判断
	//$status:=vJCL_D02_lstTB_status{$i}
	//If ($status="temporary")
	//APPEND TO ARRAY(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
	//APPEND TO ARRAY(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(255; 0; 0))  // フォントカラー
	//Else 
	//APPEND TO ARRAY(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
	//APPEND TO ARRAY(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(0; 0; 0))  // フォントカラー
	//End if 
	
	//End for 
	