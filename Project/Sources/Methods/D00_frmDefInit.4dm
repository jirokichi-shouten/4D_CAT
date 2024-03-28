//%attributes = {}
//D00_frmDefInit
//20240204 wat
//フォームオブジェクトを宣言、初期化

C_OBJECT:C1216($fullpath)
$fullpath:=Path to object:C1547(Structure file:C489)

C_TEXT:C284(vD00_varProductName; vD00_varVersion)
vD00_varProductName:=$fullpath.name
vD00_varVersion:="0.9(1) 20240204"
vD00_varVersion:="0.9(2) 20240211"
vD00_varVersion:="1.0(3) 20240304"

C_TEXT:C284(vD00_var4D_DataFile)
vD00_var4D_DataFile:="データファイル："+Data file:C490

//テーブルリストボックス
ARRAY BOOLEAN:C223(vD00_lstT; 0)  //リストボックス自身
ARRAY LONGINT:C221(vD00_lstT_nr; 0)
ARRAY TEXT:C222(vD00_lstT_name; 0)
ARRAY TEXT:C222(vD00_lstT_label; 0)
ARRAY TEXT:C222(vD00_lstT_prefix; 0)
ARRAY LONGINT:C221(vD00_lstT_numOfRecs; 0)
ARRAY LONGINT:C221(vD00_lstT_Color; 0)

C_TEXT:C284(vD00_txtNumOfTables)

C_TEXT:C284(vD00_varTableName)

//フィールドリストボックス
ARRAY BOOLEAN:C223(vD00_lstFL; 0)  //リストボックス自身
ARRAY LONGINT:C221(vD00_lstFL_Nr; 0)
ARRAY TEXT:C222(vD00_lstFL_NAME; 0)
ARRAY TEXT:C222(vD00_lstFL_LABEL; 0)
ARRAY TEXT:C222(vD00_lstFL_DATA_TYPE; 0)

ARRAY LONGINT:C221(vD00_lstFL_LENGTH; 0)
ARRAY BOOLEAN:C223(vD00_lstFL_INDEX; 0)
ARRAY BOOLEAN:C223(vD00_lstFL_UNIQUE; 0)
ARRAY BOOLEAN:C223(vD00_lstFL_INVISIBLE; 0)
ARRAY TEXT:C222(vD00_lstFL_COMMENT; 0)
ARRAY TEXT:C222(vD00_lstFL_REMARK; 0)

C_TEXT:C284(vD00_varNumOfFields)
