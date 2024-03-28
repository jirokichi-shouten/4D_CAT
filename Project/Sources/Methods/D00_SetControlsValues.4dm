//%attributes = {}
//A01_SetControlsValues
//20240204 wat
//フォームオブジェクトを制御

//件数表示
C_LONGINT:C283($sizeOfAry)
$sizeOfAry:=Size of array:C274(vD00_lstT_nr)
vD00_txtNumOfTables:="作成済みテーブル数："+String:C10($sizeOfAry; "#,###,##0")

C_TEXT:C284($tblName)
$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
$sizeOfAry:=Size of array:C274(vD00_lstFL_Nr)
vD00_varTableName:=$tblName+"(フィールド数："+String:C10($sizeOfAry; "#,###,##0")+")"
//vD00_varNumOfFields:="(フィールド数："+String($sizeOfAry; "#,###,##0")+")"

JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnList)
JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnFom)
JCL_btn_SetEnable_byListSelect(->vD00_lstT; ->vD00_btnDelete)
