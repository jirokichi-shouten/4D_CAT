//US02_SetControlsValues
//FG v202103 2024/02/11 21:23:57
//USERS フォーム上のオブジェクト制御

C_TEXT($mode)

//削除ボタン制御

$mode:=US02_varMode_Get 
If ($mode="add")

vUS02_varTitle:="USERS 入力"
JCL_btn_SetVisible (->vUS02_btnDelete;False)

Else 

vUS02_varTitle:="USERS 編集"
JCL_btn_SetVisible (->vUS02_btnDelete;True)

End if 
