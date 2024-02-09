//KV02_SetControlsValues
//FG v202103 2024/02/09 18:05:58
//Z_KeyValue フォーム上のオブジェクト制御

C_TEXT($mode)

//削除ボタン制御

$mode:=KV02_varMode_Get 
If ($mode="add")

vKV02_varTitle:="Z_KeyValue 入力"
JCL_btn_SetVisible (->vKV02_btnDelete;False)

Else 

vKV02_varTitle:="Z_KeyValue 編集"
JCL_btn_SetVisible (->vKV02_btnDelete;True)

End if 
