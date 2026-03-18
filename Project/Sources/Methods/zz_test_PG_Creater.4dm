//%attributes = {}
//zz_test_PG_Creater
//20260314 wat@tottori
//PG_Createrテストプログラム

C_OBJECT:C1216($PG)
$PG:=cs:C1710.JCL_Importer_PostgreSQL.new()

$PG.creater()
//20260315 テーブル作成できた。コメントアウトして、データを作成

//$PG.data_loader()
