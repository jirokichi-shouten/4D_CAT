//KV_Add_byInitValues
//method_generator 2024/02/07 20:09:44
//Z_KeyValue レコード追加、初期値代入

C_LONGINT($0;$KV_id)

//新規レコード作成
$KV_id:=Sequence number ([Z_KeyValue])
CREATE RECORD([Z_KeyValue])

[Z_KeyValue]KV_ID:=0
[Z_KeyValue]KV_KEY:=""
[Z_KeyValue]KV_VALUE:=""
[Z_KeyValue]KV_LONG_VALUE:=0
[Z_KeyValue]KV_DEL_FLAG:=0

[Z_KeyValue]KV_ID:=$KV_id

SAVE RECORD([Z_KeyValue])

$0:=$KV_id
