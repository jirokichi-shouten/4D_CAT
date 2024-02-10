//%attributes = {}
//JCL_tbl_DelAll
//20171228 wat
//ポインタをもらって、テーブルのレコードを削除
//20231212 hisa wat

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1

READ WRITE:C146($tblPtr->)
//ALL RECORDS($tblPtr->)
//DELETE SELECTION($tblPtr->)

TRUNCATE TABLE:C1051($tblPtr->)
JCL_tbl_SerialNumber_Reset($tblPtr)

READ ONLY:C145($tblPtr->)
