//%attributes = {}
//zz_test_JCL_prj_FG_Dlg
//20240414 wat
//色選択ダイアログを実行するため、それは色変更ダイアログを作るため

C_OBJECT:C1216($paramObj)
$paramObj:=New object:C1471
$paramObj.tbl_name:="JUCHUU"

$dlgOK:=JCL_prj_FG_Dlg($paramObj)

ALERT:C41(String:C10($dlgOK))
