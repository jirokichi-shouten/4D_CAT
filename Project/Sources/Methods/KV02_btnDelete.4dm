//KV02_btnDelete
//FG v202103 2024/02/07 21:01:46
//Z_KeyValue 削除フラグをオンして保存

//アラートで確認
C_TEXT($title;$msg;$okStr;$cancelStr)
$title:="Z_KeyValue 削除"
$msg:="Z_KeyValue を削除します。よろしいですか？"
$okStr:="削除"
$cancelStr:="キャンセル"
$dlg_ok:=JCL_dlg_YesNo ($title;$msg;$okStr;$cancelStr)

if ($dlg_ok=1)

vKV02_varKV_DEL_FLAG:=1

ACCEPT

end if