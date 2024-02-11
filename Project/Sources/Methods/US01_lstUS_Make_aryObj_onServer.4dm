//%attributes = {"executedOnServer":true}
//US01_lstUS_Make_aryObj_onServer
//FG v202209 2024/02/11 21:23:57
//[USERS] 一覧表に必要な値をオブジェクト配列に作成　//サーバ上で実行
//カレントセレクションが前提

C_POINTER($1;$outAryPtr) //オブジェクト型配列のポインタ
$outAryPtr:=$1
C_LONGINT($0)
C_LONGINT($numOfRecs;$i)
C_OBJECT($objUS)

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=Records in selection([USERS])
For ($i; 1; $numOfRecs)
	GOTO SELECTED RECORD([USERS]; $i)
	
	//オブジェクト型配列に追加
	$objUS:=New object
	
	$objUS.US_ID:=[USERS]US_ID
	$objUS.US_NAME:=[USERS]US_NAME
	$objUS.US_EMAIL:=[USERS]US_EMAIL
	$objUS.US_EMAIL_VERIFIED_AT:=[USERS]US_EMAIL_VERIFIED_AT
	$objUS.US_PASSWORD:=[USERS]US_PASSWORD
	$objUS.US_REMEMBER_TOKEN:=[USERS]US_REMEMBER_TOKEN
	$objUS.US_CREATE_AT:=[USERS]US_CREATE_AT
	$objUS.US_UPDATE_AT:=[USERS]US_UPDATE_AT
	$objUS.US_DEL_FLAG:=[USERS]US_DEL_FLAG
	
	//join code here
	
	APPEND TO ARRAY($outAryPtr->; $objUS)
	
End for 

$0:=$numOfRecs
