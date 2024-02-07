//%attributes = {"executedOnServer":true}
//PR01_lstPR_Make_onServer
//FG v202209 2024/02/07 20:50:34
//[PASSWORD_RESETS] リストボックス用オブジェクト配列を作成 //サーバ上で実行

C_OBJECT($1;$objSearch)
$objSearch:=$1
C_POINTER($2; $outAryObjPtr)  //オブジェクト型配列のポインタ
$outAryObjPtr:=$2
C_LONGINT($0)
C_LONGINT($i; $numOfRecs)
C_OBJECT($objPR)

READ ONLY([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS]; [PASSWORD_RESETS]PR_DEL_FLAG=$objSearch.del_flag;*)
QUERY([PASSWORD_RESETS])

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=PR01_lstPR_Make_aryObj_onServer($outAryObjPtr)

$0:=$numOfRecs
