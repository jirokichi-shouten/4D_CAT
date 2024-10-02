//KV_LONG_VALUE
//20170206 wat
//引数キーコードの整数値を設定テーブルから取得し返す
//20181107 wat 削除フラグを考慮

C_TEXT($1; $key)
$key:=$1
C_LONGINT($0; $outLongValue)
$outLongValue:=0

READ ONLY([Z_KeyValue])
QUERY([Z_KeyValue]; [Z_KeyValue]KV_DEL_FLAG=0; *)
QUERY([Z_KeyValue];  & ; [Z_KeyValue]KV_KEY=$key)
FIRST RECORD([Z_KeyValue])
If (Records in selection([Z_KeyValue])>0)
	
	$outLongValue:=[Z_KeyValue]KV_LONG_VALUE
	
End if 

$0:=$outLongValue
