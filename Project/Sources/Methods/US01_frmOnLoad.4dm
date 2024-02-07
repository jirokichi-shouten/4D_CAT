//US01_frmOnLoad
//FG v202103 2024/02/07 20:51:08
//USERS フォームオンロード

US01_frmDefInit 

  // デフォルトの並び順を指定、配列にプッシュしておく
JCL_lst_Sort_Append ("vUS01_lstUS";->vUS01_lstUS_HeaderNames;->vUS01_lstUS_SortOrders;1;2)  // 降順
JCL_lst_Sort_Append ("vUS01_lstUS";->vUS01_lstUS_HeaderNames;->vUS01_lstUS_SortOrders;2;1)  // 昇順

US01_lstUS_Make 
US01_SetControlsValues 
