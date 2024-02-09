//US02_btnDel
//FG v202402 2024/02/09 18:06:20
//USERS 削除フラグをオンして保存

C_LONGINT($US_id)

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="USERS 削除"
$msg:="USERS を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)
//IDを取得
vUS_id:=US02_varUS_ID_get

//削除フラグを保存
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
[USERS]US_DEL_FLAG:=1
SAVE RECORD([USERS])

UNLOAD RECORD([USERS])
READ ONLY([USERS])

ACCEPT

end if
