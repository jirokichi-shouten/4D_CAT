//%attributes = {}
//A01_SetControlsValues
//20240204 wat
//フォームオブジェクトを制御

//件数表示
C_LONGINT:C283($sizeOfAry)
$sizeOfAry:=Size of array:C274(vA01_lstT_nr)
vA01_txtNumOfTables:="作成済みテーブル数："+String:C10($sizeOfAry; "#,###,##0")

C_TEXT:C284($tblName)
$tblName:=JCL_lst_Selected_Str(->vA01_lstT; ->vA01_lstT_name)
$sizeOfAry:=Size of array:C274(vA01_lstFL_Nr)
vA01_varTableName:=$tblName+"(フィールド数："+String:C10($sizeOfAry; "#,###,##0")+")"
//vA01_varNumOfFields:="(フィールド数："+String($sizeOfAry; "#,###,##0")+")"

JCL_btn_SetEnable_byListSelect(->vA01_lstT; ->vA01_btnList)
