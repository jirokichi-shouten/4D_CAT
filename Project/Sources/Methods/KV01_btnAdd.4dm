//KV01_btnAdd
//FG v202103 2024/02/09 18:05:58
//Z_KeyValue 入力フォームを新規モードで表示

C_LONGINT($KV_id)
$KV_id:=0//IDを初期化
C_LONGINT($display_ok)

//入力フォームを開く
$display_ok:=KV02_Input_Add (->$KV_id)
If ($display_ok=1)

KV01_lstKV_Make //テーブルからリロード

//変更・追加の行を選択状態にする
JCL_lst_SetSelect_byLong (->vKV01_lstKV;->vKV01_lstKV_ID;$KV_id)

KV01_SetControlsValues 

End if 
