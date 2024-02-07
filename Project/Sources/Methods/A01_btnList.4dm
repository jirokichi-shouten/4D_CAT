//%attributes = {}
//A01_btnList
//20240204 wat
//テーブル一覧で選択されているテーブルの一覧表ウインドウを表示

C_TEXT:C284($tblName)
$tblName:=JCL_lst_Selected_Str(->vA01_lstT; ->vA01_lstT_name)

ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
ARRAY TEXT:C222($aryFieldIndex; 0)
C_TEXT:C284($fblName)

C_TEXT:C284($tbl_prefix)
//テーブルからプリフィックスを取得、
JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
$pos:=Position:C15("_"; $aryFieldName{1})
$tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //フィールド名のプリフィックス

//$tbl_prefix:=JCL_tbl_Prefix(->$aryFieldName)

//メソッド実行
$methodName:=$tbl_prefix+"01_List"
EXECUTE METHOD:C1007($methodName)
