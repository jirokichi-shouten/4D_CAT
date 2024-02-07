//PR01_lstPR
//FG v202103 2024/02/07 20:50:34
//PASSWORD_RESETS リストボックス

C_LONGINT($frmEvnt)

$frmEvnt:=Form event code

Case of 
: ($frmEvnt=On Double Clicked)

PR01_lstPR_OnDblClicked 

: ($frmEvnt=On Selection Change)

PR01_lstPR_OnSelChange 

: ($frmEvnt=On After Sort)
		
PR01_lstPR_OnAfterSort 

End case 
