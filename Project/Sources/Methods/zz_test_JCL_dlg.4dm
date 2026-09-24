//%attributes = {"shared":true}
// zz_test_JCL_dlg
//20150911 wat
//20260924 Codex/wat Inform_ShowOnDiskの動作確認用パスを追加
//JCL_dlg　使用方法

C_TEXT:C284($text; $filePath)

JCL_dlg_YesNo("タイトルABC"; "分岐YsesNo"; "ok"; "cancel")

JCL_dlg_NoYes("デフォルトNo"; "NoYes分岐"; "OK"; "Cancel")

JCL_dlg_Inform("タイトルInform文字列"; "単なるお知らせです。"; "ok")

JCL_dlg_Surprise("警告！タイトル文字列"; "Surpriseしました。"; "ok")

$text:="default value by text"
JCL_dlg_InputOne("もじ入力"; "文字列を入力してください。"; "ok"; "cancel"; ->$text)
ALERT:C41("入力テキスト="+$text)

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"fields.txt"
JCL_dlg_Inform_ShowOnDisk("ファインダに表示"; "msg"; "ok"; $filePath)
