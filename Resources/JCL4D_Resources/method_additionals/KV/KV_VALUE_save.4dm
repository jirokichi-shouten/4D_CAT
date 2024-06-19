//%attributes = {}
//KV_VALUE_save
//20160628 wat
// キーバリューテーブルに値を保存
//usage: KV_VALUE_save(key;value)

C_TEXT:C284($1; $inKey)
$inKey:=$1  //キーコード
C_TEXT:C284($2; $inValue)
$inValue:=$2  //バリュー

//設定テーブルをリードライトモードにしてクエリ
READ WRITE:C146([Z_KeyValue:7])

QUERY:C277([Z_KeyValue:7]; [Z_KeyValue:7]KV_KEY:2=$inKey)
FIRST RECORD:C50([Z_KeyValue:7])

If (Records in selection:C76([Z_KeyValue:7])>0)
	
	//レコードがあれば更新  //更新日時を保存
	[Z_KeyValue:7]KV_VALUE:3:=$inValue
	[Z_KeyValue:7]KV_DEL_FLAG:5:=0  //20181107 wat
	
	SAVE RECORD:C53([Z_KeyValue:7])
	
Else 
	
	//レコードがなければ作る
	KV_Add_byInitValues
	[Z_KeyValue:7]KV_KEY:2:=$inKey
	[Z_KeyValue:7]KV_VALUE:3:=$inValue
	SAVE RECORD:C53([Z_KeyValue:7])
	
End if 

//レコードを解放
UNLOAD RECORD:C212([Z_KeyValue:7])
READ ONLY:C145([Z_KeyValue:7])
