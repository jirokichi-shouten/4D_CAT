//%attributes = {}
//zz_test_JCL_dlg_NoYes
//20231230
//JCL_dlg テスト

//驚きのサープライズダイアログ
C_LONGINT:C283($ok)
$ok:=JCL_dlg_Surprise("title"; "2nd"; "oK")

ALERT:C41(String:C10($ok))



C_LONGINT:C283($ok)
$ok:=JCL_dlg_NoYes("title"; "2nd"; "oK"; "ca")

ALERT:C41(String:C10($ok))


