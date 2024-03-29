//%attributes = {}
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
	$objParam.color_text:=JCL_utl_ColorRandom
	
	//テーブルからプリフィックスを取得、
	JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	$sizeOfAry:=Size of array:C274($aryFieldName)
	If ($sizeOfAry>0)
		//JCL_fields_cache
		C_OBJECT:C1216($jcl_fields)
		$jcl_fields:=cs:C1710.JCL_fields.new()
		$jcl_fields.cache_make()
		
	End if 
	C_LONGINT:C283($pos)
	$pos:=Position:C15("_"; $aryFieldName{1})
	$objParam.tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //テーブル名のプリフィックス
	
	//01フォーム作成
	$objParam.frm_name:=$objParam.tbl_prefix+"01_List"  //フォーム名
	$objParam.frm_prefix:=$objParam.tbl_prefix+"01"  //フォーム名のプリフィックス
	$objParam.form_templates:="frm01_v3.txt"
	$objParam.method_templates:="method_templates_list"
	JCL_prj_FG_tblFrm01V4($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
	
	//02フォーム作成
	$objParam.frm_name:=$objParam.tbl_prefix+"02_Input"  //フォーム名
	$objParam.frm_prefix:=$objParam.tbl_prefix+"02"  //フォーム名のプリフィックス
	$objParam.method_templates:="method_templates_form"
	JCL_prj_FG_tblFrm02V4($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
	
	//03フォーム作成
	$objParam.frm_name:=$objParam.tbl_prefix+"03_Input"  //フォーム名
	$objParam.frm_prefix:=$objParam.tbl_prefix+"03"  //フォーム名のプリフィックス
	$objParam.method_templates:="method_templates_form"
	JCL_prj_FG_tblFrm03V4($objParam; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
	
	
End if 
