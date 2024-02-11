//US02_btnDelete
//FG v202103 2024/02/11 21:23:57
//USERS 削除フラグをオンして保存

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="USERS 削除"
$msg:="USERS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)

vUS02_varUS_DEL_FLAG:=1

ACCEPT

end if
