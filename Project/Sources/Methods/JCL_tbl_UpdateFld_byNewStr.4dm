//%attributes = {}
  //JCL_tbl_UpdateFld_byNewStr
  //Jiro_tbl_UpdateFld_byNewStr
  //20100628 wat new, refactoring
  //テーブルとフィールドのポインタをもらって、
  //古い文字列を新しい文字列に置き換える、
  //対象となるレコードが複数ある、更新した行数を返す

C_POINTER:C301($1;$inTablePtr)
$inTablePtr:=$1  //テーブルのポインタ
C_POINTER:C301($2;$inFieldPtr)
$inFieldPtr:=$2  //フィールドのポインタ
C_TEXT:C284($3;$oldStr;$4;$newStr)
$oldStr:=$3  //旧文字列、検索文字列
$newStr:=$4  //新しい文字列
C_LONGINT:C283($0;$numOfRecs;$i)

  //古い分類名で分類をクエリ
READ WRITE:C146($inTablePtr->)
QUERY:C277($inTablePtr->;$inFieldPtr->=$oldStr)
$numOfRecs:=Records in selection:C76($inTablePtr->)
FIRST RECORD:C50($inTablePtr->)
For ($i;1;$numOfRecs)
	  //
	$inFieldPtr->:=$newStr
	SAVE RECORD:C53($inTablePtr->)
	
	NEXT RECORD:C51($inTablePtr->)
End for 

UNLOAD RECORD:C212($inTablePtr->)
READ ONLY:C145($inTablePtr->)

$0:=$numOfRecs
