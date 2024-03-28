//%attributes = {}
//D00_btnForm
//20240210 wat
//テーブル一覧で選択されているテーブルの一覧表ウインドウを表示

C_TEXT:C284($tblName)
C_TEXT:C284($methodName)
C_TEXT:C284($tbl_prefix)
C_LONGINT:C283($pos)
C_LONGINT:C283($nr)

$nr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
$tblName:=JCL_lst_Selected_Str(->vD00_lstT; ->vD00_lstT_name)
If ($tblName#"")
	
	ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
	ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
	ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
	ARRAY TEXT:C222($aryFieldIndex; 0)
	C_TEXT:C284($fblName)
	
	C_TEXT:C284($tbl_prefix)
	//テーブルからプリフィックスを取得、
	JCL_tbl_Fields_withAttr($tblName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
	$pos:=Position:C15("_"; $aryFieldName{1})
	$tbl_prefix:=Substring:C12($aryFieldName{1}; 1; $pos-1)  //フィールド名のプリフィックス
	
	//メソッド実行
	$methodName:=$tbl_prefix+"01_List"
	$cnt:=JCL_method_isExist($methodName)
	If ($cnt=0)
		//なければ作る
		JCL_prj_FormGeneratorV4($tblName)
		RELOAD PROJECT:C1739  //20240207 4djapan
		
		//メッセージ
		$msg:="メソッド「"+$methodName+"」を作成しました。"
		ALERT:C41($msg)
		
		
	End if 
	
	EXECUTE METHOD:C1007($methodName)
	
	D00_lstT_make
	
	JCL_lst_SetSelect_byLong(->vD00_lstT; ->vD00_lstT_nr; $nr)
	
	//フィールド一覧の色を更新
	C_LONGINT:C283($color)
	$color:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_Color)
	If ($color=0)
		$color:=0x00FFFFFF
	End if 
	OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; $color)
	
	D00_SetControlsValues
	
End if 
