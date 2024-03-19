//%attributes = {}
//A01_lstT_make
//20240204 wat
//テーブル一覧　リストボックス

C_POINTER:C301($tblPtr)
C_TEXT:C284($table_name; $label; $tbl_prefix)
C_LONGINT:C283($numOfRecs)
C_LONGINT:C283($numOfTables; $i; $sizeOfAry)
C_LONGINT:C283($color)

//ラベルキャッシュ作成
C_OBJECT:C1216($jcl_fields)
$jcl_fields:=cs:C1710.JCL_fields.new()
$jcl_fields.cache_make()

//配列初期化
DELETE FROM ARRAY:C228(vA01_lstT; 1; Size of array:C274(vA01_lstT))
DELETE FROM ARRAY:C228(vA01_lstT_nr; 1; Size of array:C274(vA01_lstT_nr))
DELETE FROM ARRAY:C228(vA01_lstT_name; 1; Size of array:C274(vA01_lstT_name))
DELETE FROM ARRAY:C228(vA01_lstT_label; 1; Size of array:C274(vA01_lstT_label))
DELETE FROM ARRAY:C228(vA01_lstT_prefix; 1; Size of array:C274(vA01_lstT_prefix))
DELETE FROM ARRAY:C228(vA01_lstT_numOfRecs; 1; Size of array:C274(vA01_lstT_numOfRecs))
DELETE FROM ARRAY:C228(vA01_lstT_Color; 1; Size of array:C274(vA01_lstT_Color))

$numOfTables:=Get last table number:C254
For ($i; 1; $numOfTables)
	If (Is table number valid:C999($i)=True:C214)
		APPEND TO ARRAY:C911(vA01_lstT_nr; $i)  //番号
		
		$table_name:=Table name:C256($i)
		APPEND TO ARRAY:C911(vA01_lstT_name; $table_name)  //テーブル名
		
		$label:=$jcl_fields.cache_TableLabel_get($table_name)
		APPEND TO ARRAY:C911(vA01_lstT_label; $label)  //テーブルラベル
		
		$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)
		APPEND TO ARRAY:C911(vA01_lstT_prefix; $tbl_prefix)  //プレフィックス
		
		$tblPtr:=Table:C252($i)
		ALL RECORDS:C47($tblPtr->)
		$numOfRecs:=Records in selection:C76($tblPtr->)
		APPEND TO ARRAY:C911(vA01_lstT_numOfRecs; $numOfRecs)  //レコード数
		
		$color:=JCL_tbl_GetFormColor($table_name)
		If ($color=0)
			$color:=0x00FFFFFF  //白
		End if 
		APPEND TO ARRAY:C911(vA01_lstT_Color; $color)  //色
		$sizeOfAry:=Size of array:C274(vA01_lstT_Color)
		LISTBOX SET ROW COLOR:C1270(*; "vA01_lstT_Color"; $sizeOfAry; $color; lk background color:K53:25)
		
	End if 
End for 
