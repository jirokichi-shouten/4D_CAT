//%attributes = {"executedOnServer":true}
//US01_lstUS_Make_onServer
//FG v202209 2024/02/09 18:06:20
//[USERS] リストボックス用オブジェクト配列を作成 //サーバ上で実行

C_OBJECT($1;$objSearch)
$objSearch:=$1
C_POINTER($2; $outAryObjPtr)  //オブジェクト型配列のポインタ
$outAryObjPtr:=$2
C_LONGINT($0)
C_LONGINT($i; $numOfRecs)
C_OBJECT($objUS)

READ ONLY([USERS])
QUERY([USERS]; [USERS]US_DEL_FLAG=$objSearch.del_flag;*)
QUERY([USERS])

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=US01_lstUS_Make_aryObj_onServer($outAryObjPtr)

$0:=$numOfRecs
