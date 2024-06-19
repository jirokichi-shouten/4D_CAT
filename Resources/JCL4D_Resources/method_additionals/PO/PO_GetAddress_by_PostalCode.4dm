//%attributes = {}
//PO_GetAddress_by_PostalCode
//20090506 wat
//郵便番号から住所を得る、ただし町域名まで

C_TEXT:C284($1; $postalCodeStr)
$postalCodeStr:=$1  //引数で郵便番号をもらう
C_TEXT:C284($0; $addressStr)
$addressStr:=""

// 郵便番号（7桁）からハイフン「-」をトル
$postalCodeStr:=Replace string:C233($postalCodeStr; "-"; "")  //

//郵便番号テーブルをクエリ
READ ONLY:C145([Z_PostalCode:8])
QUERY:C277([Z_PostalCode:8]; [Z_PostalCode:8]PO_CODE:2=$postalCodeStr+"@")
$numOFRecs:=Records in selection:C76([Z_PostalCode:8])

If ($numOFRecs>=1)
	//該当する郵便番号があった場合
	$addressStr:=$addressStr+[Z_PostalCode:8]PO_PREFECTURE:3
	$addressStr:=$addressStr+[Z_PostalCode:8]PO_CITY:4
	$addressStr:=$addressStr+[Z_PostalCode:8]PO_TOWN:5
	
	$addressStr:=Replace string:C233($addressStr; "以下に掲載がない場合"; "")  //0000の場合 
	
End if 

$0:=$addressStr
