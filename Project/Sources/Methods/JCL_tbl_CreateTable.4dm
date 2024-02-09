//%attributes = {}
//JCL_tbl_CreateTable
//20240114 yabe wat
//fieldsのテキストブロックからSQL文を作成、実行してテーブル作成
//20240121 yabe wat UNIQUE 追加。
//20240209 wat PRIMARY KEY追加。INDEX修正。

C_TEXT:C284($1; $inBlockText)
$inBlockText:=$1  //ブロックの中身
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryTableItems; 0)
ARRAY TEXT:C222($aryFieldItems; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
C_TEXT:C284($sql)
C_TEXT:C284($fldName; $tblName; $prefix; $fldFullName)

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inBlockText; ->$aryLines)

//テーブル情報取得
$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
$tblName:=$aryTableItems{1}  //テーブル名
$prefix:=$aryTableItems{2}  //プリフィックス

//テーブル作成　SQLで作成
$sql:="CREATE TABLE "+$tblName+"("

For ($i; 2; $numOfLines)
	//フィールド名とか切り出し
	DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
	
	//ＳＱＬのカラム定義節を組み立て
	$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")  //フィールド名にスペースがあったらアンダースコアに置き換える
	$fldFullName:=$prefix+"_"+$fldName
	$typeStr:=JCL_tbl_Type_SQL($aryFieldItems{2}; $aryFieldItems{3}; $aryFieldItems{5})  //20240121
	$sql:=$sql+$fldFullName+$typeStr
	
End for 

//最後のカンマのあとにプライマリーキーを追加して括弧とセミコロンを追加
$sql:=$sql+" PRIMARY KEY("+$prefix+"_ID));"

SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
SQL EXECUTE:C820($sql)
SQL LOGOUT:C872

//インデックス作成 4Dコマンドで作成
ARRAY POINTER:C280($fldAry; 0)
C_POINTER:C301($fldPtr)
C_LONGINT:C283($retCode)
C_TEXT:C284($indexName)

For ($i; 2; $numOfLines)
	//フィールド名切り出し
	DELETE FROM ARRAY:C228($aryFieldItems; 1; Size of array:C274($aryFieldItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryFieldItems)
	
	//インデックス作成
	If ($aryFieldItems{4}="1")
		
		$tblPtr:=JCL_tbl_Ptr_byName($tblName)
		$fldName:=Replace string:C233($aryFieldItems{1}; " "; "_")
		$fldFullName:=$prefix+"_"+$fldName
		$retCode:=JCL_tbl_Fld_GetPtr($tblPtr; $fldFullName; ->$fldPtr)
		If ($retCode=0)
			//フィールドポインタの配列を作ってわたす
			DELETE FROM ARRAY:C228($fldAry; 1; Size of array:C274($fldAry))
			APPEND TO ARRAY:C911($fldAry; $fldPtr)
			
			$indexName:=$fldFullName+"_index"
			CREATE INDEX:C966($tblPtr->; $fldAry; 0; $indexName)
			
		End if 
	End if 
End for 
