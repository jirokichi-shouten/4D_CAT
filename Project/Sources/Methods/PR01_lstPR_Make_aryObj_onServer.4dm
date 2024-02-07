//%attributes = {"executedOnServer":true}
//PR01_lstPR_Make_aryObj_onServer
//FG v202209 2024/02/07 17:28:37
//[PASSWORD_RESETS] 一覧表に必要な値をオブジェクト配列に作成　//サーバ上で実行
//カレントセレクションが前提

C_POINTER($1;$outAryPtr) //オブジェクト型配列のポインタ
$outAryPtr:=$1
C_LONGINT($0)
C_LONGINT($numOfRecs;$i)
C_OBJECT($objPR)

//DBデータを取得してオブジェクト配列に追加
$numOfRecs:=Records in selection([PASSWORD_RESETS])
For ($i; 1; $numOfRecs)
	GOTO SELECTED RECORD([PASSWORD_RESETS]; $i)
	
	//オブジェクト型配列に追加
	$objPR:=New object
	
	$objPR.PR_ID:=[PASSWORD_RESETS]PR_ID
	$objPR.PR_US_ID:=[PASSWORD_RESETS]PR_US_ID
	$objPR.PR_EMAIL:=[PASSWORD_RESETS]PR_EMAIL
	$objPR.PR_TOKEN:=[PASSWORD_RESETS]PR_TOKEN
	$objPR.PR_CREATE_AT:=[PASSWORD_RESETS]PR_CREATE_AT
	$objPR.PR_DEL_FLAG:=[PASSWORD_RESETS]PR_DEL_FLAG
	
	//join code here
	
	APPEND TO ARRAY($outAryPtr->; $objPR)
	
End for 

$0:=$numOfRecs
