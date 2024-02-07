//KN01_frmOnLoad
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue フォームオンロード

KN01_frmDefInit 

  // デフォルトの並び順を指定、配列にプッシュしておく
JCL_lst_Sort_Append ("vKN01_lstKN";->vKN01_lstKN_HeaderNames;->vKN01_lstKN_SortOrders;1;2)  // 降順
JCL_lst_Sort_Append ("vKN01_lstKN";->vKN01_lstKN_HeaderNames;->vKN01_lstKN_SortOrders;2;1)  // 昇順

KN01_lstKN_Make 
KN01_SetControlsValues 
