//US01_btnMod
//FG v202103 2024/02/09 18:06:20
//USERS リストボックスの選択行を編集 入力フォームを編集モードで表示

C_LONGINT($US_id)
$US_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vUS01_lstUS)
If ($selCnt>=1)//リストボックスに選択行があれば

$US_id:=JCL_lst_Selected_Long (->vUS01_lstUS;->vUS01_lstUS_ID)

$dlg_ok:=US02_Input_Mod ($US_id)//入力フォームを開く
If ($dlg_ok=1)

US01_lstUS_Make //テーブルからリロード

//変更行を選択状態にする
JCL_lst_SetSelect_byLong (->vUS01_lstUS;->vUS01_lstUS_ID;$US_id)

US01_SetControlsValues 

End if 

End if 
