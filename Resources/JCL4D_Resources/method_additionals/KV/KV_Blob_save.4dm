//%attributes = {}
//KV_Blob_save
//20221224 wat
//キーバリューテーブルにBLOBを保存
//このため、BLOBフィールドを追加。印刷設定を保持するため。
//usage: KV_Blob_save(key;value)

C_TEXT:C284($1; $inKey)
$inKey:=$1  //キーコード
C_BLOB:C604($2; $inValue)
$inValue:=$2  //バリュー

//設定テーブルをリードライトモードにしてクエリ
READ WRITE:C146([Z_KeyValue:7])
QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_KEY:2=$inKey)

If (Records in selection:C76([Z_KeyValue:7])>0)
	//レコードがあれば更新  //更新日時を保存
	[Z_KeyValue:7]KV_BLOB:6:=$inValue
	[Z_KeyValue:7]KV_DEL_FLAG:5:=0  //20181107 wat
	
	SAVE RECORD:C53([Z_KeyValue:7])
	
Else 
	//レコードがなければ作る
	KV_Add_byInitValues
	[Z_KeyValue:7]KV_KEY:2:=$inKey
	[Z_KeyValue:7]KV_BLOB:6:=$inValue
	SAVE RECORD:C53([Z_KeyValue:7])
	
End if 

//レコードを解放
UNLOAD RECORD:C212([Z_KeyValue:7])
READ ONLY:C145([Z_KeyValue:7])
