//KV01_frmOnLoad
//FG v202103 2024/02/07 21:01:46
//Z_KeyValue フォームオンロード

KV01_frmDefInit 

  // デフォルトの並び順を指定、配列にプッシュしておく
JCL_lst_Sort_Append ("vKV01_lstKV";->vKV01_lstKV_HeaderNames;->vKV01_lstKV_SortOrders;1;2)  // 降順
JCL_lst_Sort_Append ("vKV01_lstKV";->vKV01_lstKV_HeaderNames;->vKV01_lstKV_SortOrders;2;1)  // 昇順

KV01_lstKV_Make 
KV01_SetControlsValues 
