//JCL_D00_Generatorダイアログ
//20240329 Jirokichi
//fieldsを読み込んでテーブルを追加するフォームに関連するメソッドをクラス化

Class extends JCL_formGenerator

Class constructor
	//JCL_D00_Generatorダイアログ
	//現在DBに登録されているテーブルとフィールドをラベル付きで表示
	//JCL_D02_fieldsを呼び出して、fieldsを読み込んでテーブル生成、それらにフォームを生成できる
	
	//usage:
	//$d00:=cs.JCL_D00.new()
	
	Super:C1705()
	
	C_OBJECT:C1216(cD00)
	cD00:=This:C1470  // 20240503 クラス用プロセス変数定義
	
	This:C1470.display()
	
Function display()
	//D00_Display
	//20240328 wat
	// メイン画面をウインドウに表示
	
	C_LONGINT:C283($winRef)
	C_TEXT:C284($frmName; $title)
	$frmName:="JCL_D00_Generator"
	$title:="ジェネレータ("+$frmName+")"
	
	// クローズボックスなし、タイトルバー付のウインドウを作成する
	$winRef:=Open form window:C675($frmName; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	
	SET WINDOW TITLE:C213($title)
	
	DIALOG:C40($frmName)  //ウインドウにフォームを表示する
	
	CLOSE WINDOW:C154  // ウインドウを閉じる
	
Function frm()
	//D00_frm
	//20240204 wat
	//フォームメソッド
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Load:K2:1)
			This:C1470.frmOnLoad()
			
	End case 
	
Function frmOnLoad()
	//D00_frmOnLoad
	//20240204 wat
	//オンロード
	
	This:C1470.frmDefInit()
	
	//テーブル一覧を作成
	This:C1470.lstT_make()
	
	This:C1470.setControlsValues()
	
Function frmDefInit()
	//D00_frmDefInit
	//20240204 wat
	//フォームオブジェクトを宣言、初期化
	
	C_OBJECT:C1216($fullpath)
	$fullpath:=Path to object:C1547(Structure file:C489)
	
	C_TEXT:C284(vD00_varProductName; vD00_varVersion)
	vD00_varProductName:=$fullpath.name
	vD00_varVersion:="0.9(1) 20240204"
	vD00_varVersion:="0.9(2) 20240211"
	vD00_varVersion:="1.0(3) 20240304"
	vD00_varVersion:="1.0(4) 20240503"
	
	C_TEXT:C284(vD00_var4D_DataFile)
	vD00_var4D_DataFile:="データファイル："+Data file:C490
	
	//テーブルリストボックス
	ARRAY BOOLEAN:C223(vD00_lstT; 0)  //リストボックス自身
	ARRAY LONGINT:C221(vD00_lstT_nr; 0)
	ARRAY TEXT:C222(vD00_lstT_name; 0)
	ARRAY TEXT:C222(vD00_lstT_label; 0)
	ARRAY TEXT:C222(vD00_lstT_prefix; 0)
	ARRAY LONGINT:C221(vD00_lstT_numOfRecs; 0)
	ARRAY LONGINT:C221(vD00_lstT_Color; 0)
	
	C_TEXT:C284(vD00_txtNumOfTables)
	
	C_TEXT:C284(vD00_varTableName)
	
	//フィールドリストボックス
	ARRAY BOOLEAN:C223(vD00_lstFL; 0)  //リストボックス自身
	ARRAY LONGINT:C221(vD00_lstFL_Nr; 0)
	ARRAY TEXT:C222(vD00_lstFL_NAME; 0)
	ARRAY TEXT:C222(vD00_lstFL_LABEL; 0)
	ARRAY TEXT:C222(vD00_lstFL_DATA_TYPE; 0)
	
	ARRAY LONGINT:C221(vD00_lstFL_LENGTH; 0)
	ARRAY BOOLEAN:C223(vD00_lstFL_INDEX; 0)
	ARRAY BOOLEAN:C223(vD00_lstFL_UNIQUE; 0)
	ARRAY BOOLEAN:C223(vD00_lstFL_INVISIBLE; 0)
	ARRAY TEXT:C222(vD00_lstFL_COMMENT; 0)
	ARRAY TEXT:C222(vD00_lstFL_REMARK; 0)
	
	C_TEXT:C284(vD00_varNumOfFields)
	
