//PR01_btnDel
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS リストボックスの選択行を複数削除 確認ダイアログを表示

C_LONGINT($PR_id)
$PR_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vPR01_lstPR)
If ($selCnt>=1)//リストボックスに選択行があれば

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="PASSWORD_RESETS 削除"
$msg:=String($selCnt)+"件の PASSWORD_RESETS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)
If ($dlg_ok=1)

PR01_DeleteSelectedItems //複数削除

PR01_lstPR_Make //テーブルからリロード

//選択状態をなしにする
JCL_lst_Deselect (->vPR01_lstPR)

PR01_SetControlsValues 

End if 
End if 
