//%attributes = {}
//zz_test_EXECUTE_METHOD
//20240207

C_TEXT:C284($methodName)
C_TEXT:C284($tbl_prefix)

//メソッド実行
$methodName:=$tbl_prefix+"01_List"

C_LONGINT:C283($long)
$long:=JCL_method_isExist("JCL_btn_SetVisible")
ALERT:C41(String:C10($long))


//JCL_method_Execute("JCL_btn_SetVisible")

//$undefined:=Undefined("JCL_btn_SetVisible")  // False
