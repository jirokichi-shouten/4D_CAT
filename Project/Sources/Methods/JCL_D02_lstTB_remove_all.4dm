//%attributes = {}
//JCL_D02_lstTB_remove_all
//20240121 wat
//テンポラリーのfields行を削除

//配列から削除
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_status; 1; Size of array:C274(vJCL_D02_lstTB_status))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_error; 1; Size of array:C274(vJCL_D02_lstTB_error))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NAME; 1; Size of array:C274(vJCL_D02_lstTB_NAME))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_PREFIX; 1; Size of array:C274(vJCL_D02_lstTB_PREFIX))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NO_FORM; 1; Size of array:C274(vJCL_D02_lstTB_NO_FORM))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_LABEL; 1; Size of array:C274(vJCL_D02_lstTB_LABEL))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_DESCRIPTION; 1; Size of array:C274(vJCL_D02_lstTB_DESCRIPTION))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_REMARK; 1; Size of array:C274(vJCL_D02_lstTB_REMARK))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_Block; 1; Size of array:C274(vJCL_D02_lstTB_Block))

DELETE FROM ARRAY:C228(vJCL_D20_lstTB_BakColor; 1; Size of array:C274(vJCL_D20_lstTB_BakColor))
DELETE FROM ARRAY:C228(vJCL_D20_lstTB_FontColor; 1; Size of array:C274(vJCL_D20_lstTB_FontColor))
