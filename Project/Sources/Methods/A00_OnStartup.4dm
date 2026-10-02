//%attributes = {}
//A00_OnStartup
//20240110 jirokichi
// メイン画面のプロセスを開始

C_LONGINT:C283($main_proc)

// 新しいプロセスを開始
//$main_proc:=New process("A01_main"; 0; "A01_main"; *)
//20261002 Codex/wat CAT固有の起動メソッドをAPL_へ改名
$main_proc:=New process:C317("APL_D00_Generator"; 0; "A01_main"; *)

//上の行のどちらかを実行して、ジェネレータモードとアプリモードを切り替える
