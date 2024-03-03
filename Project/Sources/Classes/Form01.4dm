//Form01
//20240215 wat
//フォームを作成するクラス

Class constructor
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($text)
	//C_OBJECT($objForm)
	//$objForm:=New object
	
	//リソースフォルダから、テンプレートファイルの内容を読み込んで　解析
	$text:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/"+$objParam.form_templates).getText()
	//This.objForm:=JSON Parse($text)
	//This.objForm:=This.objForm
	This:C1470.objForm:=JSON Parse:C1218($text)
	
Function saveForm($objParam : Object)
	//プロジェクトのソースフォルダに保存
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($tblNrText)
	$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
	$tblNrText:=String:C10($tblNr)
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/form.4DForm")
	$bool:=$file.create()
	
	//ファイルに書き出す
	$file.setText(JSON Stringify:C1217(This:C1470.objForm; *))
	
Function saveObjMethod($objParam : Object; $objName : Text)
	//プロジェクトのソースフォルダに保存
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
	
Function saveFrmMethod($objParam : Object)
	//プロジェクトのソースフォルダに保存
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
	
Function addRect($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//タイトルバック（色付き）
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="rectangle"
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].fill:=$objParam.color_text
	This:C1470.objForm.pages[1].objects[$new_name].stroke:=$objParam.color_text
	
Function addLabel($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//フォームのタイトル文字列
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="text"
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:=$objParam.css_class
	This:C1470.objForm.pages[1].objects[$new_name].text:=$objParam.text
	
Function addVarText($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//フォームの件数文字列
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="input"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:=$objParam.css_class
	This:C1470.objForm.pages[1].objects[$new_name].fill:="transparent"
	This:C1470.objForm.pages[1].objects[$new_name].borderStyle:="none"
	This:C1470.objForm.pages[1].objects[$new_name].enterable:=False:C215
	This:C1470.objForm.pages[1].objects[$new_name].contextMenu:="none"
	This:C1470.objForm.pages[1].objects[$new_name].textAlign:=$objParam.textAlign
	This:C1470.objForm.pages[1].objects[$new_name].dragging:="none"
	This:C1470.objForm.pages[1].objects[$new_name].dropping:="custom"
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onDataChange")
	
Function addPictureButton($objParam : Object; $top : Integer; $left)
	//ピクチャーボタン
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="pictureButton"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=26
	This:C1470.objForm.pages[1].objects[$new_name].height:=26
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].rowCount:=4
	This:C1470.objForm.pages[1].objects[$new_name].picture:=$objParam.picture
	This:C1470.objForm.pages[1].objects[$new_name].switchBackWhenReleased:=True:C214
	This:C1470.objForm.pages[1].objects[$new_name].useLastFrameAsDisabled:=True:C214
	This:C1470.objForm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addButton($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//ボタン
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="button"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].action:=$objParam.action
	This:C1470.objForm.pages[1].objects[$new_name].shortcutKey:=$objParam.shortcutKey
	This:C1470.objForm.pages[1].objects[$new_name].shortcutAccel:=True:C214
	This:C1470.objForm.pages[1].objects[$new_name].text:=$objParam.text
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addMethodButton($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//メソッド付きボタン
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="button"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	This:C1470.objForm.pages[1].objects[$new_name].shortcutAccel:=True:C214
	This:C1470.objForm.pages[1].objects[$new_name].text:=$objParam.text
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onClick")
	
Function addListbox($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer; \
$aryFieldNamePtr : Pointer; $aryFieldTypePtr : Pointer; $aryFieldLengthPtr : Pointer; $foreign : Text)
	//リストボックス
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="listbox"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].sizingX:="grow"
	This:C1470.objForm.pages[1].objects[$new_name].sizingY:="grow"
	This:C1470.objForm.pages[1].objects[$new_name].resizingMode:="legacy"
	This:C1470.objForm.pages[1].objects[$new_name].rowHeight:="20px"
	This:C1470.objForm.pages[1].objects[$new_name].rowHeightAutoMin:="20px"
	This:C1470.objForm.pages[1].objects[$new_name].rowHeightAutoMax:="20px"
	This:C1470.objForm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onClick"; "onDoubleClick"; \
		"onDataChange"; "onSelectionChange"; "onHeaderClick")
	This:C1470.objForm.pages[1].objects[$new_name].columns:=New collection:C1472
	
	If ($foreign="foreign")
		//編集可能なリストボックス
		This:C1470.objForm.pages[1].objects[$new_name].singleClickEdit:=True:C214
		This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onClick"; \
			"onDataChange"; "onSelectionChange"; "onHeaderClick")
		
	End if 
	
	//リストボックス、フィールド（列）
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objCol; $col_header; $col_footer)
	$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
	For ($i; 1; $sizeOfAry)
		$objCol:=New object:C1471
		$objCol.name:="v"+$objParam.frm_prefix+"_lst"+$aryFieldNamePtr->{$i}
		$objCol.dataSource:=$objCol.name
		$objCol.width:=JCL_prj_fg_fldWidth($aryFieldTypePtr->{$i}; $aryFieldLengthPtr->{$i})
		If ($foreign="foreign")
			//IDフィールド以外は入力可
			C_TEXT:C284($col_name)
			$col_name:="v"+$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix+"_ID"
			If ($objCol.name=$col_name)
				$objCol.enterable:=False:C215
			Else 
				$objCol.enterable:=True:C214
			End if 
		Else 
			$objCol.enterable:=False:C215
		End if 
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
		
		This:C1470.objForm.pages[1].objects[$new_name].columns.push($objCol)
		
	End for 
	
