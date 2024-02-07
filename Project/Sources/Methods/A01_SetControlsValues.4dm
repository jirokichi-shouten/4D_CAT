//%attributes = {}
//A01_SetControlsValues
//20240204 wat
//フォームオブジェクトを制御

//件数表示
C_LONGINT:C283($sizeOfAry)
$sizeOfAry:=Size of array:C274(vA01_lstT_nr)
vA01_txtNumOfRecs:="テーブル数："+String:C10($sizeOfAry; "#,###,##0")

JCL_btn_SetEnable_byListSelect(->vA01_lstT; ->vA01_btnList)
