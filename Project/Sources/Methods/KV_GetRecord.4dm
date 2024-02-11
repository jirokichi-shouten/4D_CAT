//KV_GetRecord
//method_generator 2024/02/11 21:23:27
//Z_KeyValue レコード取得、IDでクエリーしてオブジェクト型で返す

C_LONGINT($1;$KV_id)
$KV_id:=$1
C_Object($2;$objKV)
$objKV:=$2
C_LONGINT($0;$numOfRecs)

READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_DEL_FLAG=0;*)
QUERY([Z_KeyValue];&;[Z_KeyValue]KV_ID=$KV_id)
FIRST RECORD([Z_KeyValue])
$numOfRecs:=records in selection([Z_KeyValue])
if ($numOfRecs=1)
//レコードをオブジェクト型の変数に格納
$objKV.KV_ID:=[Z_KeyValue]KV_ID
$objKV.KV_KEY:=[Z_KeyValue]KV_KEY
$objKV.KV_VALUE:=[Z_KeyValue]KV_VALUE
$objKV.KV_LONG_VALUE:=[Z_KeyValue]KV_LONG_VALUE
$objKV.KV_DEL_FLAG:=[Z_KeyValue]KV_DEL_FLAG

end if

$0:=$numOfRecs
