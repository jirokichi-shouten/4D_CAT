//US_GetRecord
//method_generator 2024/02/07 20:09:44
//USERS レコード取得、IDでクエリーしてオブジェクト型で返す

C_LONGINT($1;$US_id)
$US_id:=$1
C_Object($2;$objUS)
$objUS:=$2
C_LONGINT($0;$numOfRecs)

READ WRITE([USERS])
QUERY([USERS];[USERS]US_DEL_FLAG=0;*)
QUERY([USERS];&;[USERS]US_ID=$US_id)
FIRST RECORD([USERS])
$numOfRecs:=records in selection([USERS])
if ($numOfRecs=1)
//レコードをオブジェクト型の変数に格納
$objUS.US_ID:=[USERS]US_ID
$objUS.US_NAME:=[USERS]US_NAME
$objUS.US_EMAIL:=[USERS]US_EMAIL
$objUS.US_EMAIL_VERIFIED_AT:=[USERS]US_EMAIL_VERIFIED_AT
$objUS.US_PASSWORD:=[USERS]US_PASSWORD
$objUS.US_REMEMBER_TOKEN:=[USERS]US_REMEMBER_TOKEN
$objUS.US_CREATE_AT:=[USERS]US_CREATE_AT
$objUS.US_UPDATE_AT:=[USERS]US_UPDATE_AT
$objUS.US_DEL_FLAG:=[USERS]US_DEL_FLAG

end if

$0:=$numOfRecs