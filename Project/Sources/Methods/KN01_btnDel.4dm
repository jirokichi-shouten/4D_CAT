//KN01_btnDel
//FG v202103 2024/02/09 18:04:40
//Z_KeyNValue リストボックスの選択行を複数削除 確認ダイアログを表示

C_LONGINT($KN_id)
$KN_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vKN01_lstKN)
If ($selCnt>=1)//リストボックスに選択行があれば

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="Z_KeyNValue 削除"
$msg:=String($selCnt)+"件の Z_KeyNValue を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)
If ($dlg_ok=1)

KN01_DeleteSelectedItems //複数削除

KN01_lstKN_Make //テーブルからリロード

//選択状態をなしにする
JCL_lst_Deselect (->vKN01_lstKN)

KN01_SetControlsValues 

End if 
End if 
