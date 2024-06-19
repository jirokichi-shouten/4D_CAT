//%attributes = {}
//KV_LONG_VALUE
//20170206 wat
//引数キーコードの整数値を設定テーブルから取得し返す
//20181107 wat 削除フラグを考慮

C_TEXT:C284($1; $key)
$key:=$1
C_LONGINT:C283($0; $outLongValue)
$outLongValue:=0

READ ONLY:C145([Z_KeyValue:7])
QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_DEL_FLAG:5=0; *)
QUERY:C277([Z_KeyValue:7];  & ; [Z_KeyValue:7]KV_KEY:2=$key)
FIRST RECORD:C50([Z_KeyValue:7])
If (Records in selection:C76([Z_KeyValue:7])>0)
	
	$outLongValue:=[Z_KeyValue:7]KV_LONG_VALUE:4
	
End if 

$0:=$outLongValue
