//%attributes = {}
//JCL_prj_FormGeneratorV2
//20240207 hisa wat
//フォームを作る//フォームジェネレータ01、一覧用リストボックスのフォーム「xx01_List」を作る

C_TEXT:C284($1; $tblName)  //テーブル名
$tblName:=$1

ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
ARRAY TEXT:C222($aryFieldIndex; 0)

C_TEXT:C284($prefix; $frmName; $tblName)
C_LONGINT:C283($pos)
C_OBJECT:C1216($objFrm)
$objFrm:=New object:C1471

//テーブル名と色
$objFrm.tbl_name:=$tblName
$objFrm.color_text:=JCL_utl_ColorRandom

//ダイアログ情報
$tblName:=$objFrm.tbl_name  //テーブル名
If ($tblName#"")
	//テーブルからプリフィックスを取得、
	JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	$sizeOfAry:=Size of array:C274($aryFieldName)
	If ($sizeOfAry>0)
		JCL_fields_cache
	End if 
	C_LONGINT:C283($pos)
	$pos:=Position:C15("_"; $aryFieldName{1})
	$objFrm.tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //テーブル名のプリフィックス
	
	//01フォーム作成
	$objFrm.frm_name:=$objFrm.tbl_prefix+"01_List"  //フォーム名
	$objFrm.frm_prefix:=$objFrm.tbl_prefix+"01"  //フォーム名のプリフィックス
	JCL_prj_FG_tblFrm01($objFrm; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
	//フォームメソッドを作成
	JCL_prj_FG_tblFrmMethod($objFrm)
	//メソッド群をテンプレートから作成
	$objFrm.method_templates:="method_templates_list"
	JCL_prj_FG_methods($objFrm; ->$aryFieldName; ->$aryFieldType)
	
	//02フォーム作成 20210602
	$objFrm.frm_name:=$objFrm.tbl_prefix+"02_Input"  //フォーム名
	$objFrm.frm_prefix:=$objFrm.tbl_prefix+"02"  //フォーム名のプリフィックス
	$objFrm.method_templates:="method_templates_form"
	JCL_prj_FG_tblFrm02($objFrm; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength)
	//フォームメソッドを作成
	JCL_prj_FG_tblFrmMethod($objFrm)
	//メソッド群をテンプレートから作成
	JCL_prj_FG_methods($objFrm; ->$aryFieldName; ->$aryFieldType)
	
End if 
