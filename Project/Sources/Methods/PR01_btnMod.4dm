//PR01_btnMod
//FG v202103 2024/02/11 21:27:48
//PASSWORD_RESETS リストボックスの選択行を編集 入力フォームを編集モードで表示

C_LONGINT($PR_id)
$PR_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vPR01_lstPR)
If ($selCnt>=1)//リストボックスに選択行があれば

$PR_id:=JCL_lst_Selected_Long (->vPR01_lstPR;->vPR01_lstPR_ID)

$dlg_ok:=PR02_Input_Mod ($PR_id)//入力フォームを開く
If ($dlg_ok=1)

PR01_lstPR_Make //テーブルからリロード

//変更行を選択状態にする
JCL_lst_SetSelect_byLong (->vPR01_lstPR;->vPR01_lstPR_ID;$PR_id)

PR01_SetControlsValues 

End if 

End if 
