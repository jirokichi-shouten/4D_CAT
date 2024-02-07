//KV01_lstKV_Make
//FG v202209 2024/02/07 21:01:46
//Z_KeyValue リストボックス配列作成

C_LONGINT($i; $cnt)
ARRAY OBJECT($aryObj; 0)
C_OBJECT($objSearch)
$objSearch:=New object
$objSearch.del_flag:=0 

  //サーバ上でクエリー実行、結果をオブジェクトの配列で取得
$cnt:=KV01_lstKV_Make_onServer($objSearch; ->$aryObj)

  //オブジェクトの配列からリストボックスの配列に代入
KV01_lstKV_Make_asign ($cnt;->$aryObj)

  // ソート順を実行
JCL_lst_Sort ("vKV01_lstKV";->vKV01_lstKV_HeaderNames;->vKV01_lstKV_SortOrders)
