//%attributes = {}
//zz_test_JCL_4D_Error
//20240128 wat

C_TEXT:C284($err_text)

//20261002 Codex/wat CAT側エラー処理のJCLERR_改名に追随
$err_text:=JCLERR_4D_Error(1301; "error_codes_sql.txt")
$err_text:=JCLERR_4D_Error(-1; "error_codes.txt")

ALERT:C41($err_text)
