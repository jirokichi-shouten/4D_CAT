//%attributes = {}
//zz_fr_A01
//20240203 wat
//A01にボタンを追加する

C_TEXT:C284($frmName)
$frmName:="A01_main"
C_OBJECT:C1216($file)
C_OBJECT:C1216($defA01)
C_TEXT:C284($frmPrefix; $btnName)
$frmPrefix:="US01"
$btnName:="vA01_btn"+$frmPrefix
$tblName:="user"

$file:=File:C1566("/SOURCES/Forms/"+$frmName+"/form.4DForm")
If ($file.exists)
	//ファイルの中身を解析
	$defA01:=JSON Parse:C1218($file.getText())
	
	$top:=110
	$left:=20
	
	For ($i; 1; 10)
		//ボタンを追加
		$btnName:="BTN"+String:C10($i; "000")
		$defA01.pages[0].objects[$btnName]:={}
		$defA01.pages[0].objects[$btnName].type:="button"
		$defA01.pages[0].objects[$btnName].text:=$btnName
		$defA01.pages[0].objects[$btnName].top:=$top+($i*42)
		$defA01.pages[0].objects[$btnName].left:=$left
		$defA01.pages[0].objects[$btnName].width:=94
		$defA01.pages[0].objects[$btnName].height:=26
		$defA01.pages[0].objects[$btnName].focusable:=False:C215
		$defA01.pages[0].objects[$btnName].method:="ObjectMethods/vA01_btn"+$frmPrefix+".4dm"
		$defA01.pages[0].objects[$btnName].events:=["onClick"]
		$defA01.pages[0].objects[$btnName].action:=""
		$defA01.pages[0].objects[$btnName].class:="JCL_YuGothic12"
		
	End for 
	
End if 


//ファイルに書き出す
$file.setText(JSON Stringify:C1217($defA01; *))
