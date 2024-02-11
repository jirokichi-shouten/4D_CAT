//US01_btnAdd
//FG v202103 2024/02/11 21:23:57
//USERS 入力フォームを新規モードで表示

C_LONGINT($US_id)
$US_id:=0//IDを初期化
C_LONGINT($display_ok)

//入力フォームを開く
$display_ok:=US02_Input_Add (->$US_id)
If ($display_ok=1)

US01_lstUS_Make //テーブルからリロード

//変更・追加の行を選択状態にする
JCL_lst_SetSelect_byLong (->vUS01_lstUS;->vUS01_lstUS_ID;$US_id)

US01_SetControlsValues 

End if 
