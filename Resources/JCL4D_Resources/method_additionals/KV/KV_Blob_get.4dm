//%attributes = {}
//KV_Blob_get
//20221224 wat
//BLOBを得る

C_TEXT:C284($1; $key_code)
$key_code:=$1
C_BLOB:C604($0; $outValue)

READ ONLY:C145([Z_KeyValue:7])
QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_KEY:2=$key_code)

If (Records in selection:C76([Z_KeyValue:7])>0)
	$outValue:=[Z_KeyValue:7]KV_BLOB:6
	
End if 


$0:=$outValue
