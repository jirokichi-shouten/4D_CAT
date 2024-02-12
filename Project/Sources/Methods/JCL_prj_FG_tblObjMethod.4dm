//%attributes = {}
//JCL_prj_FG_tblObjMethod
//20210317 ike wat
//FormGenerator, オブジェクトメソッド作成
//20210608 wat 引数をオブジェクト型に変更

C_OBJECT:C1216($1; $objParam)
$objParam:=$1
C_TEXT:C284($2; $objName)
$objName:=$2
C_TEXT:C284($folderPath; $filePath)
C_TEXT:C284($body)
C_TEXT:C284($methodName)
C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)

//ファイルに書き出し
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Project")
$folderPath:=JCL_file_MakeFilePath($folderPath; "Sources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "TableForms")
$tblNr:=JCL_tbl_GetNumber($objParam.tbl_name)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$folderPath:=JCL_file_MakeFilePath($folderPath; $tblNrText)

$folderPath:=JCL_file_MakeFilePath($folderPath; $objParam.frm_name)
$outFolderPath:=JCL_file_MakeFilePath($folderPath; "ObjectMethods")
$methodName:="v"+$objParam.frm_prefix+$objName+".4dm"
//ファイルの中身はメソッド名だけ
$body:=$objParam.frm_prefix+$objName

$outFilePath:=JCL_file_MakeFilePath($outFolderPath; $methodName)
TEXT TO DOCUMENT:C1237($outFilePath; $body)
