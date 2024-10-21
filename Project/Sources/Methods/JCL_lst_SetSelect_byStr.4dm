//%attributes = {}
  //JCL_lst_SetSelect_byStr
  //20181228 wat
  //リストボックスの行を選択する。汎用メソッド
  //リストボックスに連結されている文字列の配列をキーにする

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //リストボックスのブーリアン配列
C_POINTER:C301($2;$inStrDataAryPtr)
$inStrDataAryPtr:=$2  //文字列データ配列のポインタ
C_TEXT:C284($3;$keyValue)
$keyValue:=$3  //ロングのキーバリュー
C_LONGINT:C283($0;$row_number)
C_LONGINT:C283($index)

$index:=Find in array:C230($inStrDataAryPtr->;$keyValue)
If ($index#-1)
	  //要素がみつかったら
	JCL_lst_SetSelect_byRow ($inListBoxPtr;$index)
	$row_number:=$index
	
Else 
	  //みつからなかったらデセレクト
	JCL_lst_Deselect ($inListBoxPtr)
	$row_number:=0
	
End if 

$0:=$row_number
