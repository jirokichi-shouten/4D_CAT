//PR01_btnDup 
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS 複製

C_LONGINT($PR_id;$new_PR_id)
$PR_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vPR01_lstPR)
If ($selCnt>=1)//リストボックスに選択行があれば

$PR_id:=JCL_lst_Selected_Long (->vPR01_lstPR;->vPR01_lstPR_ID)

$dlg_ok:=PR02_Input_Dup ($PR_id;->$new_PR_id)//入力フォームを開く
If ($dlg_ok=1)

PR01_lstPR_Make //テーブルからリロード

//変更行を選択状態にする
JCL_lst_SetSelect_byLong (->vPR01_lstPR;->vPR01_lstPR_ID;$new_PR_id)

PR01_SetControlsValues 

End if 

End if 
