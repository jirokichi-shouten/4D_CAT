//%attributes = {}
//JCL_prj_FG_tblFrm02V4
//20240222 wat
//クラスを使って、xx02_Inputフォームを生成

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_POINTER:C301($2; $inAryFldNamePtr)
$inAryFldNamePtr:=$2
C_POINTER:C301($3; $inAryFieldTypePtr)
$inAryFldTypePtr:=$3
C_POINTER:C301($4; $inAryFldLengthPtr)
$inAryFldLengthPtr:=$4

//クラスインスタンス作成＆コンストラクター実行
$frm01:=cs:C1710.Form01.new($objParam)

//フォームメソッド
$frm01.saveFrmMethod($objParam)

//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
$frm01.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)

//タイトル文字とタイトルバック（色付き） 
$objParam.name:=$objParam.frm_prefix+"_rectTitle"
$frm01.addRect($objParam; 0; 0; 1042; 55)

$objParam.name:=$objParam.frm_prefix+"_varTitle"
$objParam.textAlign:="left"
$objParam.css_class:="JCL_YuGothic16"
$frm01.addVarText($objParam; 16; 26; 288; 26)

//フォームのOKボタン
$objParam.name:=$objParam.frm_prefix+"_btnOK"
$objParam.text:="OK"
$frm01.addMethodButton($objParam; 16; 928; 94; 26)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのCancelボタン
$objParam.name:=$objParam.frm_prefix+"_btnCancel"
$objParam.text:="キャンセル"
$objParam.action:="cancel"
$objParam.shortcutKey:="[Esc]"
$frm01.addButton($objParam; 16; 814; 94; 26)

//フォームのDeleteボタン
$objParam.name:=$objParam.frm_prefix+"_btnDelete"
$objParam.text:="削除"
$frm01.addMethodButton($objParam; 16; 700; 94; 26)
$frm01.saveObjMethod($objParam; $objParam.name)

//フィールド用の文字列を作成、複数フィールドを作成
C_LONGINT:C283($i; $sizeOfAry)
C_OBJECT:C1216($objFldPos)
$objFldPos:=New object:C1471
C_TEXT:C284($fld_name; $label)
C_LONGINT:C283($fldWidth)
C_BOOLEAN:C305($enterable)
$objFldPos.top:=90
$objFldPos.left:=110
$objFldPos.label_left:=10
$sizeOfAry:=Size of array:C274($inAryFldNamePtr->)
For ($i; 1; $sizeOfAry)
	//フィールドラベルを取得
	$fld_name:=$inAryFldNamePtr->{$i}
	$label:=JCL_fields_Label($fld_name)
	If ($label="")
		//ラベルが取得できなかったらフィールド名を使う
		$label:=$fld_name
		
	End if 
	//フィールド位置
	$objFldPos:=JCL_prj_fg_fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
	
	//フィールドラベル
	$objParam.name:=$objParam.frm_prefix+"_lbl"+$fld_name
	$objParam.text:=$label
	$objParam.css_class:="JCL_YuGothic12"
	$frm01.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
	
	//フィールドがIDなら入力不可
	C_BOOLEAN:C305($enterable)
	If ($fld_name=($objParam.tbl_prefix+"_ID"))
		$enterable:=False:C215
	Else 
		$enterable:=True:C214
	End if 
	$objParam.name:=$objParam.frm_prefix+"_var"+$fld_name
	$frm01.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
	
End for 

//最終的に.4DFormに保存
$frm01.saveForm($objParam)
