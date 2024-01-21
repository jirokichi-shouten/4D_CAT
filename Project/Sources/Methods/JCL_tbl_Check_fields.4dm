//%attributes = {}
//JCL_tbl_Check_fields
//20240121 yabe wat
//fieldsフォーマットチェッカー fields admin import

//C_POINTER($tblPtr)

////テーブル名重複チェック
//$tblPtr:=JCL_tbl_Ptr_byName($aryTableItems{1})
//If ($tblPtr=Null)

//Else 
////フィールド情報に配列要素が６個以上なかった
//$msg:="テーブル重複エラー"+Char(Carriage return)
//$msg:=$msg+"テーブル名["+$aryTableItems{1}+"]はすでに存在します。"
//ALERT($msg)
//$i:=$numOfLines
//$k:=$numOfTables
//$errFlag:=1

//End if 

//For ($i; 2; $numOfLines)
////フィールド情報を取得
//DELETE FROM ARRAY($aryFieldItems; 1; Size of array($aryFieldItems))
//$numOfItems:=JCL_str_Extract($arylines{$i}; Char(Tab); ->$aryFieldItems)
//If ($numOfItems<6)
////フィールド情報に配列要素が６個以上なかった
//$msg:="フォーマットエラー"+Char(Carriage return)
//$msg:=$msg+"フィールド名の行のフォーマットが正しくないようです。"
//ALERT($msg)
//$i:=$numOfLines
//$k:=$numOfTables
//$errFlag:=1

//End if 
//End for 