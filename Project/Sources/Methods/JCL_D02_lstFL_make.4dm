//%attributes = {}
//JCL_D02_lstFL_make
//20240116 wat
//テーブル情報のブロックから、フィールド情報を取り出して配列要素に追加

C_TEXT:C284($1; $fieldBlock)
$fieldBlock:=$1

C_LONGINT:C283($i; $numOfLines)
C_TEXT:C284($fldName; $label; $prefix)
C_LONGINT:C283($numOfItems)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)

If ($fieldBlock#"")
	$fieldBlock:=JCL_str_ReplaceReturn($fieldBlock)  //改行コードをLFに統一
	$numOfLines:=JCL_str_Extract_byReturn($fieldBlock; ->$aryLines)  //改行で切り分ける
	
	//１行目はテーブル情報
	For ($i; 1; $numOfLines-1)
		//フィールド情報を取得
		DELETE FROM ARRAY:C228($aryItems; 1; Size of array:C274($aryItems))
		$numOfItems:=JCL_str_Extract($aryLines{$i}; Char:C90(Tab:K15:37); ->$aryItems)
		If ($numOfItems>7)
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_NAME; $aryItems{1})  // フィールド名
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_LABEL; $aryItems{2})  // フィールドラベル（論理名）
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_DATA_TYPE; $aryItems{3})  // データ型
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_LENGTH; Num:C11($aryItems{4}))  // 文字長さ
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_INDEX; Num:C11($aryItems{5}))  // インデックス対象かどうか
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_UNIQUE; Num:C11($aryItems{6}))  // ユニークフィールド
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_COMMENT; $aryItems{7})  // 説明
			APPEND TO ARRAY:C911(vJCL_D02_lstFL_REMARK; $aryItems{8})  // サンプルデータ等
			
		End if 
	End for 
End if 
