//JCL_formObjects
//20240215 wat
//フォームを作成するクラス

Class constructor
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($text)
	C_OBJECT:C1216($objForm)
	This:C1470.objForm:=New object:C1471
	
	//リソースフォルダから、テンプレートファイルの内容を読み込んで　解析
	//$text:=File("/RESOURCES/JCL4D_Resources/frm_templates/"+$objParam.form_templates).getText()
	//This.objForm:=JSON Parse($text)
	
	This:C1470.objForm.destination:="detailScreen"
	This:C1470.objForm.width:=1042
	This:C1470.objForm.height:=576
	This:C1470.objForm.windowMinHeight:=178
	This:C1470.objForm.width:=1042
	This:C1470.objForm.events:=New collection:C1472("onLoad"; "onValidate"; \
		"onClick"; "onHeader"; "onDoubleClick"; \
		"onDrop"; "onDataChange"; "onAfterKeystroke;"+\
		"onAfterEdit"; "onBeginDragOver"; "onPageChange")
	This:C1470.objForm.method:="method.4dm"
	This:C1470.objForm.pages:=New collection:C1472(Null:C1517; New object:C1471("objects"; New object:C1471()))
	This:C1470.objForm.geometryStamp:=2
	This:C1470.objForm.$4d:=New object:C1471("version"; "1"; "kind"; "form")
	
Function saveForm($objParam : Object)
	//プロジェクトのソースフォルダに保存
	C_OBJECT:C1216($file)
	$file:=New object:C1471
	C_LONGINT:C283($tblNr)
	C_TEXT:C284($tblNrText)
	$tblNr:=cs:C1710.JCL_tbl.new().getNumber($objParam.tbl_name)  //テーブル番号
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
	$tblNr:=cs:C1710.JCL_tbl.new().getNumber($objParam.tbl_name)  //テーブル番号
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
	$tblNr:=cs:C1710.JCL_tbl.new().getNumber($objParam.tbl_name)  //テーブル番号
	$tblNrText:=String:C10($tblNr)
	$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/method.4dm")
	$bool:=$file.create()
	
	//ファイルの中身はメソッド名だけ //日付時刻文字列を作成
	$dateTimeStr:=cs:C1710.JCL_str.new().dateTime(Current date:C33; Current time:C178)
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
	This:C1470.objForm.pages[1].objects[$new_name].shortcutKey:=$objParam.shortcutKey
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
	
Function addCheckBox($objParam : Object; $top : Integer; $left : Integer; $width : Integer; $height : Integer)
	//メソッド付きボタン
	C_TEXT:C284($new_name)
	$new_name:="v"+$objParam.name
	This:C1470.objForm.pages[1].objects[$new_name]:=New object:C1471
	This:C1470.objForm.pages[1].objects[$new_name].type:="checkbox"
	This:C1470.objForm.pages[1].objects[$new_name].text:=$objParam.text
	This:C1470.objForm.pages[1].objects[$new_name].dataSource:=$new_name
	This:C1470.objForm.pages[1].objects[$new_name].dataSourceTypeHint:="integer"
	This:C1470.objForm.pages[1].objects[$new_name].top:=$top
	This:C1470.objForm.pages[1].objects[$new_name].left:=$left
	This:C1470.objForm.pages[1].objects[$new_name].width:=$width
	This:C1470.objForm.pages[1].objects[$new_name].height:=$height
	This:C1470.objForm.pages[1].objects[$new_name].class:="JCL_YuGothic12"
	This:C1470.objForm.pages[1].objects[$new_name].method:="ObjectMethods/"+$new_name+".4dm"
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
		"onDataChange"; "onAfterSort"; "onSelectionChange"; "onHeaderClick")
	This:C1470.objForm.pages[1].objects[$new_name].columns:=New collection:C1472
	
	If ($foreign="foreign")
		//編集可能なリストボックス
		This:C1470.objForm.pages[1].objects[$new_name].singleClickEdit:=True:C214
		
	End if 
	
	//リストボックス、フィールド（列）
	C_OBJECT:C1216($jcl_fields)
	$jcl_fields:=cs:C1710.JCL_fields.new()
	
	C_LONGINT:C283($i; $sizeOfAry)
	C_OBJECT:C1216($objCol; $col_header; $col_footer)
	$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
	For ($i; 1; $sizeOfAry)
		$objCol:=New object:C1471
		$objCol.name:="v"+$objParam.frm_prefix+"_lst"+$aryFieldNamePtr->{$i}
		$objCol.dataSource:=$objCol.name
		$objCol.dataSourceTypeHint:=This:C1470.columnDataType($aryFieldTypePtr->{$i})  //20240428
		$objCol.width:=This:C1470.fldWidth($aryFieldTypePtr->{$i}; $aryFieldLengthPtr->{$i})
		If ($foreign="foreign")
			//IDフィールド以外は入力可
			C_TEXT:C284($col_name)
			$col_name:="v"+$objParam.name+"_ID"
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
		$label:=$jcl_fields.cache_FieldLabel_get($aryFieldNamePtr->{$i})
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
	
