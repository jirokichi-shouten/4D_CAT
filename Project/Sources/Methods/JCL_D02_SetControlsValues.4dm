//%attributes = {}
//JCL_D02_SetControlsValues
//20240121 yabe wat

////テーブル　リストボックスに色付
//C_LONGINT($i; $sizeOfAry)
//C_LONGINT($red)
//$red:=JCL_num_GetRGB(255; 0; 0)


//$sizeOfAry:=Size of array(vJCL_D02_lstTB_status)
//For ($i; 1; $sizeOfAry)

//vJCL_D20_lstTB_FontColor{$i}:=$red

//End for 
