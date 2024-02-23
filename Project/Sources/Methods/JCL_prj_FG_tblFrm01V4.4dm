//%attributes = {}
//JCL_prj_FG_tblFrm01V4
//20240215 
//テーブルフォーム作成 JSONとオブジェクト記法を使う方法
//クラスを使って、フォームを生成
// 引数として テーブル名、テーブルプリフィックス、フォーム名、フォームプリフィックスを渡します

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_POINTER:C301($2; $aryFieldNamePtr)
$aryFieldNamePtr:=$2
C_POINTER:C301($3; $aryFieldTypePtr)
$aryFieldTypePtr:=$3
C_POINTER:C301($4; $aryFieldLengthPtr)
$aryFieldLengthPtr:=$4

//クラスインスタンス作成＆コンストラクター実行
//フォームメソッド
$frm01:=cs:C1710.Form01.new($objParam)

$frm01.saveFrmMethod($objParam)

//タイトル文字とタイトルバック（色付き） 
$objParam.name:=$objParam.frm_prefix+"_rectTitle"
$frm01.addRect($objParam; 0; 0; 1042; 55)

$objParam.name:=$objParam.frm_prefix+"_txtTitle"
$objParam.text:=JCL_fields_cache_TableLabel($objParam.tbl_name)+"一覧"
$objParam.css_class:="JCL_YuGothic16"
$frm01.addLabel($objParam; 16; 20; 192; 26)

//フォームの件数文字列
$objParam.name:=$objParam.frm_prefix+"_varNumOfRecs"
$objParam.textAlign:="right"
$objParam.css_class:="JCL_YuGothic12"
$frm01.addVarText($objParam; 80; 880; 110; 17)

//検索用 ラベルとキーワードフィールド、ボタン
$objParam.name:=$objParam.frm_prefix+"_lblKeyword"
$objParam.text:="キーワード"
$objParam.css_class:="JCL_YuGothic12"
$frm01.addLabel($objParam; 74; 272; 80; 17)
$objParam.name:=$objParam.frm_prefix+"_varKeyword"
$frm01.addInput($objParam; 74; 356; 110; 17)
$objParam.name:=$objParam.frm_prefix+"_btnFind"
$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/magnifyingglass.png"
$frm01.addPictureButton($objParam; 68; 466)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのAddボタン
$objParam.name:=$objParam.frm_prefix+"_btnAdd"
$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
$frm01.addPictureButton($objParam; 68; 20)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのModボタン
$objParam.name:=$objParam.frm_prefix+"_btnMod"
$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_pencil_w.png"
$frm01.addPictureButton($objParam; 68; 68)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのDelボタン
$objParam.name:=$objParam.frm_prefix+"_btnDel"
$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
$frm01.addPictureButton($objParam; 68; 162)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのExportボタン
$objParam.name:=$objParam.frm_prefix+"_btnExport"
$objParam.picture:="/RESOURCES/JCL4D_Resources/pictures/square_and_arrow_down.png"
$frm01.addPictureButton($objParam; 68; 996)
$frm01.saveObjMethod($objParam; $objParam.name)

//フォームのCloseボタン
$objParam.name:=$objParam.frm_prefix+"_btnClose"
$objParam.text:="X"
$objParam.action:="cancel"
$objParam.shortcutKey:="w"
$frm01.addButton($objParam; 16; 980; 42; 26)

//リストボックス
$objParam.name:=$objParam.frm_prefix+"_lst"+$objParam.tbl_prefix
$frm01.addListbox($objParam; 110; 20; 1002; 440; $aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr)
$frm01.saveObjMethod($objParam; $objParam.name)

//最終的に.4DFormに保存
$frm01.saveForm($objParam)

//関連プロジェクトメソッド、テンプレートフォルダのテンプレートから生成
$frm01.saveMethods($objParam; $aryFieldNamePtr; $aryFieldTypePtr)
