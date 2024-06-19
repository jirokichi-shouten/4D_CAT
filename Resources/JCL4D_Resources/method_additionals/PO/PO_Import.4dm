//%attributes = {}
//PO_Import
//20220214 wat
//郵便番号読み込み、リニューアル版
//郵便番号をＣＳＶファイルから読み込む
//事業所の郵便番号に対応

C_LONGINT:C283($alrt_ok)
C_TEXT:C284($fileText)
C_LONGINT:C283($cnt)

//確認ダイアログ
C_TEXT:C284($title; $inform; $ok_str; $cancel_str)
$title:="郵便番号更新"
$inform:="郵便番号ファイルを読み込んで郵便番号リストを更新します。"
$inform:=$inform+"よろしいですか？"
$ok_str:="更新する"
$cancel_str:="キャンセル"
$alrt_ok:=JCL_dlg_YesNo($title; $inform; $ok_str; $cancel_str)
If ($alrt_ok=1)  //ダイアログで[更新する]が押された？
	//市町村
	//リソースフォルダから　ファイルの中身を取得
	$fileText:=JCL_file_GetFromResourcesFolder("jiro"; "KEN_ALL.CSV"; "Shift-JIS")
	
	//レコード作成
	$cnt:=PO_Adds_byFileText($fileText)
	
	
	//事業所
	//リソースフォルダから　ファイルの中身を取得
	$fileText:=JCL_file_GetFromResourcesFolder("jiro"; "JIGYOSYO.CSV"; "Shift-JIS")
	
	//レコード作成
	$cnt:=PO_Adds_byFileText_jigyousyo($fileText)
	
End if 
