//%attributes = {}
//D00_lstT_OnSelChange
//20240204 wat
//選択行が変わった

C_LONGINT:C283($tblNr)

//テーブル名
$tblNr:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_nr)
//配列初期化
DELETE FROM ARRAY:C228(vD00_lstFL_Nr; 1; Size of array:C274(vD00_lstFL_Nr))
DELETE FROM ARRAY:C228(vD00_lstFL_NAME; 1; Size of array:C274(vD00_lstFL_NAME))
DELETE FROM ARRAY:C228(vD00_lstFL_LABEL; 1; Size of array:C274(vD00_lstFL_LABEL))
DELETE FROM ARRAY:C228(vD00_lstFL_DATA_TYPE; 1; Size of array:C274(vD00_lstFL_DATA_TYPE))

DELETE FROM ARRAY:C228(vD00_lstFL_LENGTH; 1; Size of array:C274(vD00_lstFL_LENGTH))
DELETE FROM ARRAY:C228(vD00_lstFL_INDEX; 1; Size of array:C274(vD00_lstFL_INDEX))
DELETE FROM ARRAY:C228(vD00_lstFL_UNIQUE; 1; Size of array:C274(vD00_lstFL_UNIQUE))
DELETE FROM ARRAY:C228(vD00_lstFL_COMMENT; 1; Size of array:C274(vD00_lstFL_COMMENT))
DELETE FROM ARRAY:C228(vD00_lstFL_REMARK; 1; Size of array:C274(vD00_lstFL_REMARK))

OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; Background color none:K23:10)

If ($tblNr>0)
	//フィールド配列作成
	D00_lstFL_make($tblNr)
	
	//色を付ける
	C_LONGINT:C283($color)
	$color:=JCL_lst_Selected_Long(->vD00_lstT; ->vD00_lstT_Color)
	If ($color=0)
		$color:=0x00FFFFFF
	End if 
	OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; $color)
	
Else 
	//選択行なし状態
	$color:=0x00FFFFFF
	OBJECT SET RGB COLORS:C628(*; "vD00_varTableName"; 0; $color)
	
	vD00_varTableName:=""
	
End if 

D00_SetControlsValues
