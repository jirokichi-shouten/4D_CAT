//KV01_DeleteSelectedItems
//KV01_DeleteNSelected
//FG v202103 2024/02/07 17:31:34
//Z_KeyValue リストボックスの選択行を複数削除

C_LONGINT($0;$selCnt)
C_LONGINT($i)
C_LONGINT($KV_id)
ARRAY LONGINT($aryKV_ID;0)

READ WRITE([Z_KeyValue])

// 選択されている行のIDを配列に取得
$selCnt:=JCL_lst_SelectedValues (->vKV01_lstKV;->vKV01_lstKV_ID;->$aryKV_ID)
For ($i;1;$selCnt)

// レコードを取得
$KV_id:=$aryKV_ID{$i}
QUERY([Z_KeyValue];[Z_KeyValue]KV_ID=$KV_id)
FIRST RECORD([Z_KeyValue])

// 削除フラグをオン
[Z_KeyValue]KV_DEL_FLAG:=1

// レコードを保存
SAVE RECORD([Z_KeyValue])

End for 

UNLOAD RECORD([Z_KeyValue])
READ ONLY([Z_KeyValue])

$0:=$selCnt
