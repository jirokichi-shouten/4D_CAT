//%attributes = {}
//JCL_wait_SampleCode
//20130606 yabe
//ウェイトダイアログをテストする

C_BOOLEAN:C305($done)
C_LONGINT:C283($progress)
C_TEXT:C284($msg)
C_LONGINT:C283($counter)

JCL_wait_DefInit

JCL_wait_Show("ウェイトダイアログテスト")

$progress:=0

While (($progress<=1000) & ($done=False:C215))
	$counter:=$counter+1
	$msg:="while "+String:C10($counter)+Char:C90(13)+$msg
	
	JCL_wait_SetValue($msg+String:C10($progress); $progress; 1000)
	
	DELAY PROCESS:C323(Current process:C322; 1)
	//OBJECT SET SCROLL POSITION(*; "<>JCL_D91_Msg"; 1000; 1000) //no effect
	
	$done:=JCL_wait_IsCancel
	$progress:=$progress+1
	
End while 

JCL_wait_Cancel
ALERT:C41("end")
