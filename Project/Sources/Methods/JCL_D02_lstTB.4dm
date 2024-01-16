//%attributes = {}
//JCL_D02_lstTB
//20240116 wat
//テーブル　リストボックス

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Selection Change:K2:29)
		//テーブル名
		vJCL_D02_varTableName:=JCL_lst_Selected_Str(->vJCL_D02_lstTB; ->vJCL_D02_lstTB_NAME)
		
		//フィールド情報ブロックを取得、リストボックスに保持させてある
		$fieldBlock:=JCL_lst_Selected_Str(->vJCL_D02_lstTB; ->vJCL_D02_lstTB_Block)
		
		//配列初期化
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_NAME; 1; Size of array:C274(vJCL_D02_lstFL_NAME))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_LABEL; 1; Size of array:C274(vJCL_D02_lstFL_LABEL))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_DATA_TYPE; 1; Size of array:C274(vJCL_D02_lstFL_DATA_TYPE))
		
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_LENGTH; 1; Size of array:C274(vJCL_D02_lstFL_LENGTH))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_INDEX; 1; Size of array:C274(vJCL_D02_lstFL_INDEX))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_UNIQUE; 1; Size of array:C274(vJCL_D02_lstFL_UNIQUE))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_COMMENT; 1; Size of array:C274(vJCL_D02_lstFL_COMMENT))
		DELETE FROM ARRAY:C228(vJCL_D02_lstFL_REMARK; 1; Size of array:C274(vJCL_D02_lstFL_REMARK))
		
		//フィールド配列作成
		JCL_D02_lstFL_make($fieldBlock)
		
End case 
