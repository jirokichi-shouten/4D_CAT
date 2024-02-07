//KN01_lstKN_Make
//FG v202209 2024/02/07 18:10:39
//Z_KeyNValue リストボックス配列作成

C_LONGINT($i; $cnt)
ARRAY OBJECT($aryObj; 0)
C_OBJECT($objSearch)
$objSearch:=New object
$objSearch.del_flag:=0 

  //サーバ上でクエリー実行、結果をオブジェクトの配列で取得
$cnt:=KN01_lstKN_Make_onServer($objSearch; ->$aryObj)

  //オブジェクトの配列からリストボックスの配列に代入
KN01_lstKN_Make_asign ($cnt;->$aryObj)

  // ソート順を実行
JCL_lst_Sort ("vKN01_lstKN";->vKN01_lstKN_HeaderNames;->vKN01_lstKN_SortOrders)
