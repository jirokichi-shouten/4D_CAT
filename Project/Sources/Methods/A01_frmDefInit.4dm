//%attributes = {}
//A01_frmDefInit
//20240328 Jirokichi
//フォームオブジェクトのプロセス変数宣言

C_OBJECT:C1216($fullpath)
$fullpath:=Path to object:C1547(Structure file:C489)

C_TEXT:C284(vA01_varProductName; vA01_varVersion)
vA01_varProductName:=$fullpath.name
vA01_varVersion:="0.9(1) your version letter here"

C_TEXT:C284(vA01_var4D_DataFile)
vA01_var4D_DataFile:="データファイル："+Data file:C490
