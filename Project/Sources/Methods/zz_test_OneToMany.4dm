//%attributes = {}
//zz_test_OneToMany
//20240225 wat
//１対多の関係にあるデータ構造を見つけて、外部キー列を特定する。
//
ARRAY LONGINT:C221($aryTblNr; 0)
ARRAY TEXT:C222($aryForeignKeys; 0)

$targetTableName:="USERS"
//20260926 Codex/wat 外部キー検出をJCL_tblクラスに統一
$cnt:=cs:C1710.JCL_tbl.new().findForeignKey($targetTableName; ->$aryTblNr; ->$aryForeignKeys)
For ($i; 1; $cnt)
	//フォーム02を作るときに、外部キーを見つけたら　外部テーブルのリストボックスを自動生成
	
End for 

ALERT:C41($targetTableName+"<-"+String:C10($cnt))
