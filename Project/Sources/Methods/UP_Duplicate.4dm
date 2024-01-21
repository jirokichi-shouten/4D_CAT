//UP_Duplicate
//method_generator 2024/01/21 18:15:37
//UM_PAY レコード複製
//複製

C_LONGINT($1;$UP_id)
$UP_id:=$1
C_LONGINT($0;$new_UP_id)

READ WRITE([UM_PAY])
QUERY([UM_PAY];[UM_PAY]UP_DEL_FLAG=0;*)
QUERY([UM_PAY];&;[UM_PAY]UP_ID=$UP_id)
FIRST RECORD([UM_PAY])

DUPLICATE RECORD([UM_PAY])
$new_UP_id:=Sequence number ([UM_PAY])
[UM_PAY]UP_ID:=$new_UP_id
//[UM_PAY]UP_TITLE:=[UM_PAY]UP_TITLE+"のコピー"
[UM_PAY]UP_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

SAVE RECORD([UM_PAY])

$0:=$new_UP_id
