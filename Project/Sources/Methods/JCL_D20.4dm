//JCL_D20
//20240723 wat
//カレンダーアシストダイアログを表示 クラスで提供。関連するメソッドをクラス化。v19以降に対応
// 20240717 hisa v20対応。旧ソースをベースにtxtとbtnImageとGridを「cbx」に変更、グリッドは廃止。

//usage:
//C_LONGINT($dlgOK)
//C_DATE($date)
//$date:=Current date
//C_OBJECT($dlg)
//$dlg:=cs.JCL_D20.new(->$date; 100; 300; "入力")
//If ($dlg.dlg_ok=1)
//vA01_varDate:=$date
//End if 
//ALERT(String($date)+":::"+String(vA01_varDate))

Class constructor
	//D20_Calendar
	//20130913 wat
	//カレンダーによる　デイトピッカー
	// 201401002 wat ikeda ゼロの日を今日にしておく
	
	C_POINTER:C301($1; $datePtr)
	$datePtr:=$1
	C_LONGINT:C283($2; $hPos)
	$hPos:=$2
	C_LONGINT:C283($3; $vPos)
	$vPos:=$3
	C_TEXT:C284($4; $okStr)
	$okStr:=$4
	C_DATE:C307($old_date)  // 20141002 引数を保持
	$old_date:=$datePtr->
	
	C_OBJECT:C1216(cD20)
	cD20:=This:C1470  // クラス用プロセス変数定義
	
	This:C1470.defInit($datePtr)
	
	vD20_varOKStr:=$okStr
	
	This:C1470.dlg_ok:=0
	$dlg_ok:=This:C1470.display($hPos; $vPos)
	If ($dlg_ok=1)
		$datePtr->:=vD20_varDateRef
		
	Else 
		// 20141002 引数に戻す
		$datePtr->:=$old_date
		
	End if 
	
	This:C1470.dlg_ok:=$dlg_ok
	
Function defInit()
	//D20_DefInit
	//20130913 wat
	//プロセス変数
	// 201401002 wat ikeda ゼロの日を今日にしておく
	
	C_POINTER:C301($1; vD20_varDatePtr)
	vD20_varDatePtr:=$1
	
	//現在選択されているボタン番号
	C_LONGINT:C283(vD20_varCurrentBox)
	vD20_varCurrentBox:=0
	
	//選択された日付
	C_DATE:C307(vD20_varDateRef)
	vD20_varDateRef:=vD20_varDatePtr->
	
	// 20141002 ゼロの場合は今日を入れておく
	If (vD20_varDateRef=!00-00-00!)
		vD20_varDateRef:=Current date:C33
		
	End if 
	
	//ダイアログのテキスト
	C_TEXT:C284(vD20_varYearMonthStr)
	
	//現在表示している画面のカレンダー開始日
	C_DATE:C307(vD20_varMonthStart)
	
	// 20140620 wat ボタン文字列
	C_TEXT:C284(vD20_varOKStr)
	
Function frm()
	//D20_frm
	//20130913
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			This:C1470.frmOnLoad()
			
	End case 
	
Function frmOnLoad()
	//D20_frmOnLoad
	//20130913
	//フォームメソッド
	
	This:C1470.frmDefInit()
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	
	This:C1470.buildCalendar()
	
	//ボタンテキスト
	OBJECT SET TITLE:C194(vD20_btnOK; vD20_varOKStr)
	
	vD20_btnCancel:=1
	
Function frmDefInit()
	//D20_frmDefInit
	//20130913 wat
	//プロセス変数を初期化
	// 20240719 hisa 不要な変数を削除
	
	//this syntax allows international use 
	vD20_varMonthStart:=Add to date:C393(!00-00-00!; Year of:C25(vD20_varDateRef); Month of:C24(vD20_varDateRef); 1)
	
	C_DATE:C307(vD20_varDate1stBox)
	
	// 20151103 wat
	ARRAY LONGINT:C221(vD20_popYear; 0)
	
	This:C1470.popNum_SetValue(vD20_varDateRef)
	
	// 20151103 wat
	C_LONGINT:C283($year; $index)
	$year:=Year of:C25(vD20_varDateRef)
	$index:=Find in array:C230(vD20_popYear; $year)
	
	vD20_popYear:=$index
	
