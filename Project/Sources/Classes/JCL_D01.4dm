//JCL_D01
//20240416 wat
//フォームカラーの色変更ダイアログを表示

property tbl_name : Text
property color_text : Text
property dlg_ok : Integer

Class constructor
	//usage:
	//C_OBJECT($dlg)
	//$dlg:=cs.JCL_D01.new()
	//If ($dlg.dlg_ok=1)
	////do something
	//End if 
	
	C_OBJECT:C1216(cD01)
	cD01:=This:C1470  // 20240503 クラス用プロセス変数定義
	
	This:C1470.tbl_name:=""
	This:C1470.color_text:=cs:C1710.JCL_formGenerator.new().colorRandom(7)
	This:C1470.dlg_ok:=0
	
	//画面表示
	$dlgOk:=This:C1470.display()
	
	This:C1470.dlg_ok:=$dlgOk
	
Function display()
	//JCL_D01_Display
	//D01_Display
	//フォームカラー変更　ダイアログ　を表示
	
	C_LONGINT:C283($winRef)
	C_LONGINT:C283($0)
	C_TEXT:C284($frmName)
	$frmName:="JCL_D01_Select"
	C_TEXT:C284($title)
	$title:=$frmName
	
	$winRef:=Open form window:C675($frmName; Movable form dialog box:K39:8; \
		Horizontally centered:K39:1; Vertically centered:K39:4; *)
	SET WINDOW TITLE:C213("テーブル色選択")
	
	SET WINDOW TITLE:C213($title)
	DIALOG:C40($frmName)  //ウィンドウにフォームを表示する
	
	CLOSE WINDOW:C154  //ウィンドウを閉じる
	
	$0:=OK
	
Function frm()
	//JCL_D01_frm
	//20210607 WAT
	//フォームメソッド
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Load:K2:1)
			This:C1470.frmOnLoad()
			
	End case 
	
Function frmOnLoad()
	//JCL_D01_frmOnLoad
	//20210607 wat
	//オンロードメソッド
	
	This:C1470.frmDefInit()
	
	This:C1470.popTableName_make()
	
	//色
	C_TEXT:C284($color_txt)
	$color_txt:=This:C1470.color_text
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectTitle"; $color_txt; $color_txt)
	
	//別の色５色
	This:C1470.fiveColors()
	
	//使用済み色リスト、テーブル一覧
	This:C1470.lstTB_make()
	
	This:C1470.setControlsValues()
	
Function setControlsValues()
	//20240515
	//フォームオブジェクトを制御
	
	//リストボックスの選択行が１つの時に編集ボタンはイネイブル
	JCL_btn_SetEnable_byListSelect(->vJCL_D01_lstTB; ->vJCL_D01_btnApply)
	
	
Function frmDefInit()
	//D01_frmDefInit
	//20210607 wat
	//ログインダイアログ用　プロセス変数
	
	C_TEXT:C284(vJCL_D01_tblName)
	vJCL_D01_tblName:=""
	
	//テーブル名
	ARRAY TEXT:C222(vJCL_D01_aryTableName; 0)
	vJCL_D01_aryTableName:=0
	
	//別の色
	C_TEXT:C284(vJCL_D01_varColorText0)
	C_TEXT:C284(vJCL_D01_varColorText1)
	C_TEXT:C284(vJCL_D01_varColorText2)
	C_TEXT:C284(vJCL_D01_varColorText3)
	C_TEXT:C284(vJCL_D01_varColorText4)
	C_TEXT:C284(vJCL_D01_varColorText5)
	C_TEXT:C284(vJCL_D01_varColorText6)
	C_TEXT:C284(vJCL_D01_fldColorText)
	
	//色リスト
	ARRAY BOOLEAN:C223(vJCL_D01_lstTB; 0)
	ARRAY LONGINT:C221(vJCL_D01_lstTB_Nr; 0)
	ARRAY TEXT:C222(vJCL_D01_lstTB_COLOR; 0)
	ARRAY TEXT:C222(vJCL_D01_lstTB_NAME; 0)
	
