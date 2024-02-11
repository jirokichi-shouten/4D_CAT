//PR01_lstPR_Make
//FG v202209 2024/02/11 21:27:48
//PASSWORD_RESETS リストボックス配列作成

C_LONGINT($i; $cnt)
ARRAY OBJECT($aryObj; 0)
C_OBJECT($objSearch)
$objSearch:=New object
$objSearch.del_flag:=0 

  //サーバ上でクエリー実行、結果をオブジェクトの配列で取得
$cnt:=PR01_lstPR_Make_onServer($objSearch; ->$aryObj)

  //オブジェクトの配列からリストボックスの配列に代入
PR01_lstPR_Make_asign ($cnt;->$aryObj)

  // ソート順を実行
JCL_lst_Sort ("vPR01_lstPR";->vPR01_lstPR_HeaderNames;->vPR01_lstPR_SortOrders)
