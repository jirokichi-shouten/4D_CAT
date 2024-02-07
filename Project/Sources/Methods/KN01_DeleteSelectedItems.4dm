//KN01_DeleteSelectedItems
//KN01_DeleteNSelected
//FG v202103 2024/02/07 21:00:49
//Z_KeyNValue リストボックスの選択行を複数削除

C_LONGINT($0;$selCnt)
C_LONGINT($i)
C_LONGINT($KN_id)
ARRAY LONGINT($aryKN_ID;0)

READ WRITE([Z_KeyNValue])

// 選択されている行のIDを配列に取得
$selCnt:=JCL_lst_SelectedValues (->vKN01_lstKN;->vKN01_lstKN_ID;->$aryKN_ID)
For ($i;1;$selCnt)

// レコードを取得
$KN_id:=$aryKN_ID{$i}
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
FIRST RECORD([Z_KeyNValue])

// 削除フラグをオン
[Z_KeyNValue]KN_DEL_FLAG:=1

// レコードを保存
SAVE RECORD([Z_KeyNValue])

End for 

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

$0:=$selCnt
