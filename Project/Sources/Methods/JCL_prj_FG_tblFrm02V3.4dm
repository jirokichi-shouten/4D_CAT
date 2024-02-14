//%attributes = {}
//JCL_prj_FG_tblFrm02V3
//20240213 wat
//JCL_prj_FG_tblFrm02
//20210603 wat
//JCL_prj_FG_tblFrm01
//20210330 ike wat
//テーブルフォーム作成
//20210608 wat 引数をオブジェクト型に変更

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

//ファイルの内容を読み込んで　パース
$file:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/frm02_v3.txt")
$text:=$file.getText()
$objFrm:=JSON Parse:C1218($text)

//タイトルバック（色付き）
$new_obj_name:="v"+$objParam.frm_prefix+"_rectTitle"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="rectangle"
$objFrm.pages[1].objects[$new_obj_name].top:=0
$objFrm.pages[1].objects[$new_obj_name].left:=0
$objFrm.pages[1].objects[$new_obj_name].width:=987
$objFrm.pages[1].objects[$new_obj_name].height:=55
$objFrm.pages[1].objects[$new_obj_name].fill:=$objParam.color_text
$objFrm.pages[1].objects[$new_obj_name].stroke:=$objParam.color_text

//フォームのタイトル文字列
$new_obj_name:="v"+$objParam.frm_prefix+"_varTitle"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="input"
$objFrm.pages[1].objects[$new_obj_name].top:=16
$objFrm.pages[1].objects[$new_obj_name].left:=26
$objFrm.pages[1].objects[$new_obj_name].width:=288
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].stroke:=26
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic16"
$objFrm.pages[1].objects[$new_obj_name].fontWeight:="bold"
$objFrm.pages[1].objects[$new_obj_name].focusable:=False:C215
$objFrm.pages[1].objects[$new_obj_name].fill:="transparent"
$objFrm.pages[1].objects[$new_obj_name].borderStyle:="none"
$objFrm.pages[1].objects[$new_obj_name].enterable:=False:C215
$objFrm.pages[1].objects[$new_obj_name].contextMenu:="none"
$objFrm.pages[1].objects[$new_obj_name].dragging:="none"
$objFrm.pages[1].objects[$new_obj_name].dropping:="none"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onDataChange")

//フォームのOKボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnOK"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="button"
$objFrm.pages[1].objects[$new_obj_name].top:=16
$objFrm.pages[1].objects[$new_obj_name].left:=873
$objFrm.pages[1].objects[$new_obj_name].width:=94
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].text:="OK"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
JCL_prj_FG_tblObjMethod($objParam; "_btnOK")  //オブジェクトメソッドを作成

//フォームのCancelボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnCancel"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="button"
$objFrm.pages[1].objects[$new_obj_name].top:=16
$objFrm.pages[1].objects[$new_obj_name].left:=759
$objFrm.pages[1].objects[$new_obj_name].width:=94
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].action:="cancel"
$objFrm.pages[1].objects[$new_obj_name].shortcutKey:="[Esc]"
$objFrm.pages[1].objects[$new_obj_name].text:="キャンセル"
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].focusable:=False:C215
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
//オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod($objParam; "_btnCancel")

//フォームのDeleteボタン
$new_obj_name:="v"+$objParam.frm_prefix+"_btnDelete"
$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
$objFrm.pages[1].objects[$new_obj_name].type:="button"
$objFrm.pages[1].objects[$new_obj_name].top:=16
$objFrm.pages[1].objects[$new_obj_name].left:=645
$objFrm.pages[1].objects[$new_obj_name].width:=94
$objFrm.pages[1].objects[$new_obj_name].height:=26
$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
$objFrm.pages[1].objects[$new_obj_name].method:="ObjectMethods/"+$new_obj_name+".4dm"
$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
$objFrm.pages[1].objects[$new_obj_name].text:="削除"
$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onClick")
JCL_prj_FG_tblObjMethod($objParam; "_btnDelete")  //オブジェクトメソッドを作成

//フィールド用の文字列を作成、複数フィールドを作成
C_LONGINT:C283($i; $sizeOfAry)
C_OBJECT:C1216($objFldPos)
$objFldPos:=New object:C1471
C_TEXT:C284($label)
C_LONGINT:C283($fldWidth)
$objFldPos.top:=90
$objFldPos.left:=110
$objFldPos.label_left:=10
$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
For ($i; 1; $sizeOfAry)
	//フィールドラベルを取得
	$label:=JCL_fields_Label($aryFieldNamePtr->{$i})
	If ($label="")
		//ラベルが取得できなかったらフィールド名を使う
		$label:=$aryFieldNamePtr->{$i}
		
	End if 
	//フィールド位置
	$objFldPos:=JCL_prj_fg_fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
	
	//フィールドラベル
	$new_obj_name:="v"+$objParam.frm_prefix+"_lbl"+$aryFieldNamePtr->{$i}
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="text"
	$objFrm.pages[1].objects[$new_obj_name].top:=$objFldPos.top
	$objFrm.pages[1].objects[$new_obj_name].left:=$objFldPos.label_left
	$objFrm.pages[1].objects[$new_obj_name].width:=94
	$objFrm.pages[1].objects[$new_obj_name].height:=16
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].text:=$label
	
	//フィールド
	$fldWidth:=Num:C11(JCL_prj_fg_fldWidth($aryFieldTypePtr->{$i}; $aryFieldLengthPtr->{$i}))
	$new_obj_name:="v"+$objParam.frm_prefix+"_var"+$aryFieldNamePtr->{$i}
	$objFrm.pages[1].objects[$new_obj_name]:=New object:C1471
	$objFrm.pages[1].objects[$new_obj_name].type:="input"
	$objFrm.pages[1].objects[$new_obj_name].top:=$objFldPos.top
	$objFrm.pages[1].objects[$new_obj_name].left:=$objFldPos.left
	$objFrm.pages[1].objects[$new_obj_name].width:=$fldWidth
	$objFrm.pages[1].objects[$new_obj_name].height:=16
	$objFrm.pages[1].objects[$new_obj_name].dataSource:=$new_obj_name
	$objFrm.pages[1].objects[$new_obj_name].class:="JCL_YuGothic12"
	$objFrm.pages[1].objects[$new_obj_name].focusable:=True:C214
	$objFrm.pages[1].objects[$new_obj_name].enterable:=True:C214
	$objFrm.pages[1].objects[$new_obj_name].borderStyle:="sunken"
	$objFrm.pages[1].objects[$new_obj_name].dropping:="custom"
	$objFrm.pages[1].objects[$new_obj_name].events:=New collection:C1472("onDataChange")
	
End for 

C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)
$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$file:=File:C1566("/SOURCES/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name+"/form.4DForm")
$bool:=$file.create()

//ファイルに書き出す
$file.setText(JSON Stringify:C1217($objFrm; *))
