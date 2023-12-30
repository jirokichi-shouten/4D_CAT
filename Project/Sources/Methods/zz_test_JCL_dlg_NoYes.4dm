//%attributes = {}
//zz_test_JCL_dlg_NoYes
//20231230
//JCL_dlg テスト

C_LONGINT:C283($ok)

//確認用yes/noダイアログ
//JCL_dlg_YesNo("title"; "2nd"; "oK"; "cancelll")


//インフォームダイアログ、OKボタンしかない
//$ok:=JCL_dlg_Inform("title"; "2nd"; "oK")


////驚きのサープライズダイアログ
//$ok:=JCL_dlg_Surprise("title"; "2nd"; "oK")


////デフォルトがキャンセルの確認ダイアログ
//$ok:=JCL_dlg_NoYes("title"; "2nd"; "oK"; "ca")


//入力フィールドが一個のダイアログ
C_TEXT:C284($str)
//JCL_dlg_InputOne("title"; "2nd"; "oK"; "ca"; ->$str)



//インフォームダイアログ、書き出しの後で使う
C_TEXT:C284($path)
$path:=System folder:C487(Desktop:K41:16)
//$ok:=JCL_dlg_Inform_ShowOnDisk("title"; "2nd"; "oK"; $path)

ALERT:C41(String:C10($ok)+"["+$str+"]")

