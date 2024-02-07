//PR02_btnDelete
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS 削除フラグをオンして保存

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="PASSWORD_RESETS 削除"
$msg:="PASSWORD_RESETS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)

vPR02_varPR_DEL_FLAG:=1

ACCEPT

end if