Function lstT_make()
	//D00_lstT_make
	//20240204 wat
	//テーブル一覧　リストボックス
	
	C_POINTER:C301($tblPtr)
	C_TEXT:C284($table_name; $label; $tbl_prefix)
	C_LONGINT:C283($numOfRecs)
	C_LONGINT:C283($numOfTables; $i; $sizeOfAry)
	C_LONGINT:C283($color)
	
	//ラベルキャッシュ作成
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	$jcl_fields.cache_make()
	
	//配列初期化
	DELETE FROM ARRAY:C228(vD00_lstT; 1; Size of array:C274(vD00_lstT))
	DELETE FROM ARRAY:C228(vD00_lstT_nr; 1; Size of array:C274(vD00_lstT_nr))
	DELETE FROM ARRAY:C228(vD00_lstT_name; 1; Size of array:C274(vD00_lstT_name))
	DELETE FROM ARRAY:C228(vD00_lstT_label; 1; Size of array:C274(vD00_lstT_label))
	DELETE FROM ARRAY:C228(vD00_lstT_prefix; 1; Size of array:C274(vD00_lstT_prefix))
	DELETE FROM ARRAY:C228(vD00_lstT_numOfRecs; 1; Size of array:C274(vD00_lstT_numOfRecs))
	DELETE FROM ARRAY:C228(vD00_lstT_Color; 1; Size of array:C274(vD00_lstT_Color))
	
	$numOfTables:=Get last table number:C254
	For ($i; 1; $numOfTables)
		If (Is table number valid:C999($i)=True:C214)
			APPEND TO ARRAY:C911(vD00_lstT_nr; $i)  //番号
			
			$table_name:=Table name:C256($i)
			APPEND TO ARRAY:C911(vD00_lstT_name; $table_name)  //テーブル名
			
			$label:=$jcl_fields.cache_TableLabel_get($table_name)
			APPEND TO ARRAY:C911(vD00_lstT_label; $label)  //テーブルラベル
			
			$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)
			APPEND TO ARRAY:C911(vD00_lstT_prefix; $tbl_prefix)  //プレフィックス
			
			$tblPtr:=Table:C252($i)
			ALL RECORDS:C47($tblPtr->)
			$numOfRecs:=Records in selection:C76($tblPtr->)
			APPEND TO ARRAY:C911(vD00_lstT_numOfRecs; $numOfRecs)  //レコード数
			
			$color:=JCL_tbl_GetFormColor($table_name)
			If ($color=0)
				$color:=0x00FFFFFF  //白
			End if 
			APPEND TO ARRAY:C911(vD00_lstT_Color; $color)  //色
			$sizeOfAry:=Size of array:C274(vD00_lstT_Color)
			LISTBOX SET ROW COLOR:C1270(*; "vD00_lstT_Color"; $sizeOfAry; $color; lk background color:K53:25)
			
		End if 
	End for 
	
Function setControlsValues()
	//A01_SetControlsValues
	//20240204 wat
	//フォームオブジェクトを制御
	
	//件数表示
	C_LONGINT:C283($sizeOfAry)
	$sizeOfAry:=Size of array:C274(vD00_lstT_nr)
	vD00_txtNumOfTables:="作成済みテーブル数："+String:C10($sizeOfAry; "#,###,##0")
	
	//選択されたテーブル名表示
	C_TEXT:C284($tblName)
	$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
	$sizeOfAry:=Size of array:C274(vD00_lstFL_Nr)
	If ($sizeOfAry>0)
		vD00_varTableName:=$tblName+"(フィールド数："+String:C10($sizeOfAry; "#,###,##0")+")"
		
	Else 
		vD00_varTableName:=""
		
	End if 
	
	//ボタン制御
	JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnList)
	JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnFom)
	JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnDelete)
	JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnFormColor)
	