Function display()
	//D20_Display
	//20130913 wat
	
	C_LONGINT:C283($1; $hPos)
	$hPos:=$1
	C_LONGINT:C283($2; $vPos)
	$vPos:=$2
	C_LONGINT:C283($0; $dlg_ok)
	C_LONGINT:C283($wref)
	
	$wref:=Open form window:C675("JCL_D20_Calendar"; Modal form dialog box:K39:7; $hPos; $vPos)
	
	DIALOG:C40("JCL_D20_Calendar")
	$dlg_ok:=OK
	
	CLOSE WINDOW:C154($wref)
	
	$0:=$dlg_ok
	
Function btnArrows()
	//D20_btnArrows
	//矢印ボタン、キーボードショートカットで呼ばれる
	//20130913
	// 20240718 hisa
	
	C_LONGINT:C283($1; $Offset)
	$Offset:=$1
	
	C_DATE:C307($oldMonthStart)
	$oldMonthStart:=vD20_varMonthStart
	C_LONGINT:C283($oldMonth; $newMonth)
	$oldMonth:=Month of:C24($oldMonthStart)
	
	// 20240718 hisa
	// チェックボックス変数名の末尾番号を取得、以前はグリッド番号だった
	C_LONGINT:C283($endNumStr)
	$endNumStr:=This:C1470.cbxGetCheckedEndNumber()
	
	//表示月を変えるなら変える
	If ($Offset>0)
		If (($endNumStr+$Offset)>42)
			vD20_varMonthStart:=Add to date:C393($oldMonthStart; 0; 1; 0)
		End if 
	Else 
		If (($endNumStr+$Offset)<1)
			vD20_varMonthStart:=Add to date:C393($oldMonthStart; 0; -1; 0)
		End if 
	End if 
	
	//選択日付を変更
	$endNumStr:=$endNumStr+$Offset  //-7,-1,+1 or +7
	vD20_varDateRef:=vD20_varDate1stBox+$endNumStr-1
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
	This:C1470.popNum_SetValue(vD20_varMonthStart)  //20151115 yabe add
	
Function btnPreviousMonth()
	//D20_btnbPreviousMonth
	//20130913 wat, 20131122 refactor
	//前の月を表示、参照日付は前の月の同じ日に移動
	
	//選択日付を変更
	vD20_varDateRef:=Add to date:C393(vD20_varDateRef; 0; -1; 0)
	
	//開始日付を変更
	vD20_varMonthStart:=Add to date:C393(vD20_varMonthStart; 0; -1; 0)
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
	//年数ポップアップを更新　20131119
	This:C1470.popNum_SetValue(vD20_varMonthStart)
	
Function btnNextMonth()
	//D20_btnNextMonth
	//20130913 wat, 20131122 refactor
	//次の月を表示、参照日付は次の月の同じ日に移動
	
	//選択日付を変更
	vD20_varDateRef:=Add to date:C393(vD20_varDateRef; 0; 1; 0)
	
	//開始日付を変更
	vD20_varMonthStart:=Add to date:C393(vD20_varMonthStart; 0; 1; 0)
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()  //画面を更新
	This:C1470.buildCalendar()
	
	//年数ポップアップを更新　20131119
	This:C1470.popNum_SetValue(vD20_varMonthStart)
	
Function btnNextYear()
	//D20_btnNextYear
	//20131122 wat
	//次の年、ポップアップを更新、月を更新
	
	//選択日付を変更
	vD20_varDateRef:=Add to date:C393(vD20_varDateRef; 1; 0; 0)
	
	//開始日付を変更
	vD20_varMonthStart:=Add to date:C393(vD20_varMonthStart; 1; 0; 0)
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
	//年数ポップアップを更新　20131119
	This:C1470.popNum_SetValue(vD20_varMonthStart)
	
