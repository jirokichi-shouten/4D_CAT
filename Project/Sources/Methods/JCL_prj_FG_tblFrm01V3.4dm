//%attributes = {}
//JCL_prj_FG_tblFrm01V3
//JCL_prj_FG_tblFrm01
//20240211 yabe wat
//テーブルフォーム作成

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_POINTER:C301($2; $aryFieldNamePtr)
$aryFieldNamePtr:=$2
C_POINTER:C301($3; $aryFieldTypePtr)
$aryFieldTypePtr:=$3
C_POINTER:C301($4; $aryFieldLengthPtr)
$aryFieldLengthPtr:=$4
C_TEXT:C284($folderPath; $filePath)
C_TEXT:C284($body)
C_TEXT:C284($title_body; $btn_body)
C_TEXT:C284($lst_body)

C_OBJECT:C1216($file2)
$file:=New object:C1471
C_OBJECT:C1216($objFrm)
$objFrm:=New object:C1471

//テンプレートファイルの内容を読み込んで　解析
$file:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/frm01_v3.txt")
$text:=$file.getText()
$objFrm:=JSON Parse:C1218($text)

//タイトルバック（色付き）
$new_obj_name:="v"+$objParam.frm_prefix+"_rectTitle"
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

//フォームの件数文字列
$new_obj_name:="v"+$objParam.frm_prefix+"_varNumOfRecs"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="input"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=74
$objFrm.pages[1].objects[$new_obj_name].left:=914
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

//フォームのAddボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnAdd"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="pictureButton"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=68
$objFrm.pages[1].objects[$new_obj_name].left:=20
$objFrm.pages[1].objects[$new_obj_name].width:=26
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].rowCount:=4
$objFrm.pages[1].objects[$new_obj_name].picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
$objFrm.pages[1].objects[$new_obj_name].switchBackWhenReleased:=True:C214
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnAdd")

//フォームのModボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnMod"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="pictureButton"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=68
$objFrm.pages[1].objects[$new_obj_name].left:=68
$objFrm.pages[1].objects[$new_obj_name].width:=26
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].rowCount:=4
$objFrm.pages[1].objects[$new_obj_name].picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_pencil_w.png"
$objFrm.pages[1].objects[$new_obj_name].switchBackWhenReleased:=True:C214
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnMod")

//フォームのDelボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnDel"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="pictureButton"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=68
$objFrm.pages[1].objects[$new_obj_name].left:=162
$objFrm.pages[1].objects[$new_obj_name].width:=26
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].rowCount:=4
$objFrm.pages[1].objects[$new_obj_name].picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
$objFrm.pages[1].objects[$new_obj_name].switchBackWhenReleased:=True:C214
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnDel")

//フォームのCloseボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnClose"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="button"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=16
$objFrm.pages[1].objects[$new_obj_name].left:=980
$objFrm.pages[1].objects[$new_obj_name].width:=42
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].action:="cancel"
$objFrm.pages[1].objects[$new_obj_name].shortcutKey:="w"
$objFrm.pages[1].objects[$new_obj_name].shortcutAccel:=True:C214
$objFrm.pages[1].objects[$new_obj_name].text:="X"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnClose")

//フォームのExportボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnExport"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="pictureButton"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=68
$objFrm.pages[1].objects[$new_obj_name].left:=880
$objFrm.pages[1].objects[$new_obj_name].width:=26
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].rowCount:=4
$objFrm.pages[1].objects[$new_obj_name].picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_arrow_down.png"
$objFrm.pages[1].objects[$new_obj_name].switchBackWhenReleased:=True:C214
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnExport")

//リストボックス用の文字列を作成、リストボックス部を置き換え
$new_obj_name:="v"+$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="listbox"
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].top:=94
$objFrm.pages[1].objects[$new_obj_name].left:=20
$objFrm.pages[1].objects[$new_obj_name].width:=1002
$objFrm.pages[1].objects[$new_obj_name].height:=472
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
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_lst"+$objParam.tbl_prefix)

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


C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)
$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/form.4DForm")
$bool:=$file.create()

//ファイルに書き出す
$file.setText(JSON Stringify:C1217($objFrm; *))
