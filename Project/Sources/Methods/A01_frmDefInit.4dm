//%attributes = {}
//A01_frmDefInit
//20240204 wat
//フォームオブジェクトを宣言、初期化

C_OBJECT:C1216($fullpath)
$fullpath:=Path to object:C1547(Structure file:C489)

C_TEXT:C284(vA00_varProductName; vA00_varVersion)
vA00_varProductName:=$fullpath.name
vA00_varVersion:="0.9(1) 20240204"

C_TEXT:C284(vA01_var4D_DataFile)
vA01_var4D_DataFile:="データファイル："+Data file:C490

//テーブルリストボックス
ARRAY BOOLEAN:C223(vA01_lstT; 0)  //リストボックス自身
ARRAY LONGINT:C221(vA01_lstT_nr; 0)
ARRAY TEXT:C222(vA01_lstT_name; 0)
ARRAY LONGINT:C221(vA01_lstT_numOfRecs; 0)

C_TEXT:C284(vA01_txtNumOfRecs)

//配列初期化
DELETE FROM ARRAY:C228(vA01_lstT; 1; Size of array:C274(vA01_lstT))
DELETE FROM ARRAY:C228(vA01_lstT_nr; 1; Size of array:C274(vA01_lstT_nr))
DELETE FROM ARRAY:C228(vA01_lstT_name; 1; Size of array:C274(vA01_lstT_name))
DELETE FROM ARRAY:C228(vA01_lstT_numOfRecs; 1; Size of array:C274(vA01_lstT_numOfRecs))
