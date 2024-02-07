//KV01_lstKV
//FG v202103 2024/02/07 21:01:46
//Z_KeyValue リストボックス

C_LONGINT($frmEvnt)

$frmEvnt:=Form event code

Case of 
: ($frmEvnt=On Double Clicked)

KV01_lstKV_OnDblClicked 

: ($frmEvnt=On Selection Change)

KV01_lstKV_OnSelChange 

: ($frmEvnt=On After Sort)
		
KV01_lstKV_OnAfterSort 

End case 
