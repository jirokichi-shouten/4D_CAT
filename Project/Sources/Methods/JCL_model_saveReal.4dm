//%attributes = {}
// JCL_model_saveReal
// 20220917 hisa
// テーブルとテキストフィールドからリアル値を保存
// JCL_model_saveReal(->[ANKEN]; ->[ANKEN]AN_ID; $id; ->[ANKEN]AN_CH; $ch)

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER:C301($2; $IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_LONGINT:C283($3; $id)
$id:=$3  //ＩＤ
C_POINTER:C301($4; $NameFldPtr)
$NameFldPtr:=$4  //テキストフィールドのポインタ
C_REAL:C285($5; $realValue)
$realValue:=$5  //テキスト値

READ WRITE:C146($tblPtr->)
//IDで検索
QUERY:C277($tblPtr->; $IDFldPtr->=$id)

$numOfRecs:=Records in selection:C76($tblPtr->)
If ($numOfRecs=1)
	$NameFldPtr->:=$realValue
	SAVE RECORD:C53($tblPtr->)
	
End if 

UNLOAD RECORD:C212($tblPtr->)
READ ONLY:C145($tblPtr->)
