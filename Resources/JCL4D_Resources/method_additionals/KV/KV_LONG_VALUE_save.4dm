//KV_LONG_VALUE_save
//20170206 wat
//引数キーコードの整数値を設定テーブルに保存

C_TEXT($1; $inKey)
$inKey:=$1  //キーコード
C_LONGINT($2; $inLongValue)
$inLongValue:=$2

//設定テーブルをリードライトモードにしてクエリ
READ WRITE([Z_KeyValue])

QUERY([Z_KeyValue]; [Z_KeyValue]KV_KEY=$inKey)
FIRST RECORD([Z_KeyValue])
If (Records in selection([Z_KeyValue])>0)
	
	//レコードがあれば更新  //更新日時を保存
	[Z_KeyValue]KV_LONG_VALUE:=$inLongValue
	SAVE RECORD([Z_KeyValue])
	
Else 
	
	//レコードがなければ作る
	KV_Add_byInitValues
	[Z_KeyValue]KV_KEY:=$inKey
	[Z_KeyValue]KV_LONG_VALUE:=$inLongValue
	SAVE RECORD([Z_KeyValue])
	
End if 

//レコードを解放
UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])