Function saveMethods($objParam : Object; $aryFieldNamePtr : Pointer; $aryFieldTypePtr : Pointer)
	//JCLのテンプレートから、メソッド群を生成
	C_TEXT:C284($body; $methodName; $templateFileName)
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_OBJECT:C1216($folder)
	$folder:=New object:C1471
	C_COLLECTION:C1488($files)
	$files:=New collection:C1472
	C_LONGINT:C283($i)
	
	//リソースフォルダのテンプレートファイルを取得
	$folder:=Folder:C1567("/RESOURCES/JCL4D_Resources/"+$objParam.method_templates)
	$files:=$folder.files(fk ignore invisible:K87:22)
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
	
Function saveRelatedMethods($objParam : Object; $aryFieldNamePtr : Pointer; $aryFieldTypePtr : Pointer)
	//JCLのテンプレートから、メソッド群を生成
	C_TEXT:C284($body; $methodName; $templateFileName)
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_OBJECT:C1216($folder)
	$folder:=New object:C1471
	C_COLLECTION:C1488($files)
	$files:=New collection:C1472
	C_LONGINT:C283($i; $k)
	
	//リソースフォルダのテンプレートファイルを取得
	$folder:=Folder:C1567("/RESOURCES/JCL4D_Resources/"+$objParam.method_templates)
	$files:=$folder.files(fk ignore invisible:K87:22)
	
	For ($i; 1; $files.length)
		//ファイル名を取得して//メソッド名生成
		$templateFileName:=$files[$i-1].name
		$methodName:=$templateFileName
		$methodName:=Replace string:C233($methodName; "[--TABLE]"; $objParam.tbl_name)
		$methodName:=Replace string:C233($methodName; "[--FRM_PREFIX]"; $objParam.frm_prefix)
		$methodName:=Replace string:C233($methodName; "[--TBL_PREFIX]"; $objParam.tbl_prefix)
		$methodName:=Replace string:C233($methodName; "[--PARENT_TBL_PREFIX]"; $objParam.parent_tbl_prefix)
		
		//テンプレートの中身を取得
		$body:=$files[$i-1].getText()
		$body:=JCL_prj_fg_method_replaceTags($objParam; $body; $aryFieldNamePtr; $aryFieldTypePtr)
		
		//ファイルに書き出す
		$file:=File:C1566("/SOURCES/Methods/"+$methodName+".4dm")
		If ($file.exists=True:C214)
			//メソッドファイルがあれば中身に連結
			$old_body:=$file.getText()
			$body:=$old_body+Char:C90(Carriage return:K15:38)+$body
			
		Else 
			//なければ作成
			$bool:=$file.create()
			
		End if 
		$file.setText($body)
		
	End for 
	
	
Function addInput($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer; \
$enterable : Boolean)
	//フォームの件数文字列
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="input"
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].focusable:=True:C214
	This:C1470.objForm.pages[1].objects[$new_name].enterable:=$enterable
	If ($enterable=False:C215)
		//入力不可なら見た目を変える
		This:C1470.objForm.pages[1].objects[$new_name].borderStyle:="dotted"
		This:C1470.objForm.pages[1].objects[$new_name].fill:="transparent"
		This:C1470.objForm.pages[1].objects[$new_name].focusable:=False:C215
		
	End if 
	This:C1470.objForm.pages[1].objects[$new_name].dropping:="custom"
	This:C1470.objForm.pages[1].objects[$new_name].events:=New collection:C1472("onDataChange")
	