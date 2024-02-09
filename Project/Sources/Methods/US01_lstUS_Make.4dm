//US01_lstUS_Make
//FG v202209 2024/02/09 18:06:20
//USERS リストボックス配列作成

C_LONGINT($i; $cnt)
ARRAY OBJECT($aryObj; 0)
C_OBJECT($objSearch)
$objSearch:=New object
$objSearch.del_flag:=0 

  //サーバ上でクエリー実行、結果をオブジェクトの配列で取得
$cnt:=US01_lstUS_Make_onServer($objSearch; ->$aryObj)

  //オブジェクトの配列からリストボックスの配列に代入
US01_lstUS_Make_asign ($cnt;->$aryObj)

  // ソート順を実行
JCL_lst_Sort ("vUS01_lstUS";->vUS01_lstUS_HeaderNames;->vUS01_lstUS_SortOrders)
