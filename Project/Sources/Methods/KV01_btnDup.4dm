//KV01_btnDup 
//FG v202103 2024/02/09 18:05:58
//Z_KeyValue 複製

//C_LONGINT($KV_id;$new_KV_id)
//$KV_id:=0
//C_LONGINT($selCnt)
//C_LONGINT($dlg_ok)//システム変数OKを保持

//$selCnt:=JCL_lst_SelectedCount (->vKV01_lstKV)
//If ($selCnt>=1)//リストボックスに選択行があれば

//$KV_id:=JCL_lst_Selected_Long (->vKV01_lstKV;->vKV01_lstKV_ID)

//$dlg_ok:=KV02_Input_Dup ($KV_id;->$new_KV_id)//入力フォームを開く
//If ($dlg_ok=1)

//KV01_lstKV_Make //テーブルからリロード

//変更行を選択状態にする
//JCL_lst_SetSelect_byLong (->vKV01_lstKV;->vKV01_lstKV_ID;$new_KV_id)

//KV01_SetControlsValues 

//End if 

//End if 