Function popTableName_make()
	//JCL_D01_popTableName_make
	//20210607 wat
	//テーブル名をポップアップリストに表示するための配列
	
	C_LONGINT:C283($0; $cnt)
	$cnt:=0
	C_LONGINT:C283($numOfTables; $i)
	C_TEXT:C284($table_name)
	
	APPEND TO ARRAY:C911(vJCL_D01_aryTableName; "")
	
	//テーブル数を取得
	$numOfTables:=Get last table number:C254
	For ($i; 1; $numOfTables)
		If (Is table number valid:C999($i)=True:C214)
			//テーブル名を取得して配列に格納
			$table_name:=Table name:C256($i)
			If ($table_name#"")  //wat_add 20111005
				
				APPEND TO ARRAY:C911(vJCL_D01_aryTableName; $table_name)
				$cnt:=$cnt+1
				
			End if 
		End if 
	End for 
	
Function fiveColors()
	//vJCL_D01_btnColor
	//20210607 wat
	//別の色５色
	
	C_TEXT:C284($color_txt)
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(8)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor0"; $color_txt; $color_txt)
	vJCL_D01_varColorText0:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(7)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor1"; $color_txt; $color_txt)
	vJCL_D01_varColorText1:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(6)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor2"; $color_txt; $color_txt)
	vJCL_D01_varColorText2:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(5)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor3"; $color_txt; $color_txt)
	vJCL_D01_varColorText3:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(4)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor4"; $color_txt; $color_txt)
	vJCL_D01_varColorText4:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(3)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor5"; $color_txt; $color_txt)
	vJCL_D01_varColorText5:=$color_txt
	
	$color_txt:=cs:C1710.JCL_formGenerator.new().colorRandom(2)
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor6"; $color_txt; $color_txt)
	vJCL_D01_varColorText6:=$color_txt
	
Function lstTB_make()
	//JCL_D01_lstTB_make
	//20220425 hisa wat
	//カラーテーブル
	//20221006 hisa wat
	
	C_TEXT:C284($table_name)
	ARRAY TEXT:C222($aryTblNames; 0)
	C_LONGINT:C283($sizeOfAry; $i)
	C_LONGINT:C283($color)
	C_TEXT:C284($colorText)
	
	//すべてのテーブル
	cs:C1710.JCL_tbl.new().getNames(->$aryTblNames)
	
	COPY ARRAY:C226($aryTblNames; vJCL_D01_lstTB_NAME)
	
	$sizeOfAry:=Size of array:C274(vJCL_D01_lstTB_NAME)
	ARRAY LONGINT:C221(vJCL_D01_lstTB_Nr; $sizeOfAry)
	ARRAY TEXT:C222(vJCL_D01_lstTB_COLOR; $sizeOfAry)
	For ($i; 1; $sizeOfAry)
		//配列を追加
		vJCL_D01_lstTB_Nr{$i}:=$i
		
		$table_name:=vJCL_D01_lstTB_NAME{$i}
		
		//生成したテーブルフォームの色を取得、タイトルのバックにあるレクトから
		$colorText:=cs:C1710.JCL_formGenerator.new().formColor_get($table_name)
		
		//リストボックスに適用
		If ($colorText#"")
			//ゼロは白なのでスキップ、実行すると黒になるため
			LISTBOX SET ROW COLOR:C1270(*; "vJCL_D01_lstTB_COLOR"; $i; $colorText; lk background color:K53:25)
			
		End if 
		
		//色を整数から１６進数の文字列に変換する
		vJCL_D01_lstTB_COLOR{$i}:=$colorText
		
	End for 
	
	
Function popTableName()
	//20210607 wat
	//テーブル名 ポップアップ
	
	C_TEXT:C284($selStr)
	
	$selStr:=vJCL_D01_aryTableName{vJCL_D01_aryTableName}
	
	This:C1470.tbl_name:=$selStr
	
Function btnUseColor()
	//JCL_D01_btnUseColor
	//20210607 wat
	//別の色を使う
	//20220430 wat 色選びにこだわってしまうことがある。その時に効率がいいように５色から選ぶようにした。
	//20221011 hisa wat バージョン確認作業　GitHubにアップ
	
	C_TEXT:C284($btnNname; $numStr; $rectName)
	C_TEXT:C284($color_text)
	
	//クリックされたボタン名から、色付き四角形の名前を推定して、色を取得
	$btnNname:=OBJECT Get name:C1087(Object current:K67:2)
	$numStr:=Substring:C12($btnNname; Length:C16($btnNname); 1)
	$rectName:="vJCL_D01_rectColor"+$numStr
	
	OBJECT GET RGB COLORS:C1074(*; $rectName; $color_text)
	
	//サンプルとして、このダイアログのタイトルレクトにセット
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectTitle"; $color_text; $color_text)
	
	//呼び出し元に戻すためのプロセス変数に代入
	This:C1470.color_text:=$color_text
	
Function lstTB()
	//JCL_D01_lstTB
	//20220430 wat
	//テーブル名をクリックして選択できる
	
	C_LONGINT:C283($frmEvnt)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Clicked:K2:4)
			$tblName:=JCL_lst_Selected_Str(->vJCL_D01_lstTB; ->vJCL_D01_lstTB_NAME)
			
			$index:=Find in array:C230(vJCL_D01_aryTableName; $tblName)
			If ($index#-1)
				vJCL_D01_aryTableName:=$index
				
			End if 
			
			This:C1470.tbl_name:=$tblName
			
			This:C1470.setControlsValues()
			
	End case 
	
Function btnReRandom()
	//JCL_D01_btnReRandom
	//20210607 wat
	//別の色５色
	
	This:C1470.fiveColors()
	
Function fldColorText()
	//20240417 wat
	//入力フィールドのイベント
	
	C_TEXT:C284($color_txt)
	C_LONGINT:C283($frmEvnt)
	C_LONGINT:C283($len)
	C_TEXT:C284($first_char)
	
	$frmEvnt:=Form event code:C388
	Case of 
		: ($frmEvnt=On Data Change:K2:15)
			//長さが７文字で、最初の文字が＃
			$len:=Length:C16(vJCL_D01_fldColorText)
			$first_char:=Substring:C12(vJCL_D01_fldColorText; 1; 1)
			If (($len=7) & ($first_char="#"))
				//右のレクトに色を適用する
				$color_txt:=vJCL_D01_fldColorText
				OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor10"; $color_txt; $color_txt)
				
			End if 
			
	End case 
	
Function btnUseEditColor()
	//20240417 wat
	//エディットフィールドのカラー値を使う
	C_TEXT:C284($color_txt)
	
	$color_text:=vJCL_D01_fldColorText
	
	//サンプルとして、このダイアログのタイトルレクトにセット
	OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectTitle"; $color_text; $color_text)
	
	//呼び出し元に戻すためのプロセス変数に代入
	This:C1470.color_text:=$color_text
	
Function btnApply()
	//20240416 wat
	//テーブルにフォームがあって、タイトルの四角形があれば、色を変更
	
	C_TEXT:C284($table_name)
	C_TEXT:C284($color_text)
	C_TEXT:C284($tbl_prefix)
	C_TEXT:C284($form_name)
	
	$table_name:=This:C1470.tbl_name
	$color_text:=This:C1470.color_text
	
	cs:C1710.JCL_formGenerator.new().formColor_apply($table_name; $color_text)
	
	//使用済み色リスト、テーブル一覧
	JCL_lst_Deselect(->vJCL_D01_lstTB)
	
	This:C1470.lstTB_make()
	