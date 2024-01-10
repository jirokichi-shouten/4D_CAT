//%attributes = {}
//A00_OnStartup
//20240110 jirokichi
// メイン画面のプロセスを開始

C_LONGINT:C283($main_proc)

// 新しいプロセスを開始
$main_proc:=New process:C317("A01_main"; 0; "A01_main"; *)
