//PR01_DeleteSelectedItems
//PR01_DeleteNSelected
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS リストボックスの選択行を複数削除

C_LONGINT($0;$selCnt)
C_LONGINT($i)
C_LONGINT($PR_id)
ARRAY LONGINT($aryPR_ID;0)

READ WRITE([PASSWORD_RESETS])

// 選択されている行のIDを配列に取得
$selCnt:=JCL_lst_SelectedValues (->vPR01_lstPR;->vPR01_lstPR_ID;->$aryPR_ID)
For ($i;1;$selCnt)

// レコードを取得
$PR_id:=$aryPR_ID{$i}
QUERY([PASSWORD_RESETS];[PASSWORD_RESETS]PR_ID=$PR_id)
FIRST RECORD([PASSWORD_RESETS])

// 削除フラグをオン
[PASSWORD_RESETS]PR_DEL_FLAG:=1

// レコードを保存
SAVE RECORD([PASSWORD_RESETS])

End for 

UNLOAD RECORD([PASSWORD_RESETS])
READ ONLY([PASSWORD_RESETS])

$0:=$selCnt
