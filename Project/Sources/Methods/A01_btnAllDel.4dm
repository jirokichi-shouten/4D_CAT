//%attributes = {}
//A01_btnAllDel
//20240223 yabe wat
//すべてのテーブルと関連メソッドを削除

C_LONGINT:C283($k; $sizeOfAry)
C_TEXT:C284($tblName)
C_POINTER:C301($tblPtr)
C_LONGINT:C283($tblNr)
C_TEXT:C284($sql)
C_OBJECT:C1216($folder)
C_COLLECTION:C1488($files)
C_LONGINT:C283($i)

//テーブルポインタの配列
$sizeOfAry:=Size of array:C274(vA01_lstT_name)
If ($sizeOfAry>0)
	//確認メッセージ
	$msg:=String:C10($sizeOfAry)+"個のテーブルを削除します。よろしいですか。"
	$dlgOk:=JCL_dlg_YesNo("テーブル削除"; $msg; "削除"; "キャンセル")
	If ($dlgOk=1)
		//テーブル削除
		For ($k; 1; $sizeOfAry)
			$tblName:=vA01_lstT_name{$k}
			$prefix:=vA01_lstT_prefix{$k}
			$tblNr:=vA01_lstT_nr{$k}
			$tblPtr:=Table:C252($tblNr)
			
			//レコード全件削除
			JCL_tbl_DelAll($tblPtr)
			
			//テーブル削除
			$sql:="drop table "+$tblName+";"
			SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
			SQL EXECUTE:C820($sql)
			SQL LOGOUT:C872
			
			//関連メソッドを削除：オブジェクトメソッドはフォルダごと消す
			$folder:=New object:C1471
			$folder:=Folder:C1567("/SOURCES/TableForms/"+String:C10($tblNr))
			$folder.delete(Delete with contents:K24:24)
			
			//関連メソッドを削除：フォームメソッド
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
			C_OBJECT:C1216($jcl_tg)
			$jcl_tg:=cs:C1710.JCL_tg.new()
			$jcl_tg.deleteLabelFile($tblName)
			
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
