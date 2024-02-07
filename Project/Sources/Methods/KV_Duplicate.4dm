//KV_Duplicate
//method_generator 2024/02/07 20:09:44
//Z_KeyValue レコード複製
//複製

C_LONGINT($1;$KV_id)
$KV_id:=$1
C_LONGINT($0;$new_KV_id)

READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_DEL_FLAG=0;*)
QUERY([Z_KeyValue];&;[Z_KeyValue]KV_ID=$KV_id)
FIRST RECORD([Z_KeyValue])

DUPLICATE RECORD([Z_KeyValue])
$new_KV_id:=Sequence number ([Z_KeyValue])
[Z_KeyValue]KV_ID:=$new_KV_id
//[Z_KeyValue]KV_TITLE:=[Z_KeyValue]KV_TITLE+"のコピー"
//[Z_KeyValue]KV_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

SAVE RECORD([Z_KeyValue])

$0:=$new_KV_id
