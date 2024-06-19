//%attributes = {}
//KV_LONG_VALUE_save
//20170206 wat
//引数キーコードの整数値を設定テーブルに保存

C_TEXT:C284($1; $inKey)
$inKey:=$1  //キーコード
C_LONGINT:C283($2; $inLongValue)
$inLongValue:=$2

//設定テーブルをリードライトモードにしてクエリ
READ WRITE:C146([Z_KeyValue:7])

QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_KEY:2=$inKey)
FIRST RECORD:C50([Z_KeyValue:7])
If (Records in selection:C76([Z_KeyValue:7])>0)
	
	//レコードがあれば更新  //更新日時を保存
	[Z_KeyValue:7]KV_LONG_VALUE:4:=$inLongValue
	SAVE RECORD:C53([Z_KeyValue:7])
	
Else 
	
	//レコードがなければ作る
	KV_Add_byInitValues
	[Z_KeyValue:7]KV_KEY:2:=$inKey
	[Z_KeyValue:7]KV_LONG_VALUE:4:=$inLongValue
	SAVE RECORD:C53([Z_KeyValue:7])
	
End if 

//レコードを解放
UNLOAD RECORD:C212([Z_KeyValue:7])
READ ONLY:C145([Z_KeyValue:7])
