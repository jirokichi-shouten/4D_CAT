//KN_Add_byInitValues
//method_generator 2024/02/11 21:23:27
//Z_KeyNValue レコード追加、初期値代入

C_LONGINT($0;$KN_id)

//新規レコード作成
$KN_id:=Sequence number ([Z_KeyNValue])
CREATE RECORD([Z_KeyNValue])

[Z_KeyNValue]KN_ID:=0
[Z_KeyNValue]KN_KEY:=""
[Z_KeyNValue]KN_CODE:=""
[Z_KeyNValue]KN_VALUE:=""
[Z_KeyNValue]KN_LONG_VALUE:=0
[Z_KeyNValue]KN_SORT_ORDER:=0
[Z_KeyNValue]KN_DEL_FLAG:=0

[Z_KeyNValue]KN_ID:=$KN_id

SAVE RECORD([Z_KeyNValue])

$0:=$KN_id
