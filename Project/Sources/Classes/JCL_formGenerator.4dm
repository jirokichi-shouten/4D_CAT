//JCL_formGenerator
//JCL_fg
//JCL Form Generator and related functions
//20240331 Jirokichi
//JCLのうちフォーム生成関連のメソッド群をクラス化

//JCL_prj_FormGeneratorV4をクラス化しようとしているが、
//catFormクラスにボタン生成とかを記述済み、catFormをformGeneratorに改名して拡張する案が浮上
//連続してフォームを生成する機能もあったほうがいい：テーブル名を与えて繰り返すモジュール。D00 btnForm()を修正したい。
//20240508 catFormをリネーム、JCL_formObjectsに変更。

property jcl : Text

Class constructor
	//20240512
	//fieldsキャッシュを作成
	
	//ラベルキャッシュ作成
	cs:C1710.JCL_fields.new().cache_make()
	
	
Function colorRandom()
	//JCL_utl_ColorRandom
	//20210317 wat
	//ランダムなカラーを黄金比配分で生成して文字列で返す
	//$color_txt:="#FF0000"
	//引数に強度を与える。強度：2 - 8
	
	C_LONGINT:C283($1; $intensity)
	$intensity:=$1
	C_TEXT:C284($0; $retStr)
	$retStr:=""
	C_LONGINT:C283($red; $green; $blue)
	C_TEXT:C284($blueStr; $greenStr; $blueStr)
	ARRAY LONGINT:C221($aryColor; 8)
	ARRAY LONGINT:C221($aryColor2; 8)
	
	$aryColor{1}:=255
	$aryColor{2}:=218
	$aryColor{3}:=195
	$aryColor{4}:=158
	$aryColor{5}:=97
	$aryColor{6}:=60
	$aryColor{7}:=37
	$aryColor{8}:=0
	
	For ($i; 1; $intensity)
		$aryColor2{$i}:=$aryColor{$i}
	End for 
	
	$red:=$aryColor2{(Mod:C98(Random:C100; $intensity))+1}
	$green:=$aryColor2{(Mod:C98(Random:C100; $intensity))+1}
	$blue:=$aryColor2{(Mod:C98(Random:C100; $intensity))+1}
	
	//16進数表示
	$redStr:=String:C10($red; "&$")
	$greenStr:=String:C10($green; "&$")
	$blueStr:=String:C10($blue; "&$")
	
	//＄を除く
	$redStr:=Replace string:C233($redStr; "$"; "")
	$greenStr:=Replace string:C233($greenStr; "$"; "")
	$blueStr:=Replace string:C233($blueStr; "$"; "")
	
	//各色を２桁にする
	If (Length:C16($redStr)=1)
		$redStr:="0"+$redStr
	End if 
	If (Length:C16($greenStr)=1)
		$greenStr:="0"+$greenStr
	End if 
	If (Length:C16($blueStr)=1)
		$blueStr:="0"+$blueStr
	End if 
	$retStr:="#"+$redStr+$greenStr+$blueStr
	
	$0:=$retStr
	
