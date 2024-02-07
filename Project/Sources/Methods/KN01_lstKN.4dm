//KN01_lstKN
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue リストボックス

C_LONGINT($frmEvnt)

$frmEvnt:=Form event code

Case of 
: ($frmEvnt=On Double Clicked)

KN01_lstKN_OnDblClicked 

: ($frmEvnt=On Selection Change)

KN01_lstKN_OnSelChange 

: ($frmEvnt=On After Sort)
		
KN01_lstKN_OnAfterSort 

End case 
