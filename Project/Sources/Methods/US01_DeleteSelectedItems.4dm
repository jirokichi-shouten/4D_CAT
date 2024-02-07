//US01_DeleteSelectedItems
//US01_DeleteNSelected
//FG v202103 2024/02/07 17:24:49
//USERS リストボックスの選択行を複数削除

C_LONGINT($0;$selCnt)
C_LONGINT($i)
C_LONGINT($US_id)
ARRAY LONGINT($aryUS_ID;0)

READ WRITE([USERS])

// 選択されている行のIDを配列に取得
$selCnt:=JCL_lst_SelectedValues (->vUS01_lstUS;->vUS01_lstUS_ID;->$aryUS_ID)
For ($i;1;$selCnt)

// レコードを取得
$US_id:=$aryUS_ID{$i}
QUERY([USERS];[USERS]US_ID=$US_id)
FIRST RECORD([USERS])

// 削除フラグをオン
[USERS]US_DEL_FLAG:=1

// レコードを保存
SAVE RECORD([USERS])

End for 

UNLOAD RECORD([USERS])
READ ONLY([USERS])

$0:=$selCnt
