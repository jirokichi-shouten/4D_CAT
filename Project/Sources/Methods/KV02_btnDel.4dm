//KV02_btnDel
//FG v202402 2024/02/09 18:05:59
//Z_KeyValue 削除フラグをオンして保存

C_LONGINT($KV_id)

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="Z_KeyValue 削除"
$msg:="Z_KeyValue を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)
//IDを取得
vKV_id:=KV02_varKV_ID_get

//削除フラグを保存
READ WRITE([Z_KeyValue])
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
[Z_KeyValue]KV_DEL_FLAG:=1
SAVE RECORD([Z_KeyValue])

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

ACCEPT

end if
