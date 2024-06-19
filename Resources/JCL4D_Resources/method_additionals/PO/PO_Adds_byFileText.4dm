//%attributes = {}
//PO_Adds_byFileText
//20220214 wat
//会計ジロウの勘定科目読み込みから流用

C_TEXT:C284($1; $fileText)
$fileText:=$1  //読み込んだファイルの内容
C_LONGINT:C283($0; $cnt)
$cnt:=0  //作成したレコード数
ARRAY TEXT:C222($lineAry; 0)  //改行で切り分けた配列
ARRAY TEXT:C222($itemAry; 0)  //タブで切り分けた配列
C_LONGINT:C283($minimumCols)
$minimumCols:=11  //必要な列数
C_LONGINT:C283($i; $numOfLines; $numOfItems)
C_TEXT:C284($CR)
$CR:=Char:C90(Carriage return:K15:38)
C_LONGINT:C283($ac_id; $br_id)
C_BOOLEAN:C305($done)
C_TEXT:C284($address)
$address:="住所"

JCL_pgs_DefInit
JCL_pgs_Show("郵便番号を読み込んでいます．．．")

//すでにある県の郵便番号レコードを削除
READ WRITE:C146([Z_PostalCode:8])
QUERY:C277([Z_PostalCode:8]; [Z_PostalCode:8]PO_JIGYOSYO:6=0)
DELETE SELECTION:C66([Z_PostalCode:8])

//改行で切り分ける// 区切り文字をCR→CRLF
$numOfLines:=JCL_str_Extract($fileText; $CR; ->$lineAry)
For ($i; 2; $numOfLines)  //2行目から読む
	If (Mod:C98($i; 3000)=0)
		JCL_pgs_SetValue(($i/$numOfLines)*100; "住所："+$address; $i; $numOfLines)
		DELAY PROCESS:C323(Current process:C322; 1)
	End if 
	//タブで切り分ける
	DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
	$numOfItems:=JCL_str_Extract($lineAry{$i}; ","; ->$itemAry)
	If ($minimumCols<=$numOfItems)
		//DBに保存
		$po_id:=PO_Add_byInitValues
		[Z_PostalCode:8]PO_CODE:2:=Replace string:C233($itemAry{3}; "\""; "")  //郵便番号（7桁）
		[Z_PostalCode:8]PO_PREFECTURE:3:=Replace string:C233($itemAry{7}; "\""; "")  //都道府県名
		[Z_PostalCode:8]PO_CITY:4:=Replace string:C233($itemAry{8}; "\""; "")  //市区町村名
		[Z_PostalCode:8]PO_TOWN:5:=Replace string:C233($itemAry{9}; "\""; "")  //町域名
		[Z_PostalCode:8]PO_JIGYOSYO:6:=0  //事業所ではない
		SAVE RECORD:C53([Z_PostalCode:8])  //レコードを保存
		
		$address:=$itemAry{7}+$itemAry{8}+$itemAry{9}
	End if 
	
	$done:=JCL_pgs_IsCancel
	If ($done=True:C214)
		$i:=$numOfLines
	End if 
End for 
JCL_pgs_Cancel

UNLOAD RECORD:C212([Z_PostalCode:8])
READ ONLY:C145([Z_PostalCode:8])

$0:=$numOfLines
