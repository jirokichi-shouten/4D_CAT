//%attributes = {}
//JCL_frm_AdjustWidth_byFontSize
//JCL_frm_AdjustFontSize（元の名前）
//フォームオブジェクト　文字数によってフォントサイズを小さくする
//20170905 yabe wat
//20181124 wat 対象となるフィールドがいない場合は無限ループになるので注意
//20220410 wat minekaで暴走、長い文字列を与えたらおかしくなった。→whileに条件を追加

C_TEXT:C284($1; $fldName)
$fldName:=$1
C_LONGINT:C283($font_size)
C_LONGINT:C283($best_width; $best_height)
C_LONGINT:C283($org_width; $org_height)
C_BOOLEAN:C305($done)  //20220410

//オブジェクトが存在するかどうか
C_POINTER:C301($objPtr)
$objPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $fldName)
If ($objPtr#Null:C1517)
	// プロパティで設定されているフォントサイズ
	$font_size:=OBJECT Get font size:C1070(*; $fldName)
	
	// フォームエディタ上のオブジェクトサイズ
	JCL_frm_GetObjectSize($fldName; ->$org_width; ->$org_height)
	
	// 文字列描画後の　オフジェクトの最適サイズ
	$done:=False:C215
	OBJECT GET BEST SIZE:C717(*; $fldName; $best_width; $best_height)
	While (($org_width<=$best_width) & ($done=False:C215))
		// フォントサイズを一つ小さくする
		$font_size:=$font_size-1
		OBJECT SET FONT SIZE:C165(*; $fldName; $font_size)
		
		// フォント変更後、オフジェクトの最適サイズ　を取り直す
		OBJECT GET BEST SIZE:C717(*; $fldName; $best_width; $best_height)
		
		$m:="JCL_frm_AdjustFontSize"
		$m:=$m+": $fldName=["+$fldName+"]"
		$m:=$m+": $org_width=["+String:C10($org_width)+"]"
		$m:=$m+": $best_width=["+String:C10($best_width)+"]"
		$m:=$m+": $font_size=["+String:C10($font_size)+"]"
		//JCL_file_Logout ($m)
		
		If ($font_size<3)  //20220410
			$done:=True:C214
		End if 
	End while 
	
Else 
	C_TEXT:C284($msg)
	$msg:="Object not found: JCL_frm_AdjustFontSize"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+"$fldName=["+$fldName+"]"
	//$msg:=$msg+"$objPtr=["+string($objPtr)+"]"
	ALERT:C41($msg+": Null")
	
End if 
