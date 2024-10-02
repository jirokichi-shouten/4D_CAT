//KV_Blob_get
//20221224 wat
//BLOBを得る

C_TEXT($1; $key_code)
$key_code:=$1
C_BLOB($0; $outValue)

READ ONLY([Z_KeyValue])
QUERY([Z_KeyValue]; [Z_KeyValue]KV_KEY=$key_code)

If (Records in selection([Z_KeyValue])>0)
	$outValue:=[Z_KeyValue]KV_BLOB
	
End if 

$0:=$outValue