Function fldWidth()
	//JCL_prj_fg_fldWidth
	//20210210 ike wat
	//フィールド長さを返す
	//20240207 hisa ike wat 文字は９０
	//20240327 wat クラス化
	
	C_TEXT:C284($1; $type)
	$type:=$1
	C_TEXT:C284($2; $length)
	$length:=$2
	C_LONGINT:C283($0; $w)
	$w:=10
	
	Case of 
		: ($type="Is Alpha Field")
			If ($w<80)
				$w:=55  //20240327
				
			Else 
				$w:=90  //20240207
				
			End if 
			
		: ($type="Is Text")
			$w:=68
			
		: ($type="Is Real")
			$w:=90
			
		: ($type="Is Integer")
			$w:=42
			
		: ($type="Is LongInt")
			$w:=42
			
		: ($type="Is Date")
			$w:=90
			
		: ($type="Is Time")
			$w:=90
			
		: ($type="Is Boolean")
			$w:=42
		: ($type="Is Picture")
			$w:=90
			
		: ($type="Is Subtable")
			$w:=20
			
		: ($type="Is BLOB")
			$w:=20
	End case 
	
	$0:=$w
	
	
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
		$body:=$files[$i-1].getText("UTF-8"; Document with LF:K24:22)
		//$body:=JCL_prj_fg_method_replaceTags($objParam; $body; $aryFieldNamePtr; $aryFieldTypePtr)
		$body:=This:C1470.method_replaceTags($objParam; $body; $aryFieldNamePtr; $aryFieldTypePtr)
		
		//ファイルに書き出す
		$file:=File:C1566("/SOURCES/Methods/"+$methodName+".4dm")
		$bool:=$file.create()
		$file.setText($body)
		
	End for 
	
