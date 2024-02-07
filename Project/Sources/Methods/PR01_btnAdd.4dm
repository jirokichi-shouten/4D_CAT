//PR01_btnAdd
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS 入力フォームを新規モードで表示

C_LONGINT($PR_id)
$PR_id:=0//IDを初期化
C_LONGINT($display_ok)

//入力フォームを開く
$display_ok:=PR02_Input_Add (->$PR_id)
If ($display_ok=1)

PR01_lstPR_Make //テーブルからリロード

//変更・追加の行を選択状態にする
JCL_lst_SetSelect_byLong (->vPR01_lstPR;->vPR01_lstPR_ID;$PR_id)

PR01_SetControlsValues 

End if 
