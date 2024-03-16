//%attributes = {"shared":true}
//JCL_tbl_Check_fieldsFile
//20111005 wat
//20121001 wat rename, 20130429 wat mod , 20130430 mod
//20150826 yabe フォーム作成フラグ追加
//テーブル名の配列を得る
//20240114 yabe wat テーブル区切りはアンダースコアではなくハイフンに統一
//20240114 yabe wat refactor

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_LONGINT:C283($0; $errFlag)
$errFlag:=0
ARRAY TEXT:C222($arylines; 0)
ARRAY TEXT:C222($aryTableItems; 0)
ARRAY TEXT:C222($aryFieldItems; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
ARRAY TEXT:C222($aryBlock; 0)  //20240114
C_TEXT:C284($msg)

//テーブル名の配列を得る
$numOfTables:=JCL_tbl_Blocks_fromFile($inFileText; ->$aryBlock)
If ($numOfTables=0)
	//エラーメッセージ
	$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+"fields.txtのファイルフォーマットを確認してください。"
	ALERT:C41($msg)
	$errFlag:=1
	
Else 
	For ($k; 1; $numOfTables)
		//改行で切り分ける
		$numOfLines:=JCL_str_Extract_byReturn($aryBlock{$k}; ->$arylines)
		If ($numOfLines>1)
			//テーブル情報取得
			$numOfItems:=JCL_str_Extract($arylines{1}; Char:C90(Tab:K15:37); ->$aryTableItems)
			If ($numOfItems>2)
				//テーブル名に予約語が使われていないかチェック
				//$found_reserved:=JCL_tbl_FindSQLReserved($aryTableItems{1})
				//If ($found_reserved=True)
				////テーブル名がSQL予約語
				//$msg:="テーブル名を変更してください"+Char(Carriage return)
				//$msg:=$msg+"テーブル名「"+$aryTableItems{1}+"」にSQL予約語が使われています。"
				//ALERT($msg)
				
				//End if 
			Else 
				//ブロックに配列要素が３個以上なかった
				$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
				$msg:=$msg+"テーブル名の行のフォーマットが正しくないようです。"
				ALERT:C41($msg)
				$k:=$numOfTables
				$errFlag:=1
				
			End if 
		Else 
			//ブロックに配列要素が２個以上なかった
			$msg:="フォーマットエラー"+Char:C90(Carriage return:K15:38)
			$msg:=$msg+"テーブル情報が不足しています。"
			ALERT:C41($msg)
			$k:=$numOfTables
			$errFlag:=1
			
		End if 
		
	End for 
End if 

$0:=$errFlag
