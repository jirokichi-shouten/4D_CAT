//UP_Add_byInitValues
//method_generator 2024/01/21 18:15:37
//UM_PAY レコード追加、初期値代入

C_LONGINT($0;$UP_id)

//新規レコード作成
$UP_id:=Sequence number ([UM_PAY])
CREATE RECORD([UM_PAY])

[UM_PAY]UP_ID:=0
[UM_PAY]UP_UT_ID:=0
[UM_PAY]UP_KIGENBI:=Current date
[UM_PAY]UP_SIHARAIBI:=Current date
[UM_PAY]UP_HOUKIBI:=Current date
[UM_PAY]UP_SIKKOU_YOTEIBI:=Current date
[UM_PAY]UP_AMOUNT:=0.0
[UM_PAY]UP_TANTOUSHA:=""
[UM_PAY]UP_HANTEI:=""
[UM_PAY]UP_JIMUSHO:=""
[UM_PAY]UP_BIKOU:=""
[UM_PAY]UP_DEL_FLAG:=0
[UM_PAY]UP_UPDATE_DATEMARK:=""
[UM_PAY]UP_YEAR:=0

[UM_PAY]UP_ID:=$UP_id

SAVE RECORD([UM_PAY])

$0:=$UP_id
