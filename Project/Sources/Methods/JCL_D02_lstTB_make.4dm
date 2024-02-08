//%attributes = {}
//JCL_D02_lstTB_make
//20240116 wat
//テーブル情報のブロックから、テーブル情報を取り出して配列要素に追加

C_TEXT:C284($1; $block)
$block:=$1
C_TEXT:C284($2; $status)
$status:=$2
C_LONGINT:C283($3; $nr)
$nr:=$3
C_TEXT:C284($fieleBlock)
C_LONGINT:C283($i; $numOfLines)
C_LONGINT:C283($numOfLines; $numOfItems)
ARRAY TEXT:C222($aryLines; 0)
ARRAY TEXT:C222($aryItems; 0)
C_LONGINT:C283($tblNr)

If ($block#"")
	$block:=JCL_str_ReplaceReturn($block)  //改行コードをLFに統一
	$numOfLines:=JCL_str_Extract_byReturn($block; ->$aryLines)  //改行で切り分ける
	
	//最初の要素はテーブル情報
	$numOfItems:=JCL_str_Extract($aryLines{1}; Char:C90(Tab:K15:37); ->$aryItems)
	If ($numOfItems>5)
		If ($aryItems{1}#"")
			//テーブルが作成されているか？
			$tblNr:=JCL_tbl_GetNumber($aryItems{1})
			If ($tblNr#0)
				$status:=String:C10($tblNr)
			End if 
		End if 
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_status; $status)  //fields情報ステータス：Nr, NA, temporary
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_error; "")  //エラー文字
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_NAME; $aryItems{1})  // テーブル名
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_PREFIX; $aryItems{2})  // プリフィックス
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_NO_FORM; $aryItems{3})  // NoFormでなければフォームを作る
		APPEND TO ARRAY:C911(vJCL_D02_lstTB_LABEL; $aryItems{6})  // テーブルラベル（論理名）
		If ($numOfItems>6)
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_DESCRIPTION; $aryItems{7})  // 説明
		Else 
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_DESCRIPTION; "")  // 説明
		End if 
		If ($numOfItems>7)
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_REMARK; $aryItems{8})  // サンプルデータ等
		Else 
			APPEND TO ARRAY:C911(vJCL_D02_lstTB_REMARK; "")  // 説明
		End if 
	End if 
	
	APPEND TO ARRAY:C911(vJCL_D02_lstTB_Block; $block)  // フィールド情報
	
	If ($status#"temporary")
		APPEND TO ARRAY:C911(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
		APPEND TO ARRAY:C911(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(255; 0; 0))  // フォントカラー
	Else 
		APPEND TO ARRAY:C911(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
		APPEND TO ARRAY:C911(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(0; 0; 0))  // フォントカラー
	End if 
	
End if 
