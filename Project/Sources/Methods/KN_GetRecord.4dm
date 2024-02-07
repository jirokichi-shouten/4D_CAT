//KN_GetRecord
//method_generator 2024/02/07 15:04:10
//Z_KeyNValue レコード取得、IDでクエリーしてオブジェクト型で返す

C_LONGINT($1;$KN_id)
$KN_id:=$1
C_Object($2;$objKN)
$objKN:=$2
C_LONGINT($0;$numOfRecs)

READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_DEL_FLAG=0;*)
QUERY([Z_KeyNValue];&;[Z_KeyNValue]KN_ID=$KN_id)
FIRST RECORD([Z_KeyNValue])
$numOfRecs:=records in selection([Z_KeyNValue])
if ($numOfRecs=1)
//レコードをオブジェクト型の変数に格納
$objKN.KN_ID:=[Z_KeyNValue]KN_ID
$objKN.KN_KEY:=[Z_KeyNValue]KN_KEY
$objKN.KN_CODE:=[Z_KeyNValue]KN_CODE
$objKN.KN_VALUE:=[Z_KeyNValue]KN_VALUE
$objKN.KN_LONG_VALUE:=[Z_KeyNValue]KN_LONG_VALUE
$objKN.KN_SORT_ORDER:=[Z_KeyNValue]KN_SORT_ORDER
$objKN.KN_DEL_FLAG:=[Z_KeyNValue]KN_DEL_FLAG

end if

$0:=$numOfRecs
