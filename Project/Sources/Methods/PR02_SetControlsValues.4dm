//PR02_SetControlsValues
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS フォーム上のオブジェクト制御

C_TEXT($mode)

//削除ボタン制御

$mode:=PR02_varMode_Get 
If ($mode="add")

vPR02_varTitle:="PASSWORD_RESETS 入力"
JCL_btn_SetVisible (->vPR02_btnDelete;False)

Else 

vPR02_varTitle:="PASSWORD_RESETS 編集"
JCL_btn_SetVisible (->vPR02_btnDelete;True)

End if 
