//%attributes = {"executedOnServer":true}
//KN01_lstKN_Make_aryObj_onServer
//FG v202209 2024/02/07 21:00:49
//[Z_KeyNValue] 一覧表に必要な値をオブジェクト配列に作成　//サーバ上で実行
//カレントセレクションが前提

C_POINTER($1;$outAryPtr) //オブジェクト型配列のポインタ
$outAryPtr:=$1
C_LONGINT($0)
C_LONGINT($numOfRecs;$i)
C_OBJECT($objKN)

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=Records in selection([Z_KeyNValue])
For ($i; 1; $numOfRecs)
	GOTO SELECTED RECORD([Z_KeyNValue]; $i)
	
	//オブジェクト型配列に追加
	$objKN:=New object
	
	$objKN.KN_ID:=[Z_KeyNValue]KN_ID
	$objKN.KN_KEY:=[Z_KeyNValue]KN_KEY
	$objKN.KN_CODE:=[Z_KeyNValue]KN_CODE
	$objKN.KN_VALUE:=[Z_KeyNValue]KN_VALUE
	$objKN.KN_LONG_VALUE:=[Z_KeyNValue]KN_LONG_VALUE
	$objKN.KN_SORT_ORDER:=[Z_KeyNValue]KN_SORT_ORDER
	$objKN.KN_DEL_FLAG:=[Z_KeyNValue]KN_DEL_FLAG
	
	//join code here
	
	APPEND TO ARRAY($outAryPtr->; $objKN)
	
End for 

$0:=$numOfRecs
