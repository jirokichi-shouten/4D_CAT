//%attributes = {}
//JCL_prj_fg_method_replaceTags
//20240221 wat
//テンプレートメソッドのテキスト、タグを置き換える

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_TEXT:C284($2; $method)
$method:=$2  //読み込んだファイルの中身
C_POINTER:C301($3; $aryFieldNamePtr)
$aryFieldNamePtr:=$3
C_POINTER:C301($4; $aryFieldTypePtr)
$aryFieldTypePtr:=$4
C_TEXT:C284($0; $newmethod)
$newmethod:=""
C_TEXT:C284($tbl_prefix)
C_LONGINT:C283($len; $h; $k)
C_LONGINT:C283($pos_row)
C_TEXT:C284($dateTimeStr)
C_TEXT:C284($dataType; $initValue; $strValue)
C_TEXT:C284($chr; $buf; $newBuf)
//日付時刻文字列を作成
$dateTimeStr:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)

//メソッド生成
$method:=Replace string:C233($method; "[--DATE]"; $dateTimeStr)
$method:=Replace string:C233($method; "[--TABLE]"; $objParam.tbl_name)
$method:=Replace string:C233($method; "[--TBL_PREFIX]"; $objParam.tbl_prefix)
$method:=Replace string:C233($method; "[--FRM_PREFIX]"; $objParam.frm_prefix)
If (OB Is defined:C1231($objParam; "parent_tbl_prefix")=True:C214)
	$method:=Replace string:C233($method; "[--PARENT_TBL_PREFIX]"; $objParam.parent_tbl_prefix)
End if 

$len:=Length:C16($method)
$buf:=""
$newmethod:=""
For ($h; 1; $len)
	$chr:=Substring:C12($method; $h; 1)
	$buf:=$buf+$chr
	
	If (JCL_str_IsCharRetrurn($chr))  //add_ikeda 20221227
		
		$pos_row:=Position:C15("[--FIELD]"; $buf)
		If ($pos_row#0)
			For ($k; 1; Size of array:C274($aryFieldNamePtr->))
				//フィールド名を置換
				$fieldName:=$aryFieldNamePtr->{$k}  //20130501
				$newBuf:=Replace string:C233($buf; "[--FIELD]"; $fieldName)
				
				//データ型を置換
				$dataType:=JCL_tbl_DataType($aryFieldTypePtr->{$k})
				$newBuf:=Replace string:C233($newBuf; "[--DATATYPE]"; $dataType)
				
				//初期値を置換
				$initValue:=JCL_tbl_InitValue($aryFieldTypePtr->{$k})
				$newBuf:=Replace string:C233($newBuf; "[--INITVALUE]"; $initValue)
				
				$newmethod:=$newmethod+$newBuf
				
			End for 
		Else 
			$newmethod:=$newmethod+$buf
			
		End if 
		
		$buf:=""
		
	End if 
End for 

$0:=$newmethod

