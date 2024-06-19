//%attributes = {}
//KV_VALUE
//20160628 wat ike
//引数キーコードの値を設定テーブルから取得し返す
//$1:キーコード
//$0:設定値
//20080520　矢部　新規作成
//20100803 wat rename

C_TEXT:C284($1; $key)
$key:=$1
C_TEXT:C284($0; $value)
$value:=""

READ ONLY:C145([Z_KeyValue:7])
QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_KEY:2=$key)
FIRST RECORD:C50([Z_KeyValue:7])
If (Records in selection:C76([Z_KeyValue:7])>0)
	
	$value:=[Z_KeyValue:7]KV_VALUE:3
	
End if 

$0:=$value
