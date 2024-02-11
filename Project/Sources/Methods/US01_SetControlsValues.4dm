//US01_SetControlsValues
//FG v202103 2024/02/11 21:23:57
//USERS フォームオブジェクトを制御

//リストボックスの選択行が１つの時に編集ボタンはイネイブル
JCL_btn_SetEnable_byListSelect (->vUS01_lstUS;->vUS01_btnMod)

//リストボックスの選択行が１つ以上の時に削除ボタンはイネイブル
JCL_btn_SetEnable_byNSelect (->vUS01_lstUS;->vUS01_btnDel)

  //件数表示
vUS01_varNumOfRecs:=String(Size of array(vUS01_lstUS_ID);"#,###,###,##0")+"件"
