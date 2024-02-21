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
$frm01:=cs:C1710.Form01.new($objParam)

//タイトル文字とタイトルバック（色付き） 
$frm01.addTitle($objParam)

//フォームの件数文字列
$obj_name:="v"+$objParam.frm_prefix+"_varNumOfRecs"
$frm01.addText($objParam; 74; 914)

//フォームのAddボタン
$objParam.btn_name:="_btnAdd"
$objParam.btn_pic_path:="/RESOURCES/JCL4D_Resources/pictures/plus_rectangle.png"
$frm01.addPictureButton($objParam; 68; 20)
$frm01.saveObjMethod($objParam; $objParam.btn_name)

//フォームのModボタン
$objParam.btn_name:="_btnMod"
$objParam.btn_pic_path:="/RESOURCES/JCL4D_Resources/pictures/square_and_pencil_w.png"
$frm01.addPictureButton($objParam; 68; 68)
$frm01.saveObjMethod($objParam; $objParam.btn_name)

//フォームのDelボタン
$objParam.btn_name:="_btnDel"
$objParam.btn_pic_path:="/RESOURCES/JCL4D_Resources/pictures/minus_rectangle.png"
$frm01.addPictureButton($objParam; 68; 162)
$frm01.saveObjMethod($objParam; $objParam.btn_name)

//フォームのExportボタン
$objParam.btn_name:="_btnExport"
$objParam.btn_pic_path:="/RESOURCES/JCL4D_Resources/pictures/square_and_arrow_down.png"
$frm01.addPictureButton($objParam; 68; 890)
$frm01.saveObjMethod($objParam; $objParam.btn_name)

//フォームのCloseボタン
$objParam.btn_name:="_btnClose"
$objParam.btn_text:="X"
$objParam.btn_action:="cancel"
$objParam.btn_shortcut_key:="w"
$frm01.addButton($objParam; 16; 980; 42; 26)

//リストボックス
$frm01.addListbox($objParam; 94; 20; 1002; 472; $aryFieldNamePtr; $aryFieldTypePtr; $aryFieldLengthPtr)
$frm01.saveObjMethod($objParam; "_lst"+$objParam.tbl_prefix)

//最終的に.4DFormに保存
$frm01.saveForm($objParam)


