//KV_Blob_save
//20221224 wat
//キーバリューテーブルにBLOBを保存
//このため、BLOBフィールドを追加。印刷設定を保持するため。
//usage: KV_Blob_save(key;value)

C_TEXT($1; $inKey)
$inKey:=$1  //キーコード
C_BLOB($2; $inValue)
$inValue:=$2  //バリュー

//設定テーブルをリードライトモードにしてクエリ
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue]; [Z_KeyValue]KV_KEY=$inKey)

If (Records in selection([Z_KeyValue])>0)
	//レコードがあれば更新  //更新日時を保存
	[Z_KeyValue]KV_BLOB:=$inValue
	[Z_KeyValue]KV_DEL_FLAG:=0  //20181107 wat
	
	SAVE RECORD([Z_KeyValue])
	
Else 
	//レコードがなければ作る
	KV_Add_byInitValues
	[Z_KeyValue]KV_KEY:=$inKey
	[Z_KeyValue]KV_BLOB:=$inValue
	SAVE RECORD([Z_KeyValue])
	
End if 

//レコードを解放
UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])