Function btnDelAllTables()
	//D00_btnAllDel
	//20240223 yabe wat
	//すべてのテーブルと関連メソッドを削除
	
	C_LONGINT:C283($k; $sizeOfAry)
	C_TEXT:C284($tblName)
	C_POINTER:C301($tblPtr)
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($sql)
	C_OBJECT:C1216($folder)
	C_COLLECTION:C1488($files)
	C_LONGINT:C283($i)
	
	//テーブルポインタの配列
	$sizeOfAry:=Size of array:C274(vD00_lstT_name)
	If ($sizeOfAry>0)
		//確認メッセージ
		$msg:=String:C10($sizeOfAry)+"個のテーブルを削除します。よろしいですか。"
		$dlgOk:=JCL_dlg_YesNo("テーブル削除"; $msg; "削除"; "キャンセル")
		If ($dlgOk=1)
			//テーブル削除
			For ($k; 1; $sizeOfAry)
				$tblName:=vD00_lstT_name{$k}
				$prefix:=vD00_lstT_prefix{$k}
				$tblNr:=vD00_lstT_nr{$k}
				$tblPtr:=Table:C252($tblNr)
				
				//レコード全件削除
				JCL_tbl_DelAll($tblPtr)
				
				//テーブル削除
				$sql:="drop table "+$tblName+";"
				SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
				SQL EXECUTE:C820($sql)
				SQL LOGOUT:C872
				
				//関連メソッドを削除：オブジェクトメソッドはフォルダごと消す
				$folder:=New object:C1471
				$folder:=Folder:C1567("/SOURCES/TableForms/"+String:C10($tblNr))
				$folder.delete(Delete with contents:K24:24)
				
				//関連メソッドを削除：フォームメソッド
				$files:=New collection:C1472
				//$folder:=Folder("/SOURCES/Methods/")
				$files:=Folder:C1567("/SOURCES/Methods/").files(fk ignore invisible:K87:22)
				For ($i; 1; $files.length)
					C_TEXT:C284($currentFileName)
					$currentFileName:=$files[$i-1].name  // ファイル名を取得
					
					// ファイル名がプレフィックスで始まるかどうかをチェック
					If (Position:C15($prefix; $currentFileName)=1)
						// プレフィックスで始まるファイルを削除
						$files[$i-1].delete()
						
					End if 
				End for 
				
				//ラベルファイルを削除
				C_OBJECT:C1216($jcl_fields)
				$jcl_fields:=cs:C1710.JCL_fields.new()
				$jcl_fields.deleteLabelFile($tblName)
				
			End for 
			
			//テーブル一覧を作成
			JCL_lst_Deselect(->vD00_lstT)
			RELOAD PROJECT:C1739
			This:C1470.lstT_make()
			
			//フィールド一覧を更新
			This:C1470.lstT_OnSelChange()
			
		End if 
	End if 
	
Function btnColors()
	//20240415
	//フォームカラーの色変更ダイアログを表示
	C_OBJECT:C1216($d01)
	
	$d01:=cs:C1710.JCL_D01.new()
	If ($d01.dlg_ok=1)
		//リスト再作成
		This:C1470.lstFL_init()
		
		This:C1470.lstT_make()
		
		This:C1470.setControlsValues()
		
	End if 
	
