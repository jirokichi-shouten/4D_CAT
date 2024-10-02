//KV_VALUE
//20160628 wat ike
//引数キーコードの値を設定テーブルから取得し返す
//$1:キーコード
//$0:設定値
//20080520　矢部　新規作成
//20100803 wat rename

C_TEXT($1; $key)
$key:=$1
C_TEXT($0; $value)
$value:=""

READ ONLY([Z_KeyValue])
QUERY([Z_KeyValue]; [Z_KeyValue]KV_KEY=$key)
FIRST RECORD([Z_KeyValue])
If (Records in selection([Z_KeyValue])>0)
	
	$value:=[Z_KeyValue]KV_VALUE
	
End if 

$0:=$value