Function method_replaceTags()
	//JCL_prj_fg_method_replaceTags
	//20240221 wat
	//テンプレートメソッドのテキスト、タグを置き換える
	//20240327 wat クラス化
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($2; $method)
	$method:=$2  //読み込んだファイルの中身
	C_POINTER:C301($3; $aryFieldNamePtr)
	$aryFieldNamePtr:=$3
	C_POINTER:C301($4; $aryFieldTypePtr)
	$aryFieldTypePtr:=$4
	C_TEXT:C284($0; $newmethod)
	$newmethod:=""
	C_TEXT:C284($tbl_prefix)
	C_LONGINT:C283($len; $h; $k)
	C_LONGINT:C283($pos_row)
	C_TEXT:C284($dateTimeStr)
	C_TEXT:C284($dataType; $initValue; $strValue)
	C_TEXT:C284($chr; $buf; $newBuf)
	//日付時刻文字列を作成
	$dateTimeStr:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
	
	//メソッド生成
	$method:=Replace string:C233($method; "[--DATE]"; $dateTimeStr)
	$method:=Replace string:C233($method; "[--TABLE]"; $objParam.tbl_name)
	$method:=Replace string:C233($method; "[--TBL_PREFIX]"; $objParam.tbl_prefix)
	$method:=Replace string:C233($method; "[--FRM_PREFIX]"; $objParam.frm_prefix)
	If (OB Is defined:C1231($objParam; "parent_tbl_prefix")=True:C214)
		$method:=Replace string:C233($method; "[--PARENT_TBL_PREFIX]"; $objParam.parent_tbl_prefix)
	End if 
	If (OB Is defined:C1231($objParam; "parent_tbl_name")=True:C214)
		$method:=Replace string:C233($method; "[--PARENT_TBL_NAME]"; $objParam.parent_tbl_name)
	End if 
	
	//関連テーブル用のメソッド部分（オンロード）を作成
	C_TEXT:C284($related_method)
	$related_method:=This:C1470.relatedMethods_frmOnLoad($objParam)
	$method:=Replace string:C233($method; "[--RELATED_FRMONLOAD]"; $related_method)
	
	//関連テーブル用のメソッド部分（OKボタン）を作成
	C_TEXT:C284($related_method)
	$related_method:=This:C1470.relatedMethods_btnOK($objParam)
	$method:=Replace string:C233($method; "[--RELATED_BTN_OK]"; $related_method)
	
	//繰り返しタグを置き換え
	$len:=Length:C16($method)
	$buf:=""
	$newmethod:=""
	For ($h; 1; $len)
		$chr:=Substring:C12($method; $h; 1)
		$buf:=$buf+$chr
		If ($chr=Char:C90(Line feed:K15:40))
			//１行取り出した
			$pos_row:=Position:C15("[--FIELD]"; $buf)
			If ($pos_row#0)
				For ($k; 1; Size of array:C274($aryFieldNamePtr->))
					//フィールド名を置換
					$fieldName:=$aryFieldNamePtr->{$k}  //20130501
					$newBuf:=Replace string:C233($buf; "[--FIELD]"; $fieldName)
					
					//データ型を置換
					$dataType:=cs:C1710.JCL_tbl.new().dataType($aryFieldTypePtr->{$k})
					$newBuf:=Replace string:C233($newBuf; "[--DATATYPE]"; $dataType)
					
					//初期値を置換
					$initValue:=cs:C1710.JCL_tbl.new().initValue($aryFieldTypePtr->{$k})
					$newBuf:=Replace string:C233($newBuf; "[--INITVALUE]"; $initValue)
					
					$newmethod:=$newmethod+$newBuf
					
				End for 
			Else 
				$pos_row:=Position:C15("[--FIELD_WO_ID]"; $buf)
				If ($pos_row#0)
					For ($k; 1; Size of array:C274($aryFieldNamePtr->))
						//フィールド名を置換
						$fieldName:=$aryFieldNamePtr->{$k}  //20130501
						If (($objParam.tbl_prefix+"_ID")=$fieldName)
							$newBuf:="//ID（"+$fieldName+"）は出力しない"+$chr
						Else 
							$newBuf:=Replace string:C233($buf; "[--FIELD_WO_ID]"; $fieldName)
						End if 
						
						//データ型を置換
						$dataType:=cs:C1710.JCL_tbl.new().dataType($aryFieldTypePtr->{$k})
						$newBuf:=Replace string:C233($newBuf; "[--DATATYPE]"; $dataType)
						
						//初期値を置換
						$initValue:=cs:C1710.JCL_tbl.new().initValue($aryFieldTypePtr->{$k})
						$newBuf:=Replace string:C233($newBuf; "[--INITVALUE]"; $initValue)
						
						$newmethod:=$newmethod+$newBuf
						
					End for 
				Else 
					//[--FIELD]タグも[--FIELD_WO_ID]タグもどちらもなかった場合
					$newmethod:=$newmethod+$buf
					
				End if 
			End if 
			
			
			$buf:=""
			
		End if 
	End for 
	
	$0:=$newmethod
	
Function relatedMethods_frmOnLoad()
	//関連テーブル用のfrmOnLoadメソッド部分を作成
	//20240509 
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($0; $body)
	$body:=""
	C_LONGINT:C283($cnt)
	ARRAY LONGINT:C221($aryTblNr; 0)
	ARRAY TEXT:C222($aryForeignKeys; 0)
	
	$cnt:=cs:C1710.JCL_tbl.new().findForeignKey($objParam.parent_tbl_name; ->$aryTblNr; ->$aryForeignKeys)
	For ($i; 1; $cnt)
		$tblName:=Table name:C256($aryTblNr{$i})  //関連テーブル名
		$tbl_prefix:=cs:C1710.JCL_tbl.new().getPrefix_fromStructure($tblName)  //関連テーブルプリフィックス
		
		//プロセス変数定義
		$body:=$body+"//"+$tblName+Char:C90(13)
		$body:=$body+$objParam.frm_prefix+"_frmDefInit_"+$tbl_prefix+Char:C90(13)
		
		// デフォルトの並び順を指定、配列にプッシュしておく
		$body:=$body+"  // デフォルトの並び順を指定、配列にプッシュしておく\n"
		$body:=$body+"JCL_lst_Sort_Append (\"v"+$objParam.frm_prefix+"_lst"+$tbl_prefix
		$body:=$body+"\";->v"+$objParam.frm_prefix+"_lst"+$tbl_prefix+"_HeaderNames"
		$body:=$body+";->v"+$objParam.frm_prefix+"_lst"+$tbl_prefix+"_SortOrders;1;2) //降順"+Char:C90(13)
		
		$body:=$body+"JCL_lst_Sort_Append (\"v"+$objParam.frm_prefix+"_lst"+$tbl_prefix
		$body:=$body+"\";->v"+$objParam.frm_prefix+"_lst"+$tbl_prefix+"_HeaderNames"
		$body:=$body+";->v"+$objParam.frm_prefix+"_lst"+$tbl_prefix+"_SortOrders;2;1) //昇順"+Char:C90(13)
		
		//配列作成　[--FRM_PREFIX]_lst[--TBL_PREFIX]_Make 
		$body:=$body+$objParam.frm_prefix+"_lst"+$tbl_prefix+"_make"+Char:C90(13)
		
		//[--FRM_PREFIX]_SetControlsValues_[--TBL_PREFIX]
		$body:=$body+$objParam.frm_prefix+"_SetControlsValues_"+$tbl_prefix+Char:C90(13)
		$body:=$body+Char:C90(13)
		
	End for 
	
	$0:=$body
	
Function relatedMethods_btnOK()
	//関連テーブルのbtnOKメソッド部分を作成
	//20240515
	//[--FRM_PREFIX]_frmSaveValues_[--TBL_PREFIX]
	
	C_OBJECT:C1216($1; $objParam)
	$objParam:=$1
	C_TEXT:C284($0; $body)
	$body:=""
	C_LONGINT:C283($cnt)
	ARRAY LONGINT:C221($aryTblNr; 0)
	ARRAY TEXT:C222($aryForeignKeys; 0)
	
	$cnt:=cs:C1710.JCL_tbl.new().findForeignKey($objParam.parent_tbl_name; ->$aryTblNr; ->$aryForeignKeys)
	For ($i; 1; $cnt)
		$tblName:=Table name:C256($aryTblNr{$i})  //関連テーブル名
		$tbl_prefix:=cs:C1710.JCL_tbl.new().getPrefix_fromStructure($tblName)  //関連テーブルプリフィックス
		
		//配列要素を保存
		$body:=$body+"//"+$tblName+Char:C90(13)
		$body:=$body+$objParam.frm_prefix+"_frmSaveValues_"+$tbl_prefix+Char:C90(13)
		$body:=$body+Char:C90(13)
		
	End for 
	
	$0:=$body
	
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
	
Function columnDataType()
	//20240428
	//列に設定するデータ型(dataSourceTypeHintに指定する）の文字列を返す
	//https://developer.4d.com/docs/ja/18/FormObjects/propertiesObject/
	
	C_TEXT:C284($1; $fieldType)
	$fieldType:=$1  //フィールド型
	C_TEXT:C284($0; $dataType)
	
	$dataType:=""
	Case of 
		: ($fieldType="Is Alpha Field")
			$dataType:="text"
			
		: ($fieldType="Is Text")
			$dataType:="text"
			
		: ($fieldType="Is Real")
			$dataType:="number"
			
		: ($fieldType="Is Integer")
			$dataType:="integer"
			
		: ($fieldType="Is LongInt")
			$dataType:="integer"
			
		: ($fieldType="Is Date")
			$dataType:="date"
			
		: ($fieldType="Is Time")
			$dataType:="time"
			
		: ($fieldType="Is Boolean")
			$dataType:="boolean"
			
	End case 
	
	$0:=$dataType
	
	