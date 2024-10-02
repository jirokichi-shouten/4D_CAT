//PO_Import
//20220214 wat
//郵便番号読み込み、リニューアル版
//郵便番号をＣＳＶファイルから読み込む
//事業所の郵便番号に対応

C_LONGINT($alrt_ok)
C_TEXT($fileText)
C_LONGINT($cnt)

//確認ダイアログ
C_TEXT($title; $inform; $ok_str; $cancel_str)
$title:="郵便番号更新"
$inform:="郵便番号ファイルを読み込んで郵便番号リストを更新します。"
$inform:=$inform+"よろしいですか？"
$ok_str:="更新する"
$cancel_str:="キャンセル"
$alrt_ok:=JCL_dlg_YesNo($title; $inform; $ok_str; $cancel_str)
If ($alrt_ok=1)  //ダイアログで[更新する]が押された？
	//市町村
	$fileText:=File("/RESOURCES/jiro/utf_ken_all.csv").getText()
	//改行コードをCRに統一する 20130318 add yabe
	$fileText:=Replace string($fileText; Char(Line feed); Char(Carriage return))  //ラインフィードをキャリッジリターンに置き換える
	$fileText:=Replace string($fileText; Char(Carriage return)+Char(Carriage return); Char(Carriage return))  //２つのキャリッジリターンを１つのキャリッジリターンに置き換える
	
	//レコード作成
	$cnt:=PO_Adds_byFileText($fileText)
	
	
	//事業所
	$fileText:=File("/RESOURCES/jiro/JIGYOSYO.csv").getText()
	//改行コードをCRに統一する 20130318 add yabe
	$fileText:=Replace string($fileText; Char(Line feed); Char(Carriage return))  //ラインフィードをキャリッジリターンに置き換える
	$fileText:=Replace string($fileText; Char(Carriage return)+Char(Carriage return); Char(Carriage return))  //２つのキャリッジリターンを１つのキャリッジリターンに置き換える
	
	//レコード作成
	$cnt:=PO_Adds_byFileText_jigyousyo($fileText)
	
End if 
