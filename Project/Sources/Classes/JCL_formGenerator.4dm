//JCL_formGenerator
//JCL_fg
//JCL Form Generator and related functions
//20240331 Jirokichi
//JCLのうちフォーム生成関連のメソッド群をクラス化

//JCL_prj_FormGeneratorV4をクラス化しようとしているが、
//catFormクラスにボタン生成とかを記述済み、catFormをformGeneratorに改名して拡張する案が浮上
//連続してフォームを生成する機能もあったほうがいい：テーブル名を与えて繰り返すモジュール。D00 btnForm()を修正したい。


Class constructor
	
Function colorRandom()
	//JCL_utl_ColorRandom
	//20210317 wat
	//ランダムなカラーを黄金比配分で生成して文字列で返す
	//$color_txt:="#FF0000"
	//引数に強度を与える。強度：1 - 8
	
	C_LONGINT:C283($1; $intensity)
	$intensity:=$1
	C_TEXT:C284($0; $retStr)
	$retStr:=""
	C_LONGINT:C283($num; $red; $green; $blue)
	C_TEXT:C284($tmpStr)
	ARRAY LONGINT:C221($aryColor; 0)
	
	APPEND TO ARRAY:C911($aryColor; 255)  //1
	APPEND TO ARRAY:C911($aryColor; 218)  //2
	APPEND TO ARRAY:C911($aryColor; 195)  //3
	APPEND TO ARRAY:C911($aryColor; 158)  //4
	APPEND TO ARRAY:C911($aryColor; 97)  //5
	APPEND TO ARRAY:C911($aryColor; 60)  //6
	APPEND TO ARRAY:C911($aryColor; 37)  //7
	APPEND TO ARRAY:C911($aryColor; 0)  //8
	
	$red:=$aryColor{Mod:C98(Random:C100; $intensity)}
	$green:=$aryColor{Mod:C98(Random:C100; $intensity)}
	$blue:=$aryColor{Mod:C98(Random:C100; $intensity)}
	
	$num:=16*16*$red+16*$green+$blue
	$num:=16*16*($red+100)+16*($green+100)+$blue+100
	$tmpStr:=String:C10($num; "&$")
	If (Length:C16($tmpStr)>7)
		$tmpStr:=Substring:C12($tmpStr; 3; 8)
		
	Else 
		$tmpStr:=Substring:C12($tmpStr; 2; 7)
		
	End if 
	
	$retStr:="#"
	$retStr:=$retStr+Replace string:C233($tmpStr; "$"; "")
	
	$0:=$retStr
	
	
