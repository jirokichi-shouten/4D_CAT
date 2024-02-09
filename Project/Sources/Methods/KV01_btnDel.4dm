//KV01_btnDel
//FG v202103 2024/02/09 18:05:58
//Z_KeyValue リストボックスの選択行を複数削除 確認ダイアログを表示

C_LONGINT($KV_id)
$KV_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vKV01_lstKV)
If ($selCnt>=1)//リストボックスに選択行があれば

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="Z_KeyValue 削除"
$msg:=String($selCnt)+"件の Z_KeyValue を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)
If ($dlg_ok=1)

KV01_DeleteSelectedItems //複数削除

KV01_lstKV_Make //テーブルからリロード

//選択状態をなしにする
JCL_lst_Deselect (->vKV01_lstKV)

KV01_SetControlsValues 

End if 
End if 
