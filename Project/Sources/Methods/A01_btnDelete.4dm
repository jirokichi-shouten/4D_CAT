//%attributes = {}
//A01_btnDelete
//20240210 wat
//テーブルと関連メソッドを削除
//テーブル削除はDrop table, 
//フォームメソッドは/Sources/Methodsのプリフィックスがテーブルと同じなら削除

C_LONGINT:C283($tblNr)
C_TEXT:C284($tblName; $prefix)
C_LONGINT:C283($dlgOk)

$prefix:=JCL_lst_Selected_Str(->vA01_lstT; ->vA01_lstT_prefix)
$tblNr:=JCL_lst_Selected_Long(->vA01_lstT; ->vA01_lstT_nr)
$tblName:=JCL_lst_Selected_Str(->vA01_lstT; ->vA01_lstT_name)
If ($tblName#"")
	//確認メッセージ
	$msg:="テーブル["+$tblName+"]を削除します。よろしいですか。"
	$dlgOk:=JCL_dlg_YesNo("テーブル削除"; $msg; "削除"; "キャンセル")
	If ($dlgOk=1)
		//テーブル削除
		C_POINTER:C301($tblPtr)
		$tblPtr:=Table:C252($tblNr)
		JCL_tbl_DelAll($tblPtr)
		C_TEXT:C284($sql)
		
		$sql:="drop table "+$tblName+";"
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		SQL EXECUTE:C820($sql)
		SQL LOGOUT:C872
		
		//関連メソッドを削除：オブジェクトメソッドはフォルダごと消す
		C_OBJECT:C1216($folder)
		$folder:=New object:C1471
		$folder:=Folder:C1567("/SOURCES/TableForms/"+String:C10($tblNr))
		$folder.delete(Delete with contents:K24:24)
		
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
		
		//テーブル一覧を作成
		JCL_lst_Deselect(->vA01_lstT)
		RELOAD PROJECT:C1739
		A01_lstT_make
		
		A01_SetControlsValues
		
		//フィールド一覧を更新
		A01_lstT_OnSelChange
		
	End if 
End if 
