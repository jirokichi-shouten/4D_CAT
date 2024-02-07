//KV01_SetControlsValues
//FG v202103 2024/02/07 17:31:33
//Z_KeyValue フォームオブジェクトを制御

//リストボックスの選択行が１つの時に編集ボタンはイネイブル
JCL_btn_SetEnable_byListSelect (->vKV01_lstKV;->vKV01_btnMod)

//リストボックスの選択行が１つ以上の時に削除ボタンはイネイブル
JCL_btn_SetEnable_byNSelect (->vKV01_lstKV;->vKV01_btnDel)

  //件数表示
vKV01_varNumOfRecs:=String(Size of array(vKV01_lstKV_ID);"#,###,###,##0")+"件"
