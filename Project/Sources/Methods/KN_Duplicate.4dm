//KN_Duplicate
//method_generator 2024/02/11 21:23:27
//Z_KeyNValue レコード複製
//複製

C_LONGINT($1;$KN_id)
$KN_id:=$1
C_LONGINT($0;$new_KN_id)

READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_DEL_FLAG=0;*)
QUERY([Z_KeyNValue];&;[Z_KeyNValue]KN_ID=$KN_id)
FIRST RECORD([Z_KeyNValue])

DUPLICATE RECORD([Z_KeyNValue])
$new_KN_id:=Sequence number ([Z_KeyNValue])
[Z_KeyNValue]KN_ID:=$new_KN_id
//[Z_KeyNValue]KN_TITLE:=[Z_KeyNValue]KN_TITLE+"のコピー"
//[Z_KeyNValue]KN_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

SAVE RECORD([Z_KeyNValue])

$0:=$new_KN_id
