//KN01_btnAdd
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue 入力フォームを新規モードで表示

C_LONGINT($KN_id)
$KN_id:=0//IDを初期化
C_LONGINT($display_ok)

//入力フォームを開く
$display_ok:=KN02_Input_Add (->$KN_id)
If ($display_ok=1)

KN01_lstKN_Make //テーブルからリロード

//変更・追加の行を選択状態にする
JCL_lst_SetSelect_byLong (->vKN01_lstKN;->vKN01_lstKN_ID;$KN_id)

KN01_SetControlsValues 

End if 
