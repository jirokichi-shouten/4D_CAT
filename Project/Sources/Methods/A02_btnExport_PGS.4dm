//%attributes = {}
//A02_btnExport_PGS
//20261001 wat
//Export test

C_TEXT:C284($name)
$name:="test_"

JCL_lst_Export_pgs4(->vA02_lstTB; ->$name; 10)

