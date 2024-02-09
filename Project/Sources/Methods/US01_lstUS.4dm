//US01_lstUS
//FG v202103 2024/02/09 18:06:20
//USERS リストボックス

C_LONGINT($frmEvnt)

$frmEvnt:=Form event code

Case of 
: ($frmEvnt=On Double Clicked)

US01_lstUS_OnDblClicked 

: ($frmEvnt=On Selection Change)

US01_lstUS_OnSelChange 

: ($frmEvnt=On After Sort)
		
US01_lstUS_OnAfterSort 

End case 
