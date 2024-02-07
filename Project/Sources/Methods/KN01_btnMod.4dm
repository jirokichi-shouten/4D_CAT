//KN01_btnMod
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue リストボックスの選択行を編集 入力フォームを編集モードで表示

C_LONGINT($KN_id)
$KN_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vKN01_lstKN)
If ($selCnt>=1)//リストボックスに選択行があれば

$KN_id:=JCL_lst_Selected_Long (->vKN01_lstKN;->vKN01_lstKN_ID)

$dlg_ok:=KN02_Input_Mod ($KN_id)//入力フォームを開く
If ($dlg_ok=1)

KN01_lstKN_Make //テーブルからリロード

//変更行を選択状態にする
JCL_lst_SetSelect_byLong (->vKN01_lstKN;->vKN01_lstKN_ID;$KN_id)

KN01_SetControlsValues 

End if 

End if 
