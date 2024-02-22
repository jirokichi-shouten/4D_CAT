//Form01
//20240215 wat
//フォームを作成するクラス

Class constructor
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($text)
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	
	//リソースフォルダから、テンプレートファイルの内容を読み込んで　解析
	$text:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/"+$objParam.form_templates).getText()
	$objFrm:=JSON Parse:C1218($text)
	This:C1470.objForm:=$objFrm
	
Function saveForm($objParam)
	//プロジェクトのソースフォルダに保存
	C_OBJECT:C1216($objFrm)
	//$objFrm:=New object
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
	C_TEXT:C284($new_name)
	$new_name:="v"+$objName+".4dm"
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/ObjectMethods/"+$new_name)
	$bool:=$file.create()
	//ファイルの中身はメソッド名だけ
	$body:=$objName
	
	//ファイルに書き出す
	$file.setText($body)
	
Function saveFrmMethod($objParam)
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
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/method.4dm")
	$bool:=$file.create()
	
	//ファイルの中身はメソッド名だけ //日付時刻文字列を作成
	$dateTimeStr:=JCL_str_dateTime(Current date:C33; Current time:C178)
	$body:="//"+$dateTimeStr+Char:C90(Carriage return:K15:38)
	$body:=$body+$objParam.frm_prefix+"_frm"
	
	//ファイルに書き出す
	$file.setText($body)
	
Function addRect($objParam; $top; $left; $width; $height)
	//タイトルバック（色付き）
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="rectangle"
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].fill:=$objParam.color_text
	$objFrm.pages[1].objects[$new_name].stroke:=$objParam.color_text
	
Function addLabel($objParam; $top; $left; $width; $height)
	//フォームのタイトル文字列
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="text"
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:=$objParam.css_class
	$objFrm.pages[1].objects[$new_name].text:=$objParam.text
	
Function addVarText($objParam; $top; $left; $width; $height)
	//フォームの件数文字列
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="input"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:=$objParam.css_class
	$objFrm.pages[1].objects[$new_name].fill:="transparent"
	$objFrm.pages[1].objects[$new_name].borderStyle:="none"
	$objFrm.pages[1].objects[$new_name].enterable:=False:C215
	$objFrm.pages[1].objects[$new_name].contextMenu:="none"
	$objFrm.pages[1].objects[$new_name].textAlign:=$objParam.textAlign
	$objFrm.pages[1].objects[$new_name].dragging:="none"
	$objFrm.pages[1].objects[$new_name].dropping:="custom"
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onDataChange")
	
Function addPictureButton($objParam; $top; $left)
	//ピクチャーボタン
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="pictureButton"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=26
	$objFrm.pages[1].objects[$new_name].height:=26
	$objFrm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_name].rowCount:=4
	$objFrm.pages[1].objects[$new_name].picture:=$objParam.picture
	$objFrm.pages[1].objects[$new_name].switchBackWhenReleased:=True:C214
	$objFrm.pages[1].objects[$new_name].useLastFrameAsDisabled:=True:C214
	$objFrm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addButton($objParam; $top; $left; $width; $height)
	//ボタン
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="button"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_name].action:=$objParam.action
	$objFrm.pages[1].objects[$new_name].shortcutKey:=$objParam.shortcutKey
	$objFrm.pages[1].objects[$new_name].shortcutAccel:=True:C214
	$objFrm.pages[1].objects[$new_name].text:=$objParam.text
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addMethodButton($objParam; $top; $left; $width; $height)
	//ボタン
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="button"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	$objFrm.pages[1].objects[$new_name].shortcutAccel:=True:C214
	$objFrm.pages[1].objects[$new_name].text:=$objParam.text
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addListbox($objParam; $top; $left; $width; $height; \
$aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr)
	//リストボックス
	C_OBJECT:C1216($objFrm)
	$objFrm:=New object:C1471
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="listbox"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_name].sizingX:="grow"
	$objFrm.pages[1].objects[$new_name].sizingY:="grow"
	$objFrm.pages[1].objects[$new_name].resizingMode:="legacy"
	$objFrm.pages[1].objects[$new_name].rowHeight:="20px"
	$objFrm.pages[1].objects[$new_name].rowHeightAutoMin:="20px"
	$objFrm.pages[1].objects[$new_name].rowHeightAutoMax:="20px"
	$objFrm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onClick"; "onDoubleClick"; \
		"onDataChange"; "onSelectionChange"; "onHeaderClick")
	$objFrm.pages[1].objects[$new_name].columns:=New collection:C1472
	
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
		
		$objFrm.pages[1].objects[$new_name].columns.push($objCol)
		
	End for 
	
Function saveMethods($objParam; $aryFieldNamePtr; $aryFieldTypePtr)
	//JCLのテンプレートから、メソッド群を生成
	C_TEXT:C284($body; $methodName; $templateFileName)
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_OBJECT:C1216($folder)
	$folder:=New object:C1471
	C_COLLECTION:C1488($files)
	$files:=New collection:C1472
	$folder:=Folder:C1567("/RESOURCES/JCL4D_Resources/"+$objParam.method_templates)
	$files:=$folder.files(fk ignore invisible:K87:22)
	
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objCol; $col_header; $col_footer)
	$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
	For ($i; 1; $files.length)
		//ファイル名を取得して//メソッド名生成
		$templateFileName:=$files[$i-1].name
		$methodName:=$templateFileName
		$methodName:=Replace string:C233($methodName; "[--TABLE]"; $objParam.tbl_name)
		$methodName:=Replace string:C233($methodName; "[--FRM_PREFIX]"; $objParam.frm_prefix)
		$methodName:=Replace string:C233($methodName; "[--TBL_PREFIX]"; $objParam.tbl_prefix)
		
		//テンプレートの中身を取得
		$body:=$files[$i-1].getText()
		$body:=JCL_prj_fg_method_replaceTags($objParam; $body; $aryFieldNamePtr; $aryFieldTypePtr)
		
		//ファイルに書き出す
		$file:=File:C1566("/SOURCES/Methods/"+$methodName+".4dm")
		$bool:=$file.create()
		$file.setText($body)
		
	End for 
	
Function addInput($objParam; $top; $left; $width; $height)
	//フォームの件数文字列
	C_OBJECT:C1216($objFrm)
	$objFrm:=This:C1470.objForm
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	$objFrm.pages[1].objects[$new_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_name].type:="input"
	$objFrm.pages[1].objects[$new_name].dataSource:=$new_name
	$objFrm.pages[1].objects[$new_name].top:=$top
	$objFrm.pages[1].objects[$new_name].left:=$left
	$objFrm.pages[1].objects[$new_name].width:=$width
	$objFrm.pages[1].objects[$new_name].height:=$height
	$objFrm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_name].borderStyle:="sunken"
	$objFrm.pages[1].objects[$new_name].focusable:=True:C214
	$objFrm.pages[1].objects[$new_name].enterable:=True:C214
	$objFrm.pages[1].objects[$new_name].dropping:="custom"
	$objFrm.pages[1].objects[$new_name].events:=New collection:C1472("onDataChange")
	