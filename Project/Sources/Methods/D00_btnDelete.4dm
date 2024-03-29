//%attributes = {}
//D00_btnDelete
//20240210 wat
//テーブルと関連メソッドを削除
//テーブル削除はDrop table,
//フォームメソッドは/Sources/Methodsのプリフィックスがテーブルと同じなら削除

C_LONGINT:C283($tblNr)
C_TEXT:C284($tblName; $prefix)
C_LONGINT:C283($dlgOk)

$prefix:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_prefix)
$tblNr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
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
		
		//ラベルファイルを削除
		C_OBJECT:C1216($jcl_fields)
		$jcl_fields:=cs:C1710.JCL_fields.new()
		$jcl_fields.deleteLabelFile($tblName)
		
		//テーブル一覧を作成
		JCL_lst_Deselect(->vD00_lstT)
		RELOAD PROJECT:C1739
		D00_lstT_make
		
		D00_SetControlsValues
		
		//フィールド一覧を更新
		D00_lstT_OnSelChange
		
	End if 
End if 
