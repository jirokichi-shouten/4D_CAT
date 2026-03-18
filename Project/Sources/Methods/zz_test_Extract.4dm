//%attributes = {}
//zz_test_Extract
//20260324 wat@tottori
//Extract、タブで切り出せない　\tになっている？

C_TEXT:C284($buf)

$buf:="pr_id\tIs LongInt\t0\t0\t0\tfrom PG Dump file\t4D_CAT"

C_LONGINT:C283($numOfItems)
ARRAY TEXT:C222($aryFieldItems; 0)

$numOfItems:=JCL_str_Extract($buf; Char:C90(Tab:K15:37); ->$aryFieldItems)

ALERT:C41($aryFieldItems{1})

//切り出せてた
