//PR01_SetControlsValues
//FG v202103 2024/02/07 17:28:37
//PASSWORD_RESETS フォームオブジェクトを制御

//リストボックスの選択行が１つの時に編集ボタンはイネイブル
JCL_btn_SetEnable_byListSelect (->vPR01_lstPR;->vPR01_btnMod)

//リストボックスの選択行が１つ以上の時に削除ボタンはイネイブル
JCL_btn_SetEnable_byNSelect (->vPR01_lstPR;->vPR01_btnDel)

  //件数表示
vPR01_varNumOfRecs:=String(Size of array(vPR01_lstPR_ID);"#,###,###,##0")+"件"
