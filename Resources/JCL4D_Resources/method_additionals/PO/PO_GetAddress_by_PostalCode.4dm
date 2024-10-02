//PO_GetAddress_by_PostalCode
//20090506 wat
//郵便番号から住所を得る、ただし町域名まで

C_TEXT($1; $postalCodeStr)
$postalCodeStr:=$1  //引数で郵便番号をもらう
C_TEXT($0; $addressStr)
$addressStr:=""

// 郵便番号（7桁）からハイフン「-」をトル
$postalCodeStr:=Replace string($postalCodeStr; "-"; "")  //

//郵便番号テーブルをクエリ
READ ONLY([Z_PostalCode])
QUERY([Z_PostalCode]; [Z_PostalCode]PO_CODE=$postalCodeStr+"@")
$numOFRecs:=Records in selection([Z_PostalCode])

If ($numOFRecs>=1)
	//該当する郵便番号があった場合
	$addressStr:=$addressStr+[Z_PostalCode]PO_PREFECTURE
	$addressStr:=$addressStr+[Z_PostalCode]PO_CITY
	$addressStr:=$addressStr+[Z_PostalCode]PO_TOWN
	
	$addressStr:=Replace string($addressStr; "以下に掲載がない場合"; "")  //0000の場合 
	
End if 

$0:=$addressStr
