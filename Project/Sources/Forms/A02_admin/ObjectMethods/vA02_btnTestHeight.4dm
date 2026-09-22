//vA02_btnTestHeight
//20260922 wat
//Core化に伴い、コンポーネントに移したメソッドの動作確認用

C_TEXT:C284(vTestText)
C_LONGINT:C283($before; $after)

vTestText:="1行目"+Char:C90(Carriage return:K15:38)+"2行目"+Char:C90(Carriage return:K15:38)+"3行目"
OBJECT SET FONT SIZE:C165(*; "vA02_txtAdjustHeight"; 24)

$before:=OBJECT Get font size:C1070(*; "vA02_txtAdjustHeight")
JCL_frm_AdjustHeight_byFontSize("vA02_txtAdjustHeight")
$after:=OBJECT Get font size:C1070(*; "vA02_txtAdjustHeight")

ALERT:C41("フォントサイズ: "+String:C10($before)+" → "+String:C10($after))
