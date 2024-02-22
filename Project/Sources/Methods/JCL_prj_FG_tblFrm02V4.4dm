//%attributes = {}
//JCL_prj_FG_tblFrm02V4
//20240222 wat
//クラスを使って、xx02_Inputフォームを生成

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_POINTER:C301($2; $aryFieldNamePtr)
$aryFieldNamePtr:=$2
C_POINTER:C301($3; $aryFieldTypePtr)
$aryFieldTypePtr:=$3
C_POINTER:C301($4; $aryFieldLengthPtr)
$aryFieldLengthPtr:=$4

//クラスインスタンス作成＆コンストラクター実行
$frm01:=cs:C1710.Form01.new($objParam)

//フォームメソッド
$frm01.saveFrmMethod($objParam)

//タイトル文字とタイトルバック（色付き） 
$objParam.name:=$objParam.frm_prefix+"_rectTitle"
$frm01.addRect($objParam; 0; 0; 987; 55)

$objParam.name:=$objParam.frm_prefix+"_varTitle"
$objParam.textAlign:="left"
$objParam.css_class:="JCL_YuGothic16"
$frm01.addVarText($objParam; 16; 26; 288; 26)

//フォームのOKボタン
$objParam.name:=$objParam.frm_prefix+"_btnOK"
$objParam.text:="OK"
$frm01.addMethodButton($objParam; 16; 873; 94; 26)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのCancelボタン
$objParam.name:=$objParam.frm_prefix+"_btnCancel"
$objParam.text:="キャンセル"
$objParam.action:="cancel"
$objParam.shortcutKey:="[Esc]"
$frm01.addButton($objParam; 16; 759; 94; 26)

//フォームのDeleteボタン
$objParam.name:=$objParam.frm_prefix+"_btnDelete"
$objParam.text:="削除"
$frm01.addMethodButton($objParam; 16; 645; 94; 26)
$frm01.saveObjMethod($objParam; $objParam.name)

//フィールド用の文字列を作成、複数フィールドを作成
C_LONGINT:C283($i; $sizeOfAry)
C_OBJECT:C1216($objFldPos)
$objFldPos:=New object:C1471
C_TEXT:C284($label)
C_LONGINT:C283($fldWidth)
$objFldPos.top:=90
$objFldPos.left:=110
$objFldPos.label_left:=10
$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
For ($i; 1; $sizeOfAry)
	//フィールドラベルを取得
	$label:=JCL_fields_Label($aryFieldNamePtr->{$i})
	If ($label="")
		//ラベルが取得できなかったらフィールド名を使う
		$label:=$aryFieldNamePtr->{$i}
		
	End if 
	//フィールド位置
	$objFldPos:=JCL_prj_fg_fldNextPos($objFldPos; 90)  //20240201 90はトップの戻るところ 
	
	//フィールドラベル
	$objParam.name:=$objParam.frm_prefix+"_lbl"+$aryFieldNamePtr->{$i}
	$objParam.text:=$label
	$objParam.css_class:="JCL_YuGothic12"
	$frm01.addLabel($objParam; $objFldPos.top; $objFldPos.label_left; 94; 17)
	
	$objParam.name:=$objParam.frm_prefix+"_var"+$aryFieldNamePtr->{$i}
	$frm01.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17)
	
End for 

//最終的に.4DFormに保存
$frm01.saveForm($objParam)

//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
$frm01.saveMethods($objParam; $aryFieldNamePtr; $aryFieldTypePtr)
