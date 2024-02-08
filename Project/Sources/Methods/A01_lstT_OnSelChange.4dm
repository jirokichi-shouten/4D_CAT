//%attributes = {}
//A01_lstT_OnSelChange
//20240204 wat
//選択行が変わった

C_LONGINT:C283($tblNr)
C_LONGINT:C283($color)
$color:=0x00FFFFFF

//テーブル名
$tblNr:=JCL_lst_Selected_Long(->vA01_lstT; ->vA01_lstT_nr)
//配列初期化
DELETE FROM ARRAY:C228(vA01_lstFL_Nr; 1; Size of array:C274(vA01_lstFL_Nr))
DELETE FROM ARRAY:C228(vA01_lstFL_NAME; 1; Size of array:C274(vA01_lstFL_NAME))
DELETE FROM ARRAY:C228(vA01_lstFL_LABEL; 1; Size of array:C274(vA01_lstFL_LABEL))
DELETE FROM ARRAY:C228(vA01_lstFL_DATA_TYPE; 1; Size of array:C274(vA01_lstFL_DATA_TYPE))

DELETE FROM ARRAY:C228(vA01_lstFL_LENGTH; 1; Size of array:C274(vA01_lstFL_LENGTH))
DELETE FROM ARRAY:C228(vA01_lstFL_INDEX; 1; Size of array:C274(vA01_lstFL_INDEX))
DELETE FROM ARRAY:C228(vA01_lstFL_UNIQUE; 1; Size of array:C274(vA01_lstFL_UNIQUE))
DELETE FROM ARRAY:C228(vA01_lstFL_COMMENT; 1; Size of array:C274(vA01_lstFL_COMMENT))
DELETE FROM ARRAY:C228(vA01_lstFL_REMARK; 1; Size of array:C274(vA01_lstFL_REMARK))

OBJECT SET RGB COLORS:C628(*; "vA01_varTableName"; 0; Background color none:K23:10)

If ($tblNr>0)
	//フィールド配列作成
	A01_lstFL_make($tblNr)
	
	//色を付ける
	$color:=JCL_lst_Selected_Long(->vA01_lstT; ->vA01_lstT_Color)
	OBJECT SET RGB COLORS:C628(*; "vA01_varTableName"; 0; $color)
	
	
	A01_SetControlsValues
	
End if 
