//%attributes = {"executedOnServer":true}
//KV01_lstKV_Make_onServer
//FG v202209 2024/02/07 17:31:34
//[Z_KeyValue] リストボックス用オブジェクト配列を作成 //サーバ上で実行

C_OBJECT($1;$objSearch)
$objSearch:=$1
C_POINTER($2; $outAryObjPtr)  //オブジェクト型配列のポインタ
$outAryObjPtr:=$2
C_LONGINT($0)
C_LONGINT($i; $numOfRecs)
C_OBJECT($objKV)

READ ONLY([Z_KeyValue])
QUERY([Z_KeyValue]; [Z_KeyValue]KV_DEL_FLAG=$objSearch.del_flag;*)
QUERY([Z_KeyValue])

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=KV01_lstKV_Make_aryObj_onServer($outAryObjPtr)

$0:=$numOfRecs