Function formGenerator()
	//JCL_prj_FormGeneratorV4
	//20240210 wat
	//フォームを作る//フォームジェネレータ02、一覧用リストボックスのフォーム「xx01_List」を作る
	//20240327 ike wat rename
	
	C_TEXT:C284($1; $tblName)  //テーブル名
	$tblName:=$1
	
	ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
	ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
	ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
	ARRAY TEXT:C222($aryFieldIndex; 0)
	
	C_TEXT:C284($prefix; $frmName; $tblName)
	C_LONGINT:C283($pos)
	
	If ($tblName#"")
		//テーブル名と色
		C_OBJECT:C1216($objParam)
		$objParam:=New object:C1471
		$objParam.tbl_name:=$tblName
		$objParam.color_text:=This:C1470.colorRandom(8)
		
		//ストラクチャからフィールド情報を取得
		JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		$sizeOfAry:=Size of array:C274($aryFieldName)
		If ($sizeOfAry>0)
			//JCL_fields_cache
			C_OBJECT:C1216($jcl_fields)
			$jcl_fields:=cs:C1710.JCL_fields.new()
			$jcl_fields.cache_make()
			
		End if 
		
		//テーブルからプリフィックスを取得、
		C_LONGINT:C283($pos)
		$pos:=Position:C15("_"; $aryFieldName{1})  //１つ目のフィールド名のアンダーバーの前の文字列
		$objParam.tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //テーブル名のプリフィックス
		
		//01フォーム作成
		$objParam.frm_name:=$objParam.tbl_prefix+"01_List"  //フォーム名
		$objParam.frm_prefix:=$objParam.tbl_prefix+"01"  //フォーム名のプリフィックス
		$objParam.form_templates:="frm01_v3.txt"
		$objParam.method_templates:="method_templates_list"
		This:C1470.form01_List($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
		
		//02フォーム作成
		$objParam.frm_name:=$objParam.tbl_prefix+"02_Input"  //フォーム名
		$objParam.frm_prefix:=$objParam.tbl_prefix+"02"  //フォーム名のプリフィックス
		$objParam.method_templates:="method_templates_form"
		This:C1470.form02_Input_add($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
		
		//03フォーム作成
		$objParam.frm_name:=$objParam.tbl_prefix+"03_Input"  //フォーム名
		$objParam.frm_prefix:=$objParam.tbl_prefix+"03"  //フォーム名のプリフィックス
		$objParam.method_templates:="method_templates_form"
		This:C1470.form03_Input_mod($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
		
	End if 
	
Function form01_List()
	//JCL_prj_FG_tblFrm01V4
	//20240215 
	//テーブルフォーム作成 JSONとオブジェクト記法を使う方法
	//クラスを使って、フォームを生成
	// 引数として テーブル名、テーブルプリフィックス、フォーム名、フォームプリフィックスを渡します
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_POINTER:C301($2; $aryFieldNamePtr)
	$aryFieldNamePtr:=$2
	C_POINTER:C301($3; $aryFieldTypePtr)
	$aryFieldTypePtr:=$3
	C_POINTER:C301($4; $aryFieldLengthPtr)
	$aryFieldLengthPtr:=$4
	//ラベルキャッシュ作成
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	//$jcl_fields.cache_make()
	
	//クラスインスタンス作成＆コンストラクター実行
	//フォームメソッド
	$frm01:=cs:C1710.catForm.new($objParam)
	
	//フォームメソッドを作成
	$frm01.saveFrmMethod($objParam)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm01.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=$jcl_fields.cache_TableLabel_get($objParam.tbl_name)+"一覧"
	$objParam.css_class:="JCL_YuGothic16"
	$frm01.addLabel($objParam; 16; 20; 192; 26)
	
	//フォームの件数文字列
	$objParam.name:=$objParam.frm_prefix+"_varNumOfRecs"
	$objParam.textAlign:="right"
	$objParam.css_class:="JCL_YuGothic12"
	$frm01.addVarText($objParam; 80; 880; 110; 17)
	
	//検索用 ラベルとキーワードフィールド、ボタン
	$objParam.name:=$objParam.frm_prefix+"_lblKeyword"
	$objParam.text:="キーワード"
	$objParam.css_class:="JCL_YuGothic12"
	$frm01.addLabel($objParam; 74; 272; 80; 17)
	$objParam.name:=$objParam.frm_prefix+"_varKeyword"
	$frm01.addInput($objParam; 74; 356; 110; 17; True:C214)
	$objParam.name:=$objParam.frm_prefix+"_btnFind"
	$objParam.shortcutKey:="[Return]"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/magnifyingglass.png"
	$frm01.addPictureButton($objParam; 68; 466)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのAddボタン
	$objParam.name:=$objParam.frm_prefix+"_btnAdd"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
	$frm01.addPictureButton($objParam; 68; 20)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのModボタン
	$objParam.name:=$objParam.frm_prefix+"_btnMod"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_pencil_w.png"
	$frm01.addPictureButton($objParam; 68; 68)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのDelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDel"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
	$frm01.addPictureButton($objParam; 68; 162)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのExportボタン
	$objParam.name:=$objParam.frm_prefix+"_btnExport"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_arrow_down.png"
	$frm01.addPictureButton($objParam; 68; 996)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCloseボタン
	$objParam.name:=$objParam.frm_prefix+"_btnClose"
	$objParam.text:="X"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="w"
	$frm01.addButton($objParam; 16; 980; 42; 26)
	
	//リストボックス
	$objParam.name:=$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix
	$frm01.addListbox($objParam; 110; 20; 1002; 440; $aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr; "")
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//最終的に.4DFormに保存
	$frm01.saveForm($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm01.saveMethods($objParam; $aryFieldNamePtr; $aryFieldTypePtr)
	
Function form02_Input_add()
	//JCL_prj_FG_tblFrm02V4
	//20240222 wat
	//クラスを使って、xx02_Inputフォームを生成
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_POINTER:C301($2; $inAryFldNamePtr)
	$inAryFldNamePtr:=$2
	C_POINTER:C301($3; $inAryFieldTypePtr)
	$inAryFldTypePtr:=$3
	C_POINTER:C301($4; $inAryFldLengthPtr)
	$inAryFldLengthPtr:=$4
	
	//クラスインスタンス作成＆コンストラクター実行
	C_OBJECT:C1216($frm01)
	$frm01:=cs:C1710.catForm.new($objParam)
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	$jcl_fields.cache_make()
	
	//フォームメソッド
	$frm01.saveFrmMethod($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm01.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm01.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=$jcl_fields.cache_TableLabel_get($objParam.tbl_name)+"編集"
	$objParam.css_class:="JCL_YuGothic16"
	$frm01.addLabel($objParam; 16; 26; 288; 26)
	
	//フォームのOKボタン
	$objParam.name:=$objParam.frm_prefix+"_btnOK"
	$objParam.text:="OK"
	$frm01.addMethodButton($objParam; 16; 928; 94; 26)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCancelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnCancel"
	$objParam.text:="キャンセル"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="[Esc]"
	$frm01.addButton($objParam; 16; 814; 94; 26)
	
	//フォームのDeleteボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDelete"
	$objParam.text:="削除"
	$frm01.addMethodButton($objParam; 16; 700; 94; 26)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フィールド用の文字列を作成、複数フィールドを作成
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objFldPos)
	$objFldPos:=New object:C1471
	C_TEXT:C284($fld_name; $label)
	C_LONGINT:C283($fldWidth)
	C_BOOLEAN:C305($enterable)
	$objFldPos.top:=90
	$objFldPos.left:=110
	$objFldPos.label_left:=10
	$sizeOfAry:=Size of array:C274($inAryFldNamePtr->)
	For ($i; 1; $sizeOfAry)
		//フィールドラベルを取得
		$fld_name:=$inAryFldNamePtr->{$i}
		$label:=$jcl_fields.cache_FieldLabel_get($fld_name)
		If ($label="")
			//ラベルが取得できなかったらフィールド名を使う
			$label:=$fld_name
			
		End if 
		//フィールド位置
		$objFldPos:=This:C1470.fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
		
		//フィールドラベル
		$objParam.name:=$objParam.frm_prefix+"_lbl"+$fld_name
		$objParam.text:=$label
		$objParam.css_class:="JCL_YuGothic12"
		$frm01.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
		
		//フィールドがIDなら入力不可
		C_BOOLEAN:C305($enterable)
		If ($fld_name=($objParam.tbl_prefix+"_ID"))
			$enterable:=False:C215
		Else 
			$enterable:=True:C214
		End if 
		$objParam.name:=$objParam.frm_prefix+"_var"+$fld_name
		$frm01.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
		
	End for 
	
	//最終的に.4DFormに保存
	$frm01.saveForm($objParam)
	
Function form03_Input_mod()
	//JCL_prj_FG_tblFrm03V4
	//20240227 wat
	//クラスを使って、xx03_Inputフォームを生成
	//編集フォーム、関連テーブルのリストボックスがあるかも
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_POINTER:C301($2; $inAryFldNamePtr)
	$inAryFldNamePtr:=$2
	C_POINTER:C301($3; $inAryFieldTypePtr)
	$inAryFldTypePtr:=$3
	C_POINTER:C301($4; $inAryFldLengthPtr)
	$inAryFldLengthPtr:=$4
	
	//クラスインスタンス作成＆コンストラクター実行
	$frm01:=cs:C1710.catForm.new($objParam)
	
	//フォームメソッド
	$frm01.saveFrmMethod($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm01.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm01.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=JCL_fields_cache_TableLabel($objParam.tbl_name)+"編集"
	$objParam.css_class:="JCL_YuGothic16"
	$frm01.addLabel($objParam; 16; 26; 288; 26)
	
	//フォームのOKボタン
	$objParam.name:=$objParam.frm_prefix+"_btnOK"
	$objParam.text:="OK"
	$frm01.addMethodButton($objParam; 16; 928; 94; 26)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCancelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnCancel"
	$objParam.text:="キャンセル"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="[Esc]"
	$frm01.addButton($objParam; 16; 814; 94; 26)
	
	//フォームのDeleteボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDelete"
	$objParam.text:="削除"
	$frm01.addMethodButton($objParam; 16; 700; 94; 26)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フィールド用の文字列を作成、複数フィールドを作成
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objFldPos)
	$objFldPos:=New object:C1471
	C_TEXT:C284($fld_name; $label)
	C_LONGINT:C283($fldWidth)
	$objFldPos.top:=90
	$objFldPos.left:=110
	$objFldPos.label_left:=10
	$sizeOfAry:=Size of array:C274($inAryFldNamePtr->)
	For ($i; 1; $sizeOfAry)
		//フィールドラベルを取得
		$fld_name:=$inAryFldNamePtr->{$i}
		$label:=JCL_fields_Label($fld_name)
		If ($label="")
			//ラベルが取得できなかったらフィールド名を使う
			$label:=$fld_name
			
		End if 
		//フィールド位置
		$objFldPos:=This:C1470.fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
		
		//フィールドラベル
		$objParam.name:=$objParam.frm_prefix+"_lbl"+$fld_name
		$objParam.text:=$label
		$objParam.css_class:="JCL_YuGothic12"
		$frm01.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
		
		//フィールドがIDなら入力不可
		C_BOOLEAN:C305($enterable)
		If ($fld_name=($objParam.tbl_prefix+"_ID"))
			$enterable:=False:C215
		Else 
			$enterable:=True:C214
		End if 
		$objParam.name:=$objParam.frm_prefix+"_var"+$inAryFldNamePtr->{$i}
		$frm01.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
		
	End for 
	
	//外部キーを他テーブルに見つけたら、リストボックスを自動生成
	C_LONGINT:C283($offset)
	C_OBJECT:C1216($foreignParam)
	$foreignParam:=New object:C1471
	C_TEXT:C284($tblName; $tbl_prefix)
	ARRAY LONGINT:C221($aryTblNr; 0)
	ARRAY TEXT:C222($aryForeignKeys; 0)
	ARRAY TEXT:C222($aryFieldIndex; 0)
	$cnt:=This:C1470.findForeignKey($objParam.tbl_name; ->$aryTblNr; ->$aryForeignKeys)
	For ($i; 1; $cnt)
		$tblName:=Table name:C256($aryTblNr{$i})
		$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($tblName)  //テーブルプリフィックス
		ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
		ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
		ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
		JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		
		//関連テーブルが複数ある場合、リストボックスとボタンたちをオフセットしていく
		$offset:=20*$i
		
		//フォームのAppendボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Append"
		$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
		$frm01.addPictureButton($objParam; 200+$offset; $offset)
		$frm01.saveObjMethod($objParam; $objParam.name)
		
		//フォームのRemoveボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Remove"
		$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
		$frm01.addPictureButton($objParam; 200+$offset; $offset+142)
		$frm01.saveObjMethod($objParam; $objParam.name)
		
		//フォームのCopyボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Copy"
		$objParam.text:="コピー"
		$frm01.addMethodButton($objParam; 200+$offset; $offset+188; 80; 26)
		$frm01.saveObjMethod($objParam; $objParam.name)
		
		//リストボックス
		$objParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
		$frm01.addListbox($objParam; 236+$offset; $offset; 1002; 288; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; "foreign")
		$frm01.saveObjMethod($objParam; $objParam.name)
		
		//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
		$foreignParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
		$frm01.saveObjMethod($objParam; $foreignParam.name)
		
		$foreignParam.frm_prefix:=$objParam.frm_prefix
		$foreignParam.parent_tbl_prefix:=$objParam.tbl_prefix
		$foreignParam.parent_tbl_name:=$objParam.tbl_name
		$foreignParam.tbl_name:=$tblName
		$foreignParam.tbl_prefix:=$tbl_prefix
		$foreignParam.method_templates:="method_templates_form03"
		$frm01.saveMethods($foreignParam; ->$aryFieldName; ->$aryFieldType)
		
	End for 
	
	//最終的に.4DFormに保存
	$frm01.saveForm($objParam)
	
Function fldNextPos()
	//JCL_prj_fg_fldNextPos
	//20210606 wat
	//次のフィールドの位置（top, left, ）を返す
	//20240201 ike wat $default_topを追加、トップの戻るところ 
	
	C_OBJECT:C1216($1; $inObj)
	$inObj:=$1
	C_LONGINT:C283($2; $default_top)
	$default_top:=$2
	C_OBJECT:C1216($0; $outObj)
	$outObj:=$inObj
	C_LONGINT:C283($top)
	C_LONGINT:C283($v_offset; $h_offset)
	$v_offset:=26
	$h_offset:=246
	$h_offset:=398
	C_LONGINT:C283($form_height)
	$form_height:=674
	$form_height:=178  //debug
	
	$top:=$inObj.top+$v_offset
	If ($top>=$form_height)
		//フォームの高さからはみ出している。次の列の一番上の座標
		$outObj.top:=$default_top
		$outObj.left:=$inObj.left+$h_offset
		$outObj.label_left:=$inObj.label_left+$h_offset
		
	Else 
		//はみ出さなければ、一つ下の座標
		$outObj.top:=$inObj.top+$v_offset
		$outObj.left:=$inObj.left
		$outObj.label_left:=$inObj.label_left
		
	End if 
	
	$0:=$outObj
	
Function findForeignKey()
	//20240225 wat
	//外部キーを見つける。xx_yy_IDの形を見つけて、配列でテーブル名を返す。
	//相手のテーブルが存在したら外部キーとみなす
	
	C_TEXT:C284($1; $inTablName)
	$inTablName:=$1
	C_POINTER:C301($2; $outAryTblNrPtr)
	$outAryTblNrPtr:=$2
	C_POINTER:C301($3; $outAryFldNamePtr)
	$outAryFldNamePtr:=$3
	C_LONGINT:C283($cnt; $0)
	$cnt:=0
	C_LONGINT:C283($tblNr; $numOfTables)
	ARRAY POINTER:C280($aryFldPtr; 0)
	C_LONGINT:C283($numOfFlds; $k)
	C_TEXT:C284($table_name; $field_name; $field_name_wo_prefix)
	
	//自テーブルの外部キーを見つける。プリフィックス＋IDに決め打ち
	$prefix:=This:C1470.getPrefix_fromStructure($inTablName)
	$foreign_key:=$prefix+"_ID"
	
	//自テーブル以外の各テーブルについて
	$numOfTables:=Get last table number:C254
	For ($tblNr; 1; $numOfTables)
		//有効なテーブルについて実行
		If (Is table number valid:C999($tblNr))
			$table_name:=Table name:C256($tblNr)
			If ($inTablName#$table_name)
				//テーブル名が異なるので別テーブル
				DELETE FROM ARRAY:C228($aryFldPtr; 1; Size of array:C274($aryFldPtr))
				$numOfFlds:=This:C1470.aryFieldPtr_make($tblNr; ->$aryFldPtr)
				For ($k; 1; $numOfFlds)
					$field_name:=Field name:C257($aryFldPtr{$k})
					$pos:=Position:C15("_"; $field_name)
					
					//VV_IDがYY_VV_IDに入っているようなケース。マッチングZZxVV_IDの場合は ZZxVV_VV_IDもあるはず
					//フィールド名からプリフィックスを除いた文字列を対象に判断する
					//ER_MAKER_NAMEもあるから1文字目からアンダーバーまでを除く
					$field_name_wo_prefix:=Substring:C12($field_name; $pos+1)
					If (Position:C15($foreign_key; $field_name_wo_prefix)=1)
						//プリフィックスを除いたあとの文字列の先頭が、外部キーなら、このテーブルは１対多の多と判断。
						$cnt:=$cnt+1
						APPEND TO ARRAY:C911($outAryTblNrPtr->; $tblNr)
						APPEND TO ARRAY:C911($outAryFldNamePtr->; $field_name)
						
					End if 
				End for 
			End if 
		End if 
	End for 
	
	$0:=$cnt
	
Function getPrefix_fromStructure()
	//20210106 wat
	//テーブル名からテーブルプリフィックスを取得
	//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。
	
	C_TEXT:C284($1; $tableName)
	$tableName:=$1
	C_TEXT:C284($0; $prefix)
	$prefix:=""
	C_LONGINT:C283($i; $numOfTables)
	C_LONGINT:C283($pos)
	C_BOOLEAN:C305($isValid)
	
	$numOfTables:=Get last table number:C254
	For ($i; 1; $numOfTables)
		
		$isValid:=Is table number valid:C999($i)
		If ($isValid=True:C214)
			If ($tableName=Table name:C256($i))
				$fieldName:=Field name:C257($i; 1)
				
				//最初のアンダースコアより前の文字列をプリフィックスとする
				$pos:=Position:C15("_"; $fieldName)
				$prefix:=Substring:C12($fieldName; 1; $pos-1)
				
			End if 
		End if 
	End for 
	
	$0:=$prefix
	
Function aryFieldPtr_make()
	//20221013 wat
	//フィールドポインタの配列を作成
	
	C_LONGINT:C283($1; $tblNr)  //テーブル番号を得る
	$tblNr:=$1
	C_POINTER:C301($2; $aryFldPtr)
	$aryFldPtr:=$2
	C_LONGINT:C283($0; $numOfFlds)
	$numOfFlds:=0
	C_LONGINT:C283($numOfFields; $i)
	
	//フィールド情報取得
	$numOfFields:=Get last field number:C255($tblNr)
	For ($i; 1; $numOfFields)
		
		If (Is field number valid:C1000($tblNr; $i)=True:C214)
			
			$fldPtr:=Field:C253($tblNr; $i)
			APPEND TO ARRAY:C911($aryFldPtr->; $fldPtr)
			
			
		End if 
		
	End for 
	
	$0:=$numOfFields
	