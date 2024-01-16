//%attributes = {}
//JCL_D02_lstTB_make
//20240116 wat
//テーブル情報のブロックから、テーブル情報を取り出して配列要素に追加

C_TEXT:C284($1; $block)
$block:=$1
C_TEXT:C284($fieleBlock)
C_LONGINT:C283($i; $numOfLines)
C_LONGINT:C283($numOfLines; $numOfItems)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)

If ($block#"")
	$block:=JCL_str_ReplaceReturn($block)  //改行コードをLFに統一
	$numOfLines:=JCL_str_Extract_byReturn($block; ->$aryLines)  //改行で切り分ける
	
	//最初の要素はテーブル情報
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryItems)
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_LABEL; $aryItems{6})  // テーブルラベル（論理名）
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_NAME; $aryItems{1})  // テーブル名
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_PREFIX; $aryItems{2})  // プリフィックス
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_NO_FORM; $aryItems{3})  // NoFormでなければフォームを作る
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_DESCRIPTION; $aryItems{7})  // 説明
	
	//２行目から最後まではフィールド情報
	For ($i; 2; $numOfLines)
		//改行でつなげる
		$fieleBlock:=$fieleBlock+$aryLines{$i}+Char:C90(Line feed:K15:40)
		
	End for 
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_Block; $fieleBlock)  // フィールド情報
	
End if 
