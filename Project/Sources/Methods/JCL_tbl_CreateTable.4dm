//%attributes = {}
//JCL_tbl_CreateTable
//20240114 yabe wat
//fieldsのテキストブロックからSQL文を作成、実行してテーブル作成
//20240121 yabe wat UNIQUE サポート

C_TEXT:C284($1; $inBlockText)
$inBlockText:=$1  //ブロックの中身
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryTableItems; 0)
ARRAY TEXT:C222($aryFieldItems; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
C_TEXT:C284($sql)
C_TEXT:C284($fldName)

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)

//テーブル情報取得
$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)

//テーブル作成
$sql:="CREATE TABLE "+$aryTableItems{1}+"("

For ($i; 2; $numOfLines)
	//フィールド名とか切り出し
	DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
	
	//ＳＱＬのカラム定義節を組み立て
	$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")
	$fldName:=$aryTableItems{2}+"_"+$fldName
	$typeStr:=JCL_tbl_Type_SQL($aryFieldItems{2}; $aryFieldItems{3}; $aryFieldItems{5})  //20240121
	$sql:=$sql+$fldName+$typeStr
	
End for 

//最後のカンマを削除して括弧とセミコロンを追加
$sql:=Substring:C12($sql; 1; Length:C16($sql)-1)
$sql:=$sql+");"

SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
SQL EXECUTE:C820($sql)
SQL LOGOUT:C872

//インデックス作成
ARRAY POINTER:C280($fldAry; 0)
C_POINTER:C301($fldPtr)

For ($i; 2; $numOfLines)
	//フィールド名とか切り出し
	DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
	
	//インデックス作成
	If ($aryFieldItems{4}="1")
		
		$tblPtr:=JCL_tbl_Ptr_byName($aryTableItems{1})
		$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")
		$fldName:=$aryTableItems{2}+"_"+$aryFieldItems{1}
		$retCode:=JCL_tbl_Fld_GetPtr($tblPtr; $fldName; ->$fldPtr)
		If ($retCode=0)
			//フィールドポインタの配列を作ってわたす
			DELETE FROM ARRAY:C228($fldAry; 1; Size of array:C274($fldAry))
			APPEND TO ARRAY:C911($fldAry; $fldPtr)
			
			$indexName:=$aryTableItems{2}+$aryFieldItems{1}+"_index"
			CREATE INDEX:C966($tblPtr->; $fldAry; 0; $indexName)
			
		End if 
	End if 
End for 
