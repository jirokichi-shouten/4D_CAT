//KV01_btnMod
//FG v202103 2024/02/07 21:01:46
//Z_KeyValue リストボックスの選択行を編集 入力フォームを編集モードで表示

C_LONGINT($KV_id)
$KV_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vKV01_lstKV)
If ($selCnt>=1)//リストボックスに選択行があれば

$KV_id:=JCL_lst_Selected_Long (->vKV01_lstKV;->vKV01_lstKV_ID)

$dlg_ok:=KV02_Input_Mod ($KV_id)//入力フォームを開く
If ($dlg_ok=1)

KV01_lstKV_Make //テーブルからリロード

//変更行を選択状態にする
JCL_lst_SetSelect_byLong (->vKV01_lstKV;->vKV01_lstKV_ID;$KV_id)

KV01_SetControlsValues 

End if 

End if 
