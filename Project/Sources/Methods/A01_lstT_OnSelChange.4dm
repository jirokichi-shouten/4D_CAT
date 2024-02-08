//%attributes = {}
//A01_lstT_OnSelChange
//20240204 wat
//選択行が変わった

C_LONGINT:C283($tblNr)

//テーブル名
$tblNr:=JCL_lst_Selected_Long(->vA01_lstT; ->vA01_lstT_nr)

//配列初期化
DELETE FROM ARRAY:C228(vA01_lstFL_NAME; 1; Size of array:C274(vA01_lstFL_NAME))
DELETE FROM ARRAY:C228(vA01_lstFL_LABEL; 1; Size of array:C274(vA01_lstFL_LABEL))
DELETE FROM ARRAY:C228(vA01_lstFL_DATA_TYPE; 1; Size of array:C274(vA01_lstFL_DATA_TYPE))

DELETE FROM ARRAY:C228(vA01_lstFL_LENGTH; 1; Size of array:C274(vA01_lstFL_LENGTH))
DELETE FROM ARRAY:C228(vA01_lstFL_INDEX; 1; Size of array:C274(vA01_lstFL_INDEX))
DELETE FROM ARRAY:C228(vA01_lstFL_UNIQUE; 1; Size of array:C274(vA01_lstFL_UNIQUE))
DELETE FROM ARRAY:C228(vA01_lstFL_COMMENT; 1; Size of array:C274(vA01_lstFL_COMMENT))
DELETE FROM ARRAY:C228(vA01_lstFL_REMARK; 1; Size of array:C274(vA01_lstFL_REMARK))

//フィールド配列作成
A01_lstFL_make($tblNr)

A01_SetControlsValues
