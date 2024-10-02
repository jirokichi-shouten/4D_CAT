//PO_Adds_byFileText
//20220214 wat
//会計ジロウの勘定科目読み込みから流用

C_TEXT($1; $fileText)
$fileText:=$1  //読み込んだファイルの内容
C_LONGINT($0; $cnt)
$cnt:=0  //作成したレコード数
ARRAY TEXT($lineAry; 0)  //改行で切り分けた配列
ARRAY TEXT($itemAry; 0)  //タブで切り分けた配列
C_LONGINT($minimumCols)
$minimumCols:=11  //必要な列数
C_LONGINT($i; $numOfLines; $numOfItems)
C_TEXT($CR)
$CR:=Char(Carriage return)
C_LONGINT($ac_id; $br_id)
C_BOOLEAN($done)
C_TEXT($address)
$address:="住所"

JCL_pgs_DefInit
JCL_pgs_Show("郵便番号を読み込んでいます．．．")

//すでにある県の郵便番号レコードを削除
READ WRITE([Z_PostalCode])
QUERY([Z_PostalCode]; [Z_PostalCode]PO_JIGYOSYO=0)
DELETE SELECTION([Z_PostalCode])

//改行で切り分ける// 区切り文字をCR→CRLF
$numOfLines:=JCL_str_Extract($fileText; $CR; ->$lineAry)
For ($i; 2; $numOfLines)  //2行目から読む
	If (Mod($i; 3000)=0)
		JCL_pgs_SetValue(($i/$numOfLines)*100; "住所："+$address; $i; $numOfLines)
		DELAY PROCESS(Current process; 1)
	End if 
	//タブで切り分ける
	DELETE FROM ARRAY($itemAry; 1; Size of array($itemAry))
	$numOfItems:=JCL_str_Extract($lineAry{$i}; ","; ->$itemAry)
	If ($minimumCols<=$numOfItems)
		//DBに保存
		$po_id:=PO_Add_byInitValues
		[Z_PostalCode]PO_CODE:=Replace string($itemAry{3}; "\""; "")  //郵便番号（7桁）
		[Z_PostalCode]PO_PREFECTURE:=Replace string($itemAry{7}; "\""; "")  //都道府県名
		[Z_PostalCode]PO_CITY:=Replace string($itemAry{8}; "\""; "")  //市区町村名
		[Z_PostalCode]PO_TOWN:=Replace string($itemAry{9}; "\""; "")  //町域名
		[Z_PostalCode]PO_JIGYOSYO:=0  //事業所ではない
		SAVE RECORD([Z_PostalCode])  //レコードを保存
		
		$address:=$itemAry{7}+$itemAry{8}+$itemAry{9}
	End if 
	
	$done:=JCL_pgs_IsCancel
	If ($done=True)
		$i:=$numOfLines
	End if 
End for 
JCL_pgs_Cancel

UNLOAD RECORD([Z_PostalCode])
READ ONLY([Z_PostalCode])

$0:=$numOfLines
