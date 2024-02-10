//%attributes = {}
//zz_test_DeleteMethods
//20240210 wat
//プリフィックスを与えて、メソッドファイルを削除

C_TEXT:C284($tblName; $prefix)
$prefix:="KN"

//関連メソッドを削除：フォームメソッド
C_COLLECTION:C1488($files)
$files:=New collection:C1472
//$folder:=Folder("/SOURCES/Methods/")
$files:=Folder:C1567("/SOURCES/Methods/").files(fk ignore invisible:K87:22)
For ($i; 1; $files.length)
	C_TEXT:C284($currentFileName)
	$currentFileName:=$files[$i-1].name  // ファイル名を取得
	
	// ファイル名がプレフィックスで始まるかどうかをチェック
	If (Position:C15($prefix; $currentFileName)=1)
		// プレフィックスで始まるファイルを削除
		$files[$i-1].delete()
		
	End if 
End for 
