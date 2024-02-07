//US_Duplicate
//method_generator 2024/02/07 16:52:29
//USERS レコード複製
//複製

C_LONGINT($1;$US_id)
$US_id:=$1
C_LONGINT($0;$new_US_id)

READ WRITE([USERS])
QUERY([USERS];[USERS]US_DEL_FLAG=0;*)
QUERY([USERS];&;[USERS]US_ID=$US_id)
FIRST RECORD([USERS])

DUPLICATE RECORD([USERS])
$new_US_id:=Sequence number ([USERS])
[USERS]US_ID:=$new_US_id
//[USERS]US_TITLE:=[USERS]US_TITLE+"のコピー"
[USERS]US_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

SAVE RECORD([USERS])

$0:=$new_US_id
