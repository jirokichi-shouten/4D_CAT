//KN02_btnDel
//FG v202402 2024/02/09 18:04:40
//Z_KeyNValue 削除フラグをオンして保存

C_LONGINT($KN_id)

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="Z_KeyNValue 削除"
$msg:="Z_KeyNValue を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)
//IDを取得
vKN_id:=KN02_varKN_ID_get

//削除フラグを保存
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
[Z_KeyNValue]KN_DEL_FLAG:=1
SAVE RECORD([Z_KeyNValue])

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

ACCEPT

end if