Function generate()
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
		$objParam.color_text:=This:C1470.colorRandom(3)
		
		//ストラクチャからフィールド情報を取得
		cs:C1710.JCL_tbl.new().getFieldsAttributes($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		$sizeOfAry:=Size of array:C274($aryFieldName)
		If ($sizeOfAry>0)
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
	
	//クラスインスタンス作成＆コンストラクター実行
	//フォームメソッド
	$frm:=cs:C1710.JCL_formObjects.new($objParam)
	
	//フォームメソッドを作成
	$frm.saveFrmMethod($objParam)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=cs:C1710.JCL_fields.new().cache_TableLabel_get($objParam.tbl_name)+"一覧"
	$objParam.css_class:="JCL_YuGothic16"
	$frm.addLabel($objParam; 16; 20; 192; 26)
	
	//フォームの件数文字列
	$objParam.name:=$objParam.frm_prefix+"_varNumOfRecs"
	$objParam.textAlign:="right"
	$objParam.css_class:="JCL_YuGothic12"
	$frm.addVarText($objParam; 80; 880; 110; 17)
	
	//検索用 ラベルとキーワードフィールド、ボタン
	$objParam.name:=$objParam.frm_prefix+"_lblKeyword"
	$objParam.text:="キーワード"
	$objParam.css_class:="JCL_YuGothic12"
	$frm.addLabel($objParam; 74; 272; 80; 17)
	$objParam.name:=$objParam.frm_prefix+"_varKeyword"
	$frm.addInput($objParam; 74; 356; 110; 17; True:C214)
	$objParam.name:=$objParam.frm_prefix+"_btnFind"
	$objParam.shortcutKey:="[Return]"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/magnifyingglass.png"
	$frm.addPictureButton($objParam; 68; 466)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのAddボタン
	$objParam.name:=$objParam.frm_prefix+"_btnAdd"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
	$frm.addPictureButton($objParam; 68; 20)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのModボタン
	$objParam.name:=$objParam.frm_prefix+"_btnMod"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_pencil_w.png"
	$frm.addPictureButton($objParam; 68; 68)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのDelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDel"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
	$frm.addPictureButton($objParam; 68; 162)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのExportボタン
	$objParam.name:=$objParam.frm_prefix+"_btnExport"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_arrow_down.png"
	$frm.addPictureButton($objParam; 68; 996)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCloseボタン
	$objParam.name:=$objParam.frm_prefix+"_btnClose"
	$objParam.text:="X"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="w"
	$frm.addButton($objParam; 16; 980; 42; 26)
	
	//チェックボックス
	$objParam.name:=$objParam.frm_prefix+"_cbxShowDeleted"
	$objParam.type:="checkbox"
	$objParam.text:="削除されたレコードを表示"
	$frm.addCheckBox($objParam; 80; 674; 178; 22)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//リストボックス
	$objParam.name:=$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix
	$frm.addListbox($objParam; 110; 20; 1002; 440; $aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr; "")
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//最終的に.4DFormに保存
	$frm.saveForm($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm.saveMethods($objParam; $aryFieldNamePtr; $aryFieldTypePtr)
	
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
	C_OBJECT:C1216($frm)
	$frm:=cs:C1710.JCL_formObjects.new($objParam)
	
	//フォームメソッド
	$frm.saveFrmMethod($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=cs:C1710.JCL_fields.new().cache_TableLabel_get($objParam.tbl_name)+"編集"
	$objParam.css_class:="JCL_YuGothic16"
	$frm.addLabel($objParam; 16; 26; 288; 26)
	
	//フォームのOKボタン
	$objParam.name:=$objParam.frm_prefix+"_btnOK"
	$objParam.text:="OK"
	$frm.addMethodButton($objParam; 16; 928; 94; 26)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCancelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnCancel"
	$objParam.text:="キャンセル"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="[Esc]"
	$frm.addButton($objParam; 16; 814; 94; 26)
	
	//フォームのDeleteボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDelete"
	$objParam.text:="削除"
	$frm.addMethodButton($objParam; 16; 700; 94; 26)
	$frm.saveObjMethod($objParam; $objParam.name)
	
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
		$label:=cs:C1710.JCL_fields.new().cache_FieldLabel_get($fld_name)
		If ($label="")
			//ラベルが取得できなかったらフィールド名を使う
			$label:=$fld_name
			
		End if 
		
		//フィールドラベル
		$objParam.name:=$objParam.frm_prefix+"_lbl"+$fld_name
		$objParam.text:=$label
		$objParam.css_class:="JCL_YuGothic12"
		$frm.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
		
		//フィールドがIDなら入力不可
		C_BOOLEAN:C305($enterable)
		If ($fld_name=($objParam.tbl_prefix+"_ID"))
			$enterable:=False:C215
		Else 
			$enterable:=True:C214
		End if 
		$objParam.name:=$objParam.frm_prefix+"_var"+$fld_name
		$frm.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
		
		//フィールド位置
		$objFldPos:=This:C1470.fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
		
	End for 
	
	//最終的に.4DFormに保存
	$frm.saveForm($objParam)
	
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
	C_OBJECT:C1216($frm)
	$frm:=cs:C1710.JCL_formObjects.new($objParam)
	
	//フォームメソッド
	$frm.saveFrmMethod($objParam)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$frm.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)
	
	//タイトル文字とタイトルバック（色付き） 
	$objParam.name:=$objParam.frm_prefix+"_rectTitle"
	$frm.addRect($objParam; 0; 0; 1042; 55)
	
	$objParam.name:=$objParam.frm_prefix+"_txtTitle"
	$objParam.text:=cs:C1710.JCL_fields.new().cache_TableLabel_get($objParam.tbl_name)+"編集"
	$objParam.css_class:="JCL_YuGothic16"
	$frm.addLabel($objParam; 16; 26; 288; 26)
	
	//フォームのOKボタン
	$objParam.name:=$objParam.frm_prefix+"_btnOK"
	$objParam.text:="OK"
	$frm.addMethodButton($objParam; 16; 928; 94; 26)
	$frm.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCancelボタン
	$objParam.name:=$objParam.frm_prefix+"_btnCancel"
	$objParam.text:="キャンセル"
	$objParam.action:="cancel"
	$objParam.shortcutKey:="[Esc]"
	$frm.addButton($objParam; 16; 814; 94; 26)
	
	//フォームのDeleteボタン
	$objParam.name:=$objParam.frm_prefix+"_btnDelete"
	$objParam.text:="削除"
	$frm.addMethodButton($objParam; 16; 700; 94; 26)
	$frm.saveObjMethod($objParam; $objParam.name)
	
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
		//フィールドラベル
		$objParam.name:=$objParam.frm_prefix+"_lbl"+$fld_name
		$objParam.text:=$label
		$objParam.css_class:="JCL_YuGothic12"
		$frm.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
		
		//フィールドがIDなら入力不可
		C_BOOLEAN:C305($enterable)
		If ($fld_name=($objParam.tbl_prefix+"_ID"))
			$enterable:=False:C215
		Else 
			$enterable:=True:C214
		End if 
		$objParam.name:=$objParam.frm_prefix+"_var"+$inAryFldNamePtr->{$i}
		$frm.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
		
		//フィールド位置
		$objFldPos:=This:C1470.fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
		
	End for 
	
	//外部キーを他テーブルに見つけたら、リストボックスを自動生成
	C_LONGINT:C283($offset)
	C_LONGINT:C283($cnt)
	C_OBJECT:C1216($foreignParam)
	$foreignParam:=New object:C1471
	C_TEXT:C284($tblName; $tbl_prefix)
	ARRAY LONGINT:C221($aryTblNr; 0)
	ARRAY TEXT:C222($aryForeignKeys; 0)
	ARRAY TEXT:C222($aryFieldIndex; 0)
	$cnt:=cs:C1710.JCL_tbl.new().findForeignKey($objParam.tbl_name; ->$aryTblNr; ->$aryForeignKeys)
	For ($i; 1; $cnt)
		$tblName:=Table name:C256($aryTblNr{$i})
		$tbl_prefix:=cs:C1710.JCL_tbl.new().getPrefix_fromStructure($tblName)  //テーブルプリフィックス
		ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
		ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
		ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
		cs:C1710.JCL_tbl.new().getFieldsAttributes($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		
		//関連テーブルが複数ある場合、リストボックスとボタンたちをオフセットしていく
		$offset:=20*$i
		
		//フォームのAppendボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Append"
		$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
		$frm.addPictureButton($objParam; 200+$offset; $offset)
		$frm.saveObjMethod($objParam; $objParam.name)
		
		//フォームのRemoveボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Remove"
		$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
		$frm.addPictureButton($objParam; 200+$offset; $offset+142)
		$frm.saveObjMethod($objParam; $objParam.name)
		
		//フォームのCopyボタン
		$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Copy"
		$objParam.text:="コピー"
		$frm.addMethodButton($objParam; 200+$offset; $offset+188; 80; 26)
		$frm.saveObjMethod($objParam; $objParam.name)
		
		//リストボックス
		$objParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
		$frm.addListbox($objParam; 236+$offset; $offset; 1002; 288; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; "foreign")
		$frm.saveObjMethod($objParam; $objParam.name)
		
		//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
		$foreignParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
		$frm.saveObjMethod($objParam; $foreignParam.name)
		
		$foreignParam.frm_prefix:=$objParam.frm_prefix
		$foreignParam.parent_tbl_prefix:=$objParam.tbl_prefix
		$foreignParam.parent_tbl_name:=$objParam.tbl_name
		$foreignParam.tbl_name:=$tblName
		$foreignParam.tbl_prefix:=$tbl_prefix
		$foreignParam.method_templates:="method_templates_form03"
		$frm.saveMethods($foreignParam; ->$aryFieldName; ->$aryFieldType)
		
	End for 
	
	//最終的に.4DFormに保存
	$frm.saveForm($objParam)
	
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
	
Function setTitleRectColor()
	//20240416 wat
	//テーブルフォームのファイルを取得、タイトルレクトの色を変更
	
	C_TEXT:C284($1; $form_name)
	$form_name:=$1
	C_TEXT:C284($2; $rec_name)
	$rec_name:=$2
	C_TEXT:C284($3; $table_name)
	$table_name:=$3
	C_TEXT:C284($4; $color_text)
	$color_text:=$4
	C_TEXT:C284($tbl_prefix)
	C_LONGINT:C283($tblNr)
	C_OBJECT:C1216($file)
	C_OBJECT:C1216($frmDef)
	
	//プレフィックス
	$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)
	$tblNr:=JCL_tbl_GetNumber($table_name)
	
	//フォームのファイルを取得
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$form_name+"/form.4DForm")
	If ($file.exists)
		$frmDef:=JSON Parse:C1218($file.getText("UTF-8"; Document with LF:K24:22))
		
		$frmDef.pages[1].objects[$rec_name].fill:=$color_text
		$frmDef.pages[1].objects[$rec_name].stroke:=$color_text
		
		$file.setText(JSON Stringify:C1217($frmDef; *))
		
	End if 
	
Function formColor_apply()
	//20240503
	//フォームカラーを適用する。
	
	C_TEXT:C284($1; $table_name)
	$table_name:=$1
	C_TEXT:C284($2; $color_text)
	$color_text:=$2
	C_TEXT:C284($tbl_prefix)
	C_TEXT:C284($form_name)
	
	//プレフィックス
	$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)
	
	$form_name:=$tbl_prefix+"01_List"
	$rec_name:="v"+$tbl_prefix+"01_rectTitle"
	This:C1470.setTitleRectColor($form_name; $rec_name; $table_name; $color_text)
	
	$form_name:=$tbl_prefix+"02_Input"
	$rec_name:="v"+$tbl_prefix+"02_rectTitle"
	This:C1470.setTitleRectColor($form_name; $rec_name; $table_name; $color_text)
	
	$form_name:=$tbl_prefix+"03_Input"
	$rec_name:="v"+$tbl_prefix+"03_rectTitle"
	This:C1470.setTitleRectColor($form_name; $rec_name; $table_name; $color_text)
	