Function btnFormColor()
	//20240503
	//フォームカラーの色変更、カラーピッカーを表示
	
	C_TEXT:C284($tblName)
	C_LONGINT:C283($color)
	C_LONGINT:C283($nr)
	
	$nr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
	$color:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_Color)
	$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
	
	//カラーピッカー
	$new_color:=Select RGB color:C956($color)
	If ($new_color#0)
		//色変更
		$color_text:=Replace string:C233(String:C10($new_color; "&$"); "$"; "")
		
		$len:=6-Length:C16($color_text)
		For ($i; 1; $len)
			$color_text:="0"+$color_text
			
		End for 
		$color_text:="#"+$color_text
		
		//フォームカラーを変更
		Super:C1706.formColor_apply($tblName; $color_text)
		
		//リスト再作成
		//This.lstFL_init()
		
		This:C1470.lstT_make()
		
		//行選択
		JCL_lst_SetSelect_byLong(->vD00_lstT; ->vD00_lstT_nr; $nr)
		This:C1470.lstT_OnSelChange()
		
		This:C1470.setControlsValues()
		
	End if 
	
Function btnDelete()
	//D00_btnDelete
	//20240210 wat
	//テーブルと関連メソッド、関連フォームを削除
	//テーブル削除はDrop table,
	//フォームメソッドは/Sources/Methodsのプリフィックスがテーブルと同じなら削除
	
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($tblName; $prefix)
	C_LONGINT:C283($dlgOk)
	
	$prefix:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_prefix)
	$tblNr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
	$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
	If ($tblName#"")
		//確認メッセージ
		$msg:="テーブル["+$tblName+"]を削除します。よろしいですか。"
		$dlgOk:=JCL_dlg_YesNo("テーブル削除"; $msg; "削除"; "キャンセル")
		If ($dlgOk=1)
			//テーブル削除
			C_POINTER:C301($tblPtr)
			$tblPtr:=Table:C252($tblNr)
			JCL_tbl_DelAll($tblPtr)
			C_TEXT:C284($sql)
			
			$sql:="drop table "+$tblName+";"
			SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
			SQL EXECUTE:C820($sql)
			SQL LOGOUT:C872
			
			//関連メソッドを削除：オブジェクトメソッドはフォルダごと消す
			C_OBJECT:C1216($folder)
			$folder:=New object:C1471
			$folder:=Folder:C1567("/SOURCES/TableForms/"+String:C10($tblNr))
			$folder.delete(Delete with contents:K24:24)
			
			//関連メソッドを削除：フォームメソッド
			C_COLLECTION:C1488($files)
			$files:=New collection:C1472
			//$folder:=Folder("/SOURCES/Methods/")
			$files:=Folder:C1567("/SOURCES/Methods/").files(fk ignore invisible:K87:22)
			For ($i; 1; $files.length)
				C_TEXT:C284($currentFileName)
				$currentFileName:=$files[$i-1].name  // ファイル名を取得
				
				// ファイル名がプレフィックスで始まるかどうかをチェック
				If (Position:C15($prefix; $currentFileName)=1)
					// プレフィックスで始まるファイルを削除
					$files[$i-1].delete()
					
				End if 
			End for 
			
			//ラベルファイルを削除
			C_OBJECT:C1216($jcl_fields)
			$jcl_fields:=cs:C1710.JCL_fields.new()
			$jcl_fields.deleteLabelFile($tblName)
			
			//テーブル一覧を作成
			JCL_lst_Deselect(->vD00_lstT)
			RELOAD PROJECT:C1739
			This:C1470.lstT_make()
			
			//フィールド一覧を更新
			This:C1470.lstT_OnSelChange()
			
		End if 
	End if 
	
Function btnFields()
	//D00_btnFields
	//20240121 yabe wat
	//fields表示
	
	C_LONGINT:C283($dlgOK)
	C_OBJECT:C1216(vD02)
	
	vD02:=cs:C1710.JCL_D02.new()
	$dlgOk:=vD02.display()
	If ($dlgOk=1)
		//リスト再作成
		RELOAD PROJECT:C1739
		This:C1470.lstT_make()
		
		This:C1470.setControlsValues()
		
	End if 
	
Function btnForm()
	//D00_btnForm
	//20240210 wat
	//テーブル一覧で選択されているテーブルの一覧表ウインドウを表示
	
	C_TEXT:C284($tblName)
	C_TEXT:C284($methodName)
	C_TEXT:C284($tbl_prefix)
	C_LONGINT:C283($pos)
	C_LONGINT:C283($nr)
	
	$nr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
	$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
	
	If ($tblName#"")
		
		ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
		ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
		ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
		ARRAY TEXT:C222($aryFieldIndex; 0)
		C_TEXT:C284($fblName)
		
		C_TEXT:C284($tbl_prefix)
		//テーブルからプリフィックスを取得、
		JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		$pos:=Position:C15("_"; $aryFieldName{1})
		$tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //フィールド名のプリフィックス
		
		//メソッド実行
		$methodName:=$tbl_prefix+"01_List"
		$cnt:=JCL_method_isExist($methodName)
		If ($cnt=0)
			//なければ作る。01がないことでまだ未作成と判断、01だけでなく02と03も作成
			This:C1470.formGenerateOne($tblName)
			
			//メッセージ
			$msg:="メソッド「"+$methodName+"」を作成しました。"
			ALERT:C41($msg)
			
		End if 
		
		EXECUTE METHOD:C1007($methodName)
		
		This:C1470.lstT_make()
		
		JCL_lst_SetSelect_byLong(->vD00_lstT; ->vD00_lstT_nr; $nr)
		
		//フィールド一覧の色を更新
		C_LONGINT:C283($color)
		$color:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_Color)
		If ($color=0)
			$color:=0x00FFFFFF
		End if 
		OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; $color)
		
		This:C1470.setControlsValues()
		
	End if 
	
