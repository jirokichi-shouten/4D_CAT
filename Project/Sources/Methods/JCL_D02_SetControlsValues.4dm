//%attributes = {}
//JCL_D02_SetControlsValues
//20240121 yabe wat

//テーブル　リストボックスに色付
C_LONGINT:C283($i; $sizeOfAry)
C_LONGINT:C283($red)
$red:=JCL_num_GetRGB(255; 0; 0)

//$sizeOfAry:=Size ?OfAry)
//ステータスで未作成を判断
//$status:=vJCL_D02_lstTB_status{$i}
//If ($status="temporary")
//APPEND TO ARRAY(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
//APPEND TO ARRAY(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(255; 0; 0))  // フォントカラー
//Else 
//APPEND TO ARRAY(vJCL_D20_lstTB_BakColor; JCL_num_GetRGB(255; 255; 255))  // 背景色
//APPEND TO ARRAY(vJCL_D20_lstTB_FontColor; JCL_num_GetRGB(0; 0; 0))  // フォントカラー
//End if 

//End for 
