//%attributes = {"shared":true}
//JCL_pgs_DefInit
//20111127 wat
//プログレスバー関連のグローバル変数を宣言・初期化
// プログレスバー関連 20080605add_yabe

C_LONGINT:C283(<>JCL_D90_Meter)  //プログレスバー
<>JCL_D90_Meter:=0

C_BOOLEAN:C305(<>JCL_D90_Cancel)
<>JCL_D90_Cancel:=False:C215

C_TEXT:C284(<>JCL_D90_Msg)
<>JCL_D90_Msg:=""

C_TEXT:C284(<>JCL_D90_Count)
<>JCL_D90_Count:=""
