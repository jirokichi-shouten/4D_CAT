//%attributes = {}
//JCL_tbl_Blocks_fromFile
//20240114 yabe wat
//fields.txtからテーブル文字列ブロックを切り出して配列で取得

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_POINTER:C301($2; $outAryBlokPtr)
$outAryBlokPtr:=$2  //フィールド定義行のテキストブロック、タブ改行区切り
C_LONGINT:C283($0; $cnt)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
C_TEXT:C284($block; $separator)
$block:=""
$separator:="-"  //テーブル情報区切り文字はハイフン

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$aryLines)  //add_ikeda 20221227
For ($i; 1; $numOfLines)
	//
	DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
	$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
	If ($aryItems{1}=$separator)
		//最後の改行を削除
		$block:=Substring:C12($block; 1; Length:C16($block)-1)
		
		//配列に追加
		APPEND TO ARRAY:C911($outAryBlokPtr->; $block)
		$block:=""  //バッファクリア
		$cnt:=$cnt+1
		
	Else 
		//文字連結で返す
		$block:=$block+$aryLines{$i}+Char:C90(Line feed:K15:40)
		
	End if 
End for 

$0:=$cnt
