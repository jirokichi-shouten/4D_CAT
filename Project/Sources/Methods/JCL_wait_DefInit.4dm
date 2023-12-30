//%attributes = {}
//JCL_wait_DefInit
//20111127 wat
//プログレスバー関連のグローバル変数を宣言・初期化
// プログレスバー関連 20080605add_yabe

C_BOOLEAN:C305(<>JCL_D91_Cancel)
<>JCL_D91_Cancel:=False:C215

C_TEXT:C284(<>JCL_D91_Msg)
<>JCL_D91_Msg:=""

C_TEXT:C284(<>JCL_D91_Count)
<>JCL_D91_Count:=""
