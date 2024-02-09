//US01_btnDel
//FG v202103 2024/02/09 18:06:20
//USERS リストボックスの選択行を複数削除 確認ダイアログを表示

C_LONGINT($US_id)
$US_id:=0
C_LONGINT($selCnt)
C_LONGINT($dlg_ok)//システム変数OKを保持

$selCnt:=JCL_lst_SelectedCount (->vUS01_lstUS)
If ($selCnt>=1)//リストボックスに選択行があれば

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="USERS 削除"
$msg:=String($selCnt)+"件の USERS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)
If ($dlg_ok=1)

US01_DeleteSelectedItems //複数削除

US01_lstUS_Make //テーブルからリロード

//選択状態をなしにする
JCL_lst_Deselect (->vUS01_lstUS)

US01_SetControlsValues 

End if 
End if 
