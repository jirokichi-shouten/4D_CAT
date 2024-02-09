//%attributes = {"executedOnServer":true}
//KV01_lstKV_Make_aryObj_onServer
//FG v202209 2024/02/09 18:05:58
//[Z_KeyValue] 一覧表に必要な値をオブジェクト配列に作成　//サーバ上で実行
//カレントセレクションが前提

C_POINTER($1;$outAryPtr) //オブジェクト型配列のポインタ
$outAryPtr:=$1
C_LONGINT($0)
C_LONGINT($numOfRecs;$i)
C_OBJECT($objKV)

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=Records in selection([Z_KeyValue])
For ($i; 1; $numOfRecs)
	GOTO SELECTED RECORD([Z_KeyValue]; $i)
	
	//オブジェクト型配列に追加
	$objKV:=New object
	
	$objKV.KV_ID:=[Z_KeyValue]KV_ID
	$objKV.KV_KEY:=[Z_KeyValue]KV_KEY
	$objKV.KV_VALUE:=[Z_KeyValue]KV_VALUE
	$objKV.KV_LONG_VALUE:=[Z_KeyValue]KV_LONG_VALUE
	$objKV.KV_DEL_FLAG:=[Z_KeyValue]KV_DEL_FLAG
	
	//join code here
	
	APPEND TO ARRAY($outAryPtr->; $objKV)
	
End for 

$0:=$numOfRecs
