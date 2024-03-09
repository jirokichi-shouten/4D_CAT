//%attributes = {}
//JCL_prj_FG_tblFrm03V4
//20240227 wat
//クラスを使って、xx03_Inputフォームを生成
//編集フォーム、関連テーブルのリストボックスがあるかも

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_POINTER:C301($2; $inAryFldNamePtr)
$inAryFldNamePtr:=$2
C_POINTER:C301($3; $inAryFieldTypePtr)
$inAryFldTypePtr:=$3
C_POINTER:C301($4; $inAryFldLengthPtr)
$inAryFldLengthPtr:=$4

//クラスインスタンス作成＆コンストラクター実行
$frm01:=cs:C1710.catForm.new($objParam)

//フォームメソッド
$frm01.saveFrmMethod($objParam)

//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
$frm01.saveMethods($objParam; $inAryFldNamePtr; $inAryFldTypePtr)

//タイトル文字とタイトルバック（色付き） 
$objParam.name:=$objParam.frm_prefix+"_rectTitle"
$frm01.addRect($objParam; 0; 0; 1042; 55)

$objParam.name:=$objParam.frm_prefix+"_txtTitle"
$objParam.text:=JCL_fields_cache_TableLabel($objParam.tbl_name)+"編集"
$objParam.css_class:="JCL_YuGothic16"
$frm01.addLabel($objParam; 16; 26; 288; 26)

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
	$objParam.name:=$objParam.frm_prefix+"_var"+$inAryFldNamePtr->{$i}
	$frm01.addInput($objParam; $objFldPos.top; $objFldPos.left; 110; 17; $enterable)
	
End for 

//外部キーを他テーブルに見つけたら、リストボックスを自動生成
C_LONGINT:C283($offset)
C_OBJECT:C1216($foreignParam)
$foreignParam:=New object:C1471
C_TEXT:C284($tblName; $tbl_prefix)
ARRAY LONGINT:C221($aryTblNr; 0)
ARRAY TEXT:C222($aryForeignKeys; 0)
ARRAY TEXT:C222($aryFieldIndex; 0)
$cnt:=zz_tbl_FindForeignKey($objParam.tbl_name; ->$aryTblNr; ->$aryForeignKeys)
For ($i; 1; $cnt)
	$tblName:=Table name:C256($aryTblNr{$i})
	$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($tblName)  //テーブルプリフィックス
	ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
	ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
	ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
	JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	
	//関連テーブルが複数ある場合、リストボックスとボタンたちをオフセットしていく
	$offset:=20*$i
	
	//フォームのAppendボタン
	$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Append"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
	$frm01.addPictureButton($objParam; 200+$offset; $offset)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのRemoveボタン
	$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Remove"
	$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
	$frm01.addPictureButton($objParam; 200+$offset; $offset+142)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//フォームのCopyボタン
	$objParam.name:=$objParam.frm_prefix+"_btn"+$tbl_prefix+"Copy"
	$objParam.text:="コピー"
	$frm01.addMethodButton($objParam; 200+$offset; $offset+188; 80; 26)
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//リストボックス
	$objParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
	$frm01.addListbox($objParam; 236+$offset; $offset; 1002; 288; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; "foreign")
	$frm01.saveObjMethod($objParam; $objParam.name)
	
	//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
	$foreignParam.name:=$objParam.frm_prefix+"_lst"+$tbl_prefix
	$frm01.saveObjMethod($objParam; $foreignParam.name)
	
	$foreignParam.frm_prefix:=$objParam.frm_prefix
	$foreignParam.parent_tbl_prefix:=$objParam.tbl_prefix
	$foreignParam.parent_tbl_name:=$objParam.tbl_name
	$foreignParam.tbl_name:=$tblName
	$foreignParam.tbl_prefix:=$tbl_prefix
	$foreignParam.method_templates:="method_templates_form03"
	$frm01.saveMethods($foreignParam; ->$aryFieldName; ->$aryFieldType)
	
End for 

//最終的に.4DFormに保存
$frm01.saveForm($objParam)
