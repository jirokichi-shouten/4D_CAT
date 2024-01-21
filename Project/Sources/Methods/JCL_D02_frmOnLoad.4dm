//%attributes = {}
//JCL_D02_frmOnLoad
//20240116 wat
//オンロード

//frmDefInit
C_TEXT:C284(vJCL_D02_txtTitle)
OBJECT SET TITLE:C194(*; "vJCL_D02_txtTitle"; "fields.txt")

C_TEXT:C284(vJCL_D02_varTableName)
vJCL_D02_varTableName:=""
C_TEXT:C284(vJCL_D02_varNumOfTables)
C_TEXT:C284(vJCL_D02_varNumOfFields)

// リストボックス用配列
ARRAY BOOLEAN:C223(vJCL_D02_lstFL; 0)  //リストボックス自身
ARRAY TEXT:C222(vJCL_D02_lstFL_NAME; 0)
ARRAY TEXT:C222(vJCL_D02_lstFL_LABEL; 0)
ARRAY TEXT:C222(vJCL_D02_lstFL_DATA_TYPE; 0)

ARRAY LONGINT:C221(vJCL_D02_lstFL_LENGTH; 0)
ARRAY LONGINT:C221(vJCL_D02_lstFL_INDEX; 0)
ARRAY LONGINT:C221(vJCL_D02_lstFL_UNIQUE; 0)
ARRAY TEXT:C222(vJCL_D02_lstFL_COMMENT; 0)
ARRAY TEXT:C222(vJCL_D02_lstFL_REMARK; 0)

//テーブル　リストボックス用配列
ARRAY BOOLEAN:C223(vJCL_D02_lstTB; 0)  //リストボックス自身
ARRAY TEXT:C222(vJCL_D02_lstTB_status; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_error; 0)  //エラー表示用
ARRAY TEXT:C222(vJCL_D02_lstTB_NAME; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_PREFIX; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_NO_FORM; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_LABEL; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_DESCRIPTION; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_REMARK; 0)
ARRAY TEXT:C222(vJCL_D02_lstTB_Block; 0)
ARRAY LONGINT:C221(vJCL_D20_lstTB_BakColor; 0)
ARRAY LONGINT:C221(vJCL_D20_lstTB_FontColor; 0)
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_status; 1; Size of array:C274(vJCL_D02_lstTB_status))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_error; 1; Size of array:C274(vJCL_D02_lstTB_error))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_LABEL; 1; Size of array:C274(vJCL_D02_lstTB_LABEL))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_NAME; 1; Size of array:C274(vJCL_D02_lstTB_NAME))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_PREFIX; 1; Size of array:C274(vJCL_D02_lstTB_PREFIX))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_DESCRIPTION; 1; Size of array:C274(vJCL_D02_lstTB_DESCRIPTION))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_REMARK; 1; Size of array:C274(vJCL_D02_lstTB_REMARK))
DELETE FROM ARRAY:C228(vJCL_D02_lstTB_Block; 1; Size of array:C274(vJCL_D02_lstTB_Block))
DELETE FROM ARRAY:C228(vJCL_D20_lstTB_BakColor; 1; Size of array:C274(vJCL_D20_lstTB_BakColor))
DELETE FROM ARRAY:C228(vJCL_D20_lstTB_FontColor; 1; Size of array:C274(vJCL_D20_lstTB_FontColor))

//load values
C_LONGINT:C283($i; $sizeOfAry)
ARRAY TEXT:C222($aryBlocks; 0)
JCL_D02_fields_load(->$aryBlocks)
$sizeOfAry:=Size of array:C274($aryBlocks)
For ($i; 1; $sizeOfAry)
	//テーブル情報
	JCL_D02_lstTB_make($aryBlocks{$i}; "exist")
	
	//フィールド情報
	//JCL_D02_lstFL_make($aryBlocks$i})
	
End for 

vJCL_D02_varNumOfTables:="テーブル数："+String:C10($sizeOfAry)
vJCL_D02_varNumOfFields:="フィールド数："+String:C10(Size of array:C274(vJCL_D02_lstFL_NAME))

JCL_D02_SetControlsValues
