//%attributes = {}
//zz_file_setText
//20240211 wat
//File.setText()が書き込みエラー、Read onlyに書こうとしている？

//$folder:=Folder("/SOURCES/Methods/")
//$folder:=Folder("/SOURCES/TableForms/")
//$folder:=Folder("/SOURCES/TableForms/11").create()


C_OBJECT:C1216($file)
$file:=New object:C1471
C_TEXT:C284($text)
C_OBJECT:C1216($objFrm)
$objFrm:=New object:C1471

//ファイルの内容を読み込んで　解析
$file:=File:C1566("/RESOURCES/JCL4D_Resources/frm_templates/frm01_v3.txt")
$text:=$file.getText("UTF-8"; Document with LF:K24:22)
ALERT:C41($text)
$objFrm:=JSON Parse:C1218($text)

////フォームのタイトル文字列
//C_OBJECT($objTitle)
//$objTitle:=New object("type"; "rectangle"; "top"; 0; "left"; 0; "width"; 1042; "height"; 55)
//$objFrm.pages[1].objects.aaa:=$objTitle

C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)
$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$folderText:="/SOURCES/TableForms/"+String:C10($tblNr)
$folderText:="/SOURCES/"+String:C10($tblNr)
$folder:=Folder:C1567($folderText).create()
$folderText:="/SOURCE/TableForms/"+String:C10($tblNr)+"/"+$objParam.frm_name
$folder:=Folder:C1567($folderText).create()
$file:=$folder.file("form.4DForm").create()

