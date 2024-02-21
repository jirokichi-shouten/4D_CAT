//Form01
//20240215 wat
//フォーム０１を作成するクラス

Class constructor
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($text)
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	
	//リソースフォルダから、テンプレートファイルの内容を読み込んで　解析
	$text:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/frm01_v3.txt").getText()
	$objFrm:=JSON Parse:C1218($text)
	This:C1470.objForm:=$objFrm
	
Function saveForm($objParam)
	//プロジェクトのソースフォルダに保存
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($tblNrText)
	$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
	$tblNrText:=String:C10($tblNr)
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/form.4DForm")
	$bool:=$file.create()
	
	//ファイルに書き出す
	$file.setText(JSON Stringify:C1217($objFrm; *))
	
Function saveObjMethod($objParam; $objName)
	//プロジェクトのソースフォルダに保存
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($tblNrText)
	$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
	$tblNrText:=String:C10($tblNr)
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+$objName+".4dm"
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/ObjectMethods/"+$new_obj_name)
	$bool:=$file.create()
	//ファイルの中身はメソッド名だけ
	$body:=$objParam.frm_prefix+$objName
	
	//ファイルに書き出す
	$file.setText($body)
	
Function addTitle($objParam; $top; $left)
	//タイトルバック（色付き）
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+"_rectTitle"
	This:C1470.objForm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="rectangle"
	$objFrm.pages[1].objects[$new_obj_name].top:=0
	$objFrm.pages[1].objects[$new_obj_name].left:=0
	$objFrm.pages[1].objects[$new_obj_name].width:=1042
	$objFrm.pages[1].objects[$new_obj_name].height:=55
	$objFrm.pages[1].objects[$new_obj_name].fill:=$objParam.color_text
	$objFrm.pages[1].objects[$new_obj_name].stroke:=$objParam.color_text
	
	//フォームのタイトル文字列
	$new_obj_name:="v"+$objParam.frm_prefix+"_txtTitle"
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="text"
	$objFrm.pages[1].objects[$new_obj_name].top:=16
	$objFrm.pages[1].objects[$new_obj_name].left:=20
	$objFrm.pages[1].objects[$new_obj_name].width:=192
	$objFrm.pages[1].objects[$new_obj_name].height:=26
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic16"
	$objFrm.pages[1].objects[$new_obj_name].text:=JCL_fields_cache_TableLabel($objParam.tbl_name)+"一覧"
	
Function addText($objParam; $top; $left)
	//フォームの件数文字列
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+"_varNumOfRecs"
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="input"
	$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
	$objFrm.pages[1].objects[$new_obj_name].top:=$top
	$objFrm.pages[1].objects[$new_obj_name].left:=$left
	$objFrm.pages[1].objects[$new_obj_name].width:=110
	$objFrm.pages[1].objects[$new_obj_name].height:=17
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].fill:="transparent"
	$objFrm.pages[1].objects[$new_obj_name].borderStyle:="none"
	$objFrm.pages[1].objects[$new_obj_name].enterable:=False:C215
	$objFrm.pages[1].objects[$new_obj_name].contextMenu:="none"
	$objFrm.pages[1].objects[$new_obj_name].dragging:="none"
	$objFrm.pages[1].objects[$new_obj_name].dropping:="custom"
	$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onDataChange")
	
Function addPictureButton($objParam; $top; $left)
	//ピクチャーボタン
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+$objParam.btn_name
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="pictureButton"
	$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
	$objFrm.pages[1].objects[$new_obj_name].top:=$top
	$objFrm.pages[1].objects[$new_obj_name].left:=$left
	$objFrm.pages[1].objects[$new_obj_name].width:=26
	$objFrm.pages[1].objects[$new_obj_name].height:=26
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].rowCount:=4
	$objFrm.pages[1].objects[$new_obj_name].picture:=$objParam.btn_pic_path
	$objFrm.pages[1].objects[$new_obj_name].switchBackWhenReleased:=True:C214
	$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
	$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
	//オブジェクトメソッドを作成
	//JCL_prj_FG_tblObjMethod($objParam; "_btnAdd")
	
Function addButton($objParam; $top; $left; $width; $height)
	//ボタン
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+$objParam.btn_name
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="button"
	$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
	$objFrm.pages[1].objects[$new_obj_name].top:=$top
	$objFrm.pages[1].objects[$new_obj_name].left:=$left
	$objFrm.pages[1].objects[$new_obj_name].width:=$width
	$objFrm.pages[1].objects[$new_obj_name].height:=$height
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].action:=$objParam.btn_action
	$objFrm.pages[1].objects[$new_obj_name].shortcutKey:=$objParam.btn_shortcut_key
	$objFrm.pages[1].objects[$new_obj_name].shortcutAccel:=True:C214
	$objFrm.pages[1].objects[$new_obj_name].text:=$objParam.btn_text
	$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
	
Function addListbox($objParam; $top; $left; $width; $height; \
$aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr)
	//リストボックス
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_obj_name)
	$new_obj_name:="v"+$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="listbox"
	$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
	$objFrm.pages[1].objects[$new_obj_name].top:=$top
	$objFrm.pages[1].objects[$new_obj_name].left:=$left
	$objFrm.pages[1].objects[$new_obj_name].width:=$width
	$objFrm.pages[1].objects[$new_obj_name].height:=$height
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].sizingX:="grow"
	$objFrm.pages[1].objects[$new_obj_name].sizingY:="grow"
	$objFrm.pages[1].objects[$new_obj_name].resizingMode:="legacy"
	$objFrm.pages[1].objects[$new_obj_name].rowHeight:="20px"
	$objFrm.pages[1].objects[$new_obj_name].rowHeightAutoMin:="20px"
	$objFrm.pages[1].objects[$new_obj_name].rowHeightAutoMax:="20px"
	$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
	$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick"; "onDoubleClick"; \
		"onDataChange"; "onSelectionChange"; "onHeaderClick")
	$objFrm.pages[1].objects[$new_obj_name].columns:=New collection:C1472
	
	//リストボックス、フィールド（列）
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objCol; $col_header; $col_footer)
	$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
	For ($i; 1; $sizeOfAry)
		$objCol:=New object:C1471
		$objCol.name:="v"+$objParam.frm_prefix+"_lst"+$aryFieldNamePtr->{$i}
		$objCol.dataSource:=$objCol.name
		$objCol.width:=JCL_prj_fg_fldWidth($aryFieldTypePtr->{$i}; $aryFieldLengthPtr->{$i})
		$objCol.enterable:=False:C215
		$objCol.truncateMode:="none"
		$objCol.class:="JCL_YuGothic12"
		$objCol.events:=New collection:C1472("onClick"; "onDataChange")
		
		$col_header:=New object:C1471
		$col_header.name:="v"+$objParam.frm_prefix+"_lhd"+$aryFieldNamePtr->{$i}
		$col_header.dataSource:=$col_header.name
		$label:=JCL_fields_Label($aryFieldNamePtr->{$i})
		$col_header.text:=$label
		$col_header.class:="JCL_YuGothic10"
		$objCol.header:=$col_header
		
		$col_footer:=New object:C1471
		$col_footer.name:="v"+$objParam.frm_prefix+"_lft"+$aryFieldNamePtr->{$i}
		$col_footer.dataSource:=$col_footer.name
		$col_footer.timeFormat:="hh_mm_ss"
		$col_footer.class:="JCL_YuGothic12"
		$objCol.footer:=$col_footer
		
		$objFrm.pages[1].objects[$new_obj_name].columns.push($objCol)
		
	End for 
	
	