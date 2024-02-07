//PR01_frmOnLoad
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS フォームオンロード

PR01_frmDefInit 

  // デフォルトの並び順を指定、配列にプッシュしておく
JCL_lst_Sort_Append ("vPR01_lstPR";->vPR01_lstPR_HeaderNames;->vPR01_lstPR_SortOrders;1;2)  // 降順
JCL_lst_Sort_Append ("vPR01_lstPR";->vPR01_lstPR_HeaderNames;->vPR01_lstPR_SortOrders;2;1)  // 昇順

PR01_lstPR_Make 
PR01_SetControlsValues 
