//%attributes = {"shared":true}
//JCL_pgs_Open
//プログレスバー表示プロセス
//$1:メッセージ
//20080605　矢部　新規作成

C_TEXT:C284($1; vJCL_D90_Title)
vJCL_D90_Title:=$1

//ウィンドウ表示
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("JCL_D90_ProgressBar"; \
Modal dialog box:K34:2; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("JCL_D90_ProgressBar")
CLOSE WINDOW:C154