Function formColor_get()
	//JCL_tbl_GetFormColor
	//20221006 hisa wat
	//生成したテーブルフォームの色を取得、タイトルのバックにあるレクトから
	//ex: vFO01_rectTitleのような名前のフォームオブジェクト
	
	C_TEXT:C284($1; $table_name)
	$table_name:=$1
	C_TEXT:C284($0; $colorText)
	$colorText:=""
	C_TEXT:C284($tbl_prefix)
	C_TEXT:C284($rec_name; $frmPrefix; $form_name)
	C_LONGINT:C283($tblNr)
	C_POINTER:C301($tblPtr)
	
	//プレフィックス
	$tbl_prefix:=cs:C1710.JCL_tbl.new().getPrefix_fromStructure($table_name)
	
	$rec_name:="v"+$tbl_prefix+"01_rectTitle"
	$frmPrefix:=$tbl_prefix+"01"
	$form_name:=$frmPrefix+"_List"
	$tblNr:=cs:C1710.JCL_tbl.new().getNumber($table_name)
	$tblPtr:=Table:C252($tblNr)
	
	$exist:=JCL_frm_isExist($tblPtr; $form_name)
	If ($exist=True:C214)
		FORM LOAD:C1103($tblPtr->; $form_name)
		OBJECT GET RGB COLORS:C1074(*; $rec_name; $colorText)
		FORM UNLOAD:C1299
		
	End if 
	
	$0:=$colorText
	