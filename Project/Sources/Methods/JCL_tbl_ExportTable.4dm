//%attributes = {"shared":true}
//JCL_tbl_ExportTable
//20130430 yabe
//一つのテーブルとそのフィールド書き出し
//20240223 yabe wat プリフィックスはアンダースコア抜きの文字列とした。

C_TIME:C306($1; $doc)
$doc:=$1
C_TEXT:C284($2; $tableName)
$tableName:=$2
C_POINTER:C301($3; $inAryFieldName)
$inAryFieldName:=$3
C_POINTER:C301($4; $inAryFieldType)
$inAryFieldType:=$4
C_POINTER:C301($5; $inAryFieldLength)
$inAryFieldLength:=$5
C_POINTER:C301($6; $inAryFieldIndex)
$inAryFieldIndex:=$6

C_TEXT:C284($tbl_prefix; $prefix4replace)
C_LONGINT:C283($i; $numOfFields)

C_LONGINT:C283($pos)
$pos:=Position:C15("_"; $inAryFieldName->{1})
$tbl_prefix:=Substring:C12($inAryFieldName->{1}; 1; $pos-1)  //テーブル名のプリフィックス
$prefix4replace:=$tbl_prefix+"_"

//テーブル情報
SEND PACKET:C103($doc; $tableName+Char:C90(Tab:K15:37))
SEND PACKET:C103($doc; $tbl_prefix+Char:C90(Carriage return:K15:38))

$numOfFields:=Size of array:C274($inAryFieldName->)
For ($i; 1; $numOfFields)
	//フィールド情報
	$exportFieldName:=Replace string:C233($inAryFieldName->{$i}; $prefix4replace; ""; 1)
	
	SEND PACKET:C103($doc; $exportFieldName+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc; $inAryFieldType->{$i}+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc; $inAryFieldLength->{$i}+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc; $inAryFieldIndex->{$i}+Char:C90(Carriage return:K15:38))
	
End for 

//テーブルの区切り 20240223 ハイフン（-）に変更
SEND PACKET:C103($doc; "-"+Char:C90(Carriage return:K15:38))