Function btnPrevYear()
	//D20_btnPrevYear
	//20131122 wat
	//前の年、ポップアップを更新、月を更新
	
	//まず選択日付を変更
	vD20_varDateRef:=Add to date:C393(vD20_varDateRef; -1; 0; 0)
	
	//次に開始日付を変更
	vD20_varMonthStart:=Add to date:C393(vD20_varMonthStart; -1; 0; 0)
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
	//年数ポップアップを更新　20131119
	This:C1470.popNum_SetValue(vD20_varMonthStart)
	
Function btnToday()
	//D20_btnToday
	//20130913
	//トゥデイボタン
	
	//選択日付を変更
	vD20_varDateRef:=Current date:C33
	
	//開始日付を変更
	vD20_varMonthStart:=Date:C102(String:C10(Year of:C25(vD20_varDateRef))+"/"+String:C10(Month of:C24(vD20_varDateRef))+"/01")
	
	//カレンダー画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
	//年数ポップアップを更新　20131123
	This:C1470.popNum_SetValue(vD20_varMonthStart)
	
Function buildCalendar()
	//D20_BuildCalendar
	// 20130913
	//20240724 wat フォーカス処理
	
	C_DATE:C307($MonthStart)
	C_LONGINT:C283($DayNum; $WeekDay)
	
	// 宣言されていなかった 20160225 wat
	C_LONGINT:C283($Black; $White; $Grey; $Red)
	C_LONGINT:C283($MonthRef; $WeekDay; $offset)
	C_DATE:C307($Date)
	C_POINTER:C301($pVar)
	//C_POINTER($bImage_p)
	C_TEXT:C284($objName)
	
	$White:=(255*256*256)+(255*256)+255
	$Grey:=(100*256*256)+(100*256)+100
	$Red:=(147*256*256)+(2*256)+2
	$Black:=0
	
	$MonthStart:=vD20_varMonthStart
	
	$MonthRef:=Month of:C24($MonthStart)
	$WeekDay:=Day number:C114($MonthStart)  //1 = Sunday
	//we look for the previous monday
	$offset:=$WeekDay-2
	$offset:=$WeekDay-1
	If ($offset<0)
		$offset:=$offset+7
	End if 
	
	// このプロセス変数が左上のスタート日となる
	vD20_varDate1stBox:=$MonthStart-$offset
	//this is the date from the 1st calendar box which is always a Monday
	
	// チェックボックスをすべてオフにする
	This:C1470.cbxSetUncheckAll()
	
	// 指定された日付のチェックをオン、カラーが設定される
	$Date:=vD20_varDate1stBox
	For ($i; 1; 42)  //loop over all the boxes
		$objName:="vD20_cbxDay"+String:C10($i)
		$pVar:=Get pointer:C304($objName)  //vD20_cbxDay42
		$DayNum:=Day of:C23($Date)
		$WeekDay:=Day number:C114($Date)
		OBJECT SET TITLE:C194(*; $objName; String:C10($DayNum))
		
		If (Month of:C24($Date)#$MonthRef)  //date is outside of the current month
			//OBJECT SET FONT STYLE($pVar->; Italic)// チェックボックスのタイトルはイタリックにはならなかった
			OBJECT SET RGB COLORS:C628($pVar->; $Grey; $White)
			
		Else 
			OBJECT SET FONT STYLE:C166($pVar->; Bold:K14:2)
			OBJECT SET RGB COLORS:C628($pVar->; $Black; $White)
			
		End if 
		
		If ($Date=vD20_varDateRef)  //date selected by the user
			$pVar->:=1  // チェックオン
			EDIT ITEM:C870(*; $objName)  //20240724
			
		Else 
			If ($Date=Current date:C33)  //yes
				OBJECT SET RGB COLORS:C628($pVar->; $red; $White)
				
			End if 
		End if 
		
		$Date:=$Date+1  //next box
		
	End for 
	
Function cbxDayCommon()
	// D20_cbxDayCommon
	// 20240717 hisa D20_Grid から流用
	
	Case of 
		: (Form event code:C388=On Clicked:K2:4)
			This:C1470.cbxDayCommonOnClicked()
			
		: (Form event code:C388=On Double Clicked:K2:5)
			This:C1470.cbxDayCommonOnDblClicked()
			
	End case 
	
Function cbxDayCommonOnClicked()
	// D20_cbxDayCommonOnClicked
	// 20240717 hisa
	
	// チェックボックス変数名の末尾番号を取得、以前はグリッド番号（vD20_Grid）だった
	C_TEXT:C284($objName)
	C_LONGINT:C283($endNum)
	$objName:=OBJECT Get name:C1087(Object current:K67:2)
	$endNum:=This:C1470.cbxEndNumber($objName)
	
	//選択日付を変更
	vD20_varDateRef:=vD20_varDate1stBox+$endNum-1
	//vD20_varDateRef:=vD20_varDate1stBox+vD20_Grid-1
	
	//カレンダー画面再作成
	This:C1470.varYearMonthStr_Set()
	
	This:C1470.buildCalendar()
	
Function cbxDayCommonOnDblClicked()
	//D20_cbxDayCommonOnDblClicked
	//20130913
	
	ACCEPT:C269
	
Function cbxEndNumber()
	// D20_cbxEndNumber
	// チェックボックス変数名の末尾番号を取得
	// 20240718 hisa
	
	C_TEXT:C284($1; $objName)
	$objName:=$1
	C_LONGINT:C283($0; $outEndNumber)
	C_TEXT:C284($value)
	C_LONGINT:C283($len; $nameLen; $valueLen)
	
	// 例）
	// "vD20_cbxDay1" -> "1" -> 1
	// "vD20_cbxDay42" -> "42" -> 42
	$len:=Length:C16("vD20_cbxDay")
	$nameLen:=Length:C16($objName)
	$valueLen:=$nameLen-$len
	$value:=Substring:C12($objName; $len+1; $valueLen)
	$outEndNumber:=Num:C11($value)
	
	$0:=$outEndNumber
	
Function cbxGetCheckedEndNumber()
	// D20_cbxGetCheckedEndNumber
	// 20240718 hisa
	// チェックオン（チェックド）になっているチェックボックス変数名の末尾番号を取得
	
	C_LONGINT:C283($0; $endNumber)
	$endNumber:=0
	C_POINTER:C301($pVar)
	C_TEXT:C284($objName)
	
	For ($i; 1; 42)
		$objName:="vD20_cbxDay"+String:C10($i)  //vD20_cbxDay42
		$pVar:=Get pointer:C304($objName)
		If ($pVar->=1)
			// 例）
			// "vD20_cbxDay1" -> "1" -> 1
			// "vD20_cbxDay42" -> "42" -> 42
			$endNumber:=This:C1470.cbxEndNumber($objName)
			
		End if 
		
	End for 
	
	$0:=$endNumber
	
Function cbxSetUncheckAll()
	// uncheckAllCheckbox
	// D20_cbxSetUncheckAll
	// 20240717 hisa
	// すべてのチェックボックスをチェックオフ（アンチェック）にする
	
	C_POINTER:C301($pVar)
	C_TEXT:C284($objName)
	
	For ($i; 1; 42)
		$objName:="vD20_cbxDay"+String:C10($i)  //vD20_cbxDay42
		$pVar:=Get pointer:C304($objName)
		$pVar->:=0
		
	End for 
	
Function popNum_SetValue()
	//D20_popNum_SetValue
	//20131001 wat
	//ポップアップに年数の　値をセット
	
	C_DATE:C307($1; $date)
	$date:=$1
	
	// 20151103 wat
	C_LONGINT:C283($i; $sizeOfAry)
	C_LONGINT:C283($year)
	$year:=Year of:C25($date)
	
	DELETE FROM ARRAY:C228(vD20_popYear; 1; Size of array:C274(vD20_popYear))
	
	$sizeOfAry:=100
	ARRAY LONGINT:C221(vD20_popYear; $sizeOfAry+5)
	For ($i; 1; $sizeOfAry+5)
		
		vD20_popYear{$i}:=$year+$i-$sizeOfAry
		
	End for 
	
	vD20_popYear:=100  //20151115 yabe add
	
Function popYear()
	//vD20_popYear
	//20130927 wat
	//年ポップアップメニュー
	
	C_LONGINT:C283($year; $month; $day)
	
	$year:=vD20_popYear{vD20_popYear}
	
	//次に開始日付を変更
	$month:=Month of:C24(vD20_varDateRef)  //20151115 yabe add
	$day:=Day of:C23(vD20_varDateRef)  //20151115 yabe add
	vD20_varDateRef:=Date:C102(String:C10($year)+"/"+String:C10($month)+"/"+String:C10($day))  //20151115 yabe add
	
	$month:=Month of:C24(vD20_varMonthStart)
	$day:=Day of:C23(vD20_varMonthStart)
	vD20_varMonthStart:=Date:C102(String:C10($year)+"/"+String:C10($month)+"/"+String:C10($day))
	
	//画面再作成
	This:C1470.varYearMonthStr_Set()
	This:C1470.buildCalendar()
	
Function varYearMonthStr_Set()
	//D20_varYearMonthStr_Set
	//20130913 wat, 20131122 rename, 20131125 和暦追加
	//ダイアログ表題文字を、現在表示されている画面の年月にする
	
	C_DATE:C307($monthStart)
	C_TEXT:C284($warekiMonth)
	
	$monthStart:=vD20_varMonthStart
	
	vD20_varYearMonthStr:=String:C10(Year of:C25($monthStart))+"年"+String:C10(Month of:C24($monthStart))+"月"
	
	//20131125 和暦追加
	$warekiMonth:=This:C1470.str_GetWareki($monthStart)
	vD20_varYearMonthStr:=vD20_varYearMonthStr+$warekiMonth
	
Function str_GetWareki()
	//zz_str_GetWareki
	//20131125 wat
	//和暦を取得
	//20200227 ike wat 令和を追加
	
	C_DATE:C307($1; $monthStart)
	$monthStart:=$1
	C_TEXT:C284($0; $warekiMonthStr)
	$warekiMonth:=""
	
	C_DATE:C307($taishouStart; $shouwaStart; $heiseiStart)
	$taishouStart:=Date:C102("1912/7/30")
	$shouwaStart:=Date:C102("1926/12/25")
	$heiseiStart:=Date:C102("1989/1/8")
	$reiwaStart:=Date:C102("2019/5/1")
	
	C_LONGINT:C283($month; $year)
	$year:=Year of:C25($monthStart)
	$month:=Month of:C24($monthStart)
	
	//令和時代
	If ($reiwaStart<=$monthStart)
		$year:=$year-2018
		$warekiMonth:="(令和"+String:C10($year)+"年)"
		
	End if 
	
	//平成時代
	If (($heiseiStart<=$monthStart) & ($monthStart<$reiwaStart))
		$year:=$year-1988
		$warekiMonth:="(平成"+String:C10($year)+"年)"
		
	End if 
	
	//昭和時代
	If (($shouwaStart<=$monthStart) & ($monthStart<$heiseiStart))
		$year:=$year-1925
		$warekiMonth:="(昭和"+String:C10($year)+"年)"
		
	End if 
	
	//大正時代
	If (($taishouStart<=$monthStart) & ($monthStart<$shouwaStart))
		$year:=$year-1911
		$warekiMonth:="(大正"+String:C10($year)+"年)"
		
	End if 
	
	$0:=$warekiMonth
	