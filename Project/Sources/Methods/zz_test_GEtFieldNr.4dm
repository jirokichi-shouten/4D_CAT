//%attributes = {}
//zz_test_GEtFieldNr
//20240811

C_TEXT:C284($field_name; $table_name)
$table_name:="Z_KeyNValue"
$field_name:="kn_sort_order"

$nr:=JCL_lst_ColNr_byColName("vKN01_lstKN"; "vKN01_lstKN_SORT_ORDER")

ALERT:C41(String:C10($nr))

