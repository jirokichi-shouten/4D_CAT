//PR_Add_byInitValues
//method_generator 2024/02/09 17:54:46
//PASSWORD_RESETS レコード追加、初期値代入

C_LONGINT($0;$PR_id)

//新規レコード作成
$PR_id:=Sequence number ([PASSWORD_RESETS])
CREATE RECORD([PASSWORD_RESETS])

[PASSWORD_RESETS]PR_ID:=0
[PASSWORD_RESETS]PR_US_ID:=0
[PASSWORD_RESETS]PR_EMAIL:=""
[PASSWORD_RESETS]PR_TOKEN:=""
[PASSWORD_RESETS]PR_CREATE_AT:=""
[PASSWORD_RESETS]PR_DEL_FLAG:=0

[PASSWORD_RESETS]PR_ID:=$PR_id

SAVE RECORD([PASSWORD_RESETS])

$0:=$PR_id
