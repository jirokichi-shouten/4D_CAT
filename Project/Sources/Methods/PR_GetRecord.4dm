//PR_GetRecord
//method_generator 2024/02/07 20:09:44
//PASSWORD_RESETS レコード取得、IDでクエリーしてオブジェクト型で返す

C_LONGINT($1;$PR_id)
$PR_id:=$1
C_Object($2;$objPR)
$objPR:=$2
C_LONGINT($0;$numOfRecs)

READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_DEL_FLAG=0;*)
QUERY([PASSWORD_RESETS];&;[PASSWORD_RESETS]PR_ID=$PR_id)
FIRST RECORD([PASSWORD_RESETS])
$numOfRecs:=records in selection([PASSWORD_RESETS])
if ($numOfRecs=1)
//レコードをオブジェクト型の変数に格納
$objPR.PR_ID:=[PASSWORD_RESETS]PR_ID
$objPR.PR_US_ID:=[PASSWORD_RESETS]PR_US_ID
$objPR.PR_EMAIL:=[PASSWORD_RESETS]PR_EMAIL
$objPR.PR_TOKEN:=[PASSWORD_RESETS]PR_TOKEN
$objPR.PR_CREATE_AT:=[PASSWORD_RESETS]PR_CREATE_AT
$objPR.PR_DEL_FLAG:=[PASSWORD_RESETS]PR_DEL_FLAG

end if

$0:=$numOfRecs