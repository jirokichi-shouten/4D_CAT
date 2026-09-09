//%attributes = {}
//JCL_frm_AdjustHeight_byFontSize
//JCL_frm_AdjustFontHeight（元の名前）
//20180521 wat
//フォームオブジェクト　文字高さと行数によってフォントサイズを小さくする

C_TEXT:C284($1; $fldName)
$fldName:=$1
C_LONGINT:C283($font_size)
C_LONGINT:C283($best_width; $best_height)
C_LONGINT:C283($org_width; $org_height)

// プロパティで設定されているフォントサイズ
$font_size:=OBJECT Get font size:C1070(*; $fldName)

// フォームエディタ上のオブジェクトサイズ
JCL_frm_GetObjectSize($fldName; ->$org_width; ->$org_height)

// 文字列描画後の　オフジェクトの最適サイズ
OBJECT GET BEST SIZE:C717(*; $fldName; $best_width; $best_height)

While ($org_height<=$best_height)
	// フォントサイズを一つ小さくする
	$font_size:=$font_size-1
	OBJECT SET FONT SIZE:C165(*; $fldName; $font_size)
	
	// フォント変更後、オフジェクトの最適サイズ　を取り直す
	OBJECT GET BEST SIZE:C717(*; $fldName; $best_width; $best_height)
	
End while 
