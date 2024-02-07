//KN01_SetControlsValues
//FG v202103 2024/02/07 21:00:49
//Z_KeyNValue フォームオブジェクトを制御

//リストボックスの選択行が１つの時に編集ボタンはイネイブル
JCL_btn_SetEnable_byListSelect (->vKN01_lstKN;->vKN01_btnMod)

//リストボックスの選択行が１つ以上の時に削除ボタンはイネイブル
JCL_btn_SetEnable_byNSelect (->vKN01_lstKN;->vKN01_btnDel)

  //件数表示
vKN01_varNumOfRecs:=String(Size of array(vKN01_lstKN_ID);"#,###,###,##0")+"件"
