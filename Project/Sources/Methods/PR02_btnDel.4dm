//PR02_btnDel
//FG v202402 2024/02/07 20:50:34
//PASSWORD_RESETS 削除フラグをオンして保存

C_LONGINT($PR_id)

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="PASSWORD_RESETS 削除"
$msg:="PASSWORD_RESETS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)
//IDを取得
vPR_id:=PR02_varPR_ID_get

//削除フラグを保存
READ WRITE([PASSWORD_RESETS])
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
[PASSWORD_RESETS]PR_DEL_FLAG:=1
SAVE RECORD([PASSWORD_RESETS])

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

ACCEPT

end if
