//PR_Duplicate
//method_generator 2024/02/07 15:04:10
//PASSWORD_RESETS レコード複製
//複製

C_LONGINT($1;$PR_id)
$PR_id:=$1
C_LONGINT($0;$new_PR_id)

READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_DEL_FLAG=0;*)
QUERY([PASSWORD_RESETS];&;[PASSWORD_RESETS]PR_ID=$PR_id)
FIRST RECORD([PASSWORD_RESETS])

DUPLICATE RECORD([PASSWORD_RESETS])
$new_PR_id:=Sequence number ([PASSWORD_RESETS])
[PASSWORD_RESETS]PR_ID:=$new_PR_id
//[PASSWORD_RESETS]PR_TITLE:=[PASSWORD_RESETS]PR_TITLE+"のコピー"
[PASSWORD_RESETS]PR_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)

SAVE RECORD([PASSWORD_RESETS])

$0:=$new_PR_id