Function btnFormAll()
	//20240424 wat
	//すべてのテーブルについてフォームを生成
	
	C_LONGINT:C283($i; $sizeOfAry)
	
	$sizeOfAry:=Size of array:C274(vD00_lstT_name)
	For ($i; 1; $sizeOfAry)
		$tblName:=vD00_lstT_name{$i}
		
		This:C1470.formGenerateOne($tblName)
		
	End for 
	
	This:C1470.lstT_make()
	
	This:C1470.setControlsValues()
	
Function formGenerateOne()
	//20240424 wat refactor
	//テーブル名を与えて、01メソッドがなければフォーム生成
	
	C_TEXT:C284($1; $tblName)
	$tblName:=$1
	C_TEXT:C284($methodName)
	C_TEXT:C284($tbl_prefix)
	C_LONGINT:C283($pos)
	ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
	ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
	ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
	ARRAY TEXT:C222($aryFieldIndex; 0)
	C_LONGINT:C283($cnt)
	
	//テーブルからプリフィックスを取得、
	JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	$pos:=Position:C15("_"; $aryFieldName{1})
	$tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //フィールド名のプリフィックス
	//メソッド実行
	$methodName:=$tbl_prefix+"01_List"
	$cnt:=JCL_method_isExist($methodName)
	If ($cnt=0)
		//なければ作る。01がないことでまだ未作成と判断、01だけでなく02と03も作成
		$form:=cs:C1710.JCL_formGenerator.new()
		$form.formGenerator($tblName)
		RELOAD PROJECT:C1739  //20240207 4djapan recommends
		
	End if 
	
Function lstT()
	//D00_lstT
	//20240204 wat
	//リストボックス オブジェクトメソッド
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Double Clicked:K2:5)
			
			This:C1470.lstT_OnDblClicked()
			
		: ($frmEvnt=On Selection Change:K2:29)
			
			This:C1470.lstT_OnSelChange()
			
	End case 
	
Function lstT_OnDblClicked()
	//D00_lstT_OnDblClicked
	//20240214 wat
	
	This:C1470.btnForm()
	
Function lstT_OnSelChange()
	//D00_lstT_OnSelChange
	//20240204 wat
	//選択行が変わった
	
	C_LONGINT:C283($tblNr)
	
	//配列初期化
	This:C1470.lstFL_init()
	
	//テーブル名
	$tblNr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
	If ($tblNr>0)
		//フィールド配列作成
		This:C1470.lstFL_make($tblNr)
		
		//色を付ける
		C_LONGINT:C283($color)
		$color:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_Color)
		If ($color=0)
			$color:=0x00FFFFFF
		End if 
		OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; $color)
		
	End if 
	
	This:C1470.setControlsValues()
	
