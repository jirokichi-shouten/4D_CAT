//%attributes = {"executedOnServer":true}
//KN01_lstKN_Make_onServer
//FG v202209 2024/02/07 21:00:49
//[Z_KeyNValue] リストボックス用オブジェクト配列を作成 //サーバ上で実行

C_OBJECT($1;$objSearch)
$objSearch:=$1
C_POINTER($2; $outAryObjPtr)  //オブジェクト型配列のポインタ
$outAryObjPtr:=$2
C_LONGINT($0)
C_LONGINT($i; $numOfRecs)
C_OBJECT($objKN)

READ ONLY([Z_KeyNValue])
QUERY([Z_KeyNValue]; [Z_KeyNValue]KN_DEL_FLAG=$objSearch.del_flag;*)
QUERY([Z_KeyNValue])

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=KN01_lstKN_Make_aryObj_onServer($outAryObjPtr)

$0:=$numOfRecs
