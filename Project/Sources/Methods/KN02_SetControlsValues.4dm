//KN02_SetControlsValues
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue フォーム上のオブジェクト制御

C_TEXT($mode)

//削除ボタン制御

$mode:=KN02_varMode_Get 
If ($mode="add")

vKN02_varTitle:="Z_KeyNValue 入力"
JCL_btn_SetVisible (->vKN02_btnDelete;False)

Else 

vKN02_varTitle:="Z_KeyNValue 編集"
JCL_btn_SetVisible (->vKN02_btnDelete;True)

End if 