Function lstFL_init()
	//20240417
	
	JCL_lst_Deselect(->vD00_lstFL)
	
	//フィールドの配列初期化
	DELETE FROM ARRAY:C228(vD00_lstFL_Nr; 1; Size of array:C274(vD00_lstFL_Nr))
	DELETE FROM ARRAY:C228(vD00_lstFL_NAME; 1; Size of array:C274(vD00_lstFL_NAME))
	DELETE FROM ARRAY:C228(vD00_lstFL_LABEL; 1; Size of array:C274(vD00_lstFL_LABEL))
	DELETE FROM ARRAY:C228(vD00_lstFL_DATA_TYPE; 1; Size of array:C274(vD00_lstFL_DATA_TYPE))
	
	DELETE FROM ARRAY:C228(vD00_lstFL_LENGTH; 1; Size of array:C274(vD00_lstFL_LENGTH))
	DELETE FROM ARRAY:C228(vD00_lstFL_INDEX; 1; Size of array:C274(vD00_lstFL_INDEX))
	DELETE FROM ARRAY:C228(vD00_lstFL_UNIQUE; 1; Size of array:C274(vD00_lstFL_UNIQUE))
	DELETE FROM ARRAY:C228(vD00_lstFL_COMMENT; 1; Size of array:C274(vD00_lstFL_COMMENT))
	DELETE FROM ARRAY:C228(vD00_lstFL_REMARK; 1; Size of array:C274(vD00_lstFL_REMARK))
	
	//選択テーブル情報をクリア
	OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; Background color none:K23:10)
	vD00_varTableName:=""
	
Function lstFL_make()
	//D00_lstFL_make
	//20240208 wat
	//テーブル番号から、ストラクチャーからフィールド情報を取り出して配列要素に追加
	
	C_LONGINT:C283($1; $tblNr)
	$tblNr:=$1
	C_LONGINT:C283($numOfFields; $i)
	C_TEXT:C284($field_name)
	C_LONGINT:C283($type; $length)
	C_BOOLEAN:C305($index; $unique; $invisible)
	C_TEXT:C284($comment; $remark)
	
	//ラベルキャッシュ作成
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	$jcl_fields.cache_make()
	
	//フィールド情報取得
	$numOfFields:=Get last field number:C255($tblNr)
	For ($i; 1; $numOfFields)
		
		If (Is field number valid:C1000($tblNr; $i)=True:C214)
			
			$field_name:=Field name:C257($tblNr; $i)
			GET FIELD PROPERTIES:C258($tblNr; $i; $type; $length; $index; $unique; $invisible)
			
			APPEND TO ARRAY:C911(vD00_lstFL_Nr; $i)  //フィールド番号
			APPEND TO ARRAY:C911(vD00_lstFL_NAME; $field_name)  // フィールド名
			APPEND TO ARRAY:C911(vD00_lstFL_DATA_TYPE; String:C10($type))  // データ型
			APPEND TO ARRAY:C911(vD00_lstFL_LENGTH; $length)  // 文字長さ
			APPEND TO ARRAY:C911(vD00_lstFL_INDEX; $index)  // True = インデックス付き、False = インデックスなし
			APPEND TO ARRAY:C911(vD00_lstFL_UNIQUE; $unique)  // True = 重複不可、 False = 重複あり
			APPEND TO ARRAY:C911(vD00_lstFL_INVISIBLE; $invisible)  // True = 非表示、 False = 表示
			
			//以下、field_labelsから取得
			$fldLabel:=$jcl_fields.cache_FieldLabel_get($field_name)
			$comment:=$jcl_fields.cache_FieldComment_get($field_name)
			$remark:=$jcl_fields.cache_FieldRemark_get($field_name)
			APPEND TO ARRAY:C911(vD00_lstFL_LABEL; $fldLabel)  // フィールドラベル（論理名）
			APPEND TO ARRAY:C911(vD00_lstFL_COMMENT; $comment)  // 説明
			APPEND TO ARRAY:C911(vD00_lstFL_REMARK; $remark)  // サンプルデータ等
			
		End if 
	End for 
	