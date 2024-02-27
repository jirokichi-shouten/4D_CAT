//%attributes = {}
//JCL_lst_Copy
//20190129 wat
// 汎用のリストボックス　コピー すべての
//20200602 wat 非表示列は出力しない。最後のタブは取り除く
//20210914 wat フッターも出力
//20210923 wat フッター出力をStringに変換
//20220626 フッター非表示ならフッター出力しない

C_POINTER:C301($1; $lstbxPtr)
$lstbxPtr:=$1
C_TEXT:C284($buf)
$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
C_TEXT:C284($tabChar; $crChar)
$tabChar:=Char:C90(Tab:K15:37)
$crChar:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
$crChar:=Char:C90(Line feed:K15:40)  //20170222
C_LONGINT:C283($numOfCols; $numOfRows; $col; $row)

// 列数、行数を求める
$numOfCols:=LISTBOX Get number of columns:C831($lstbxPtr->)
$numOfRows:=LISTBOX Get number of rows:C915($lstbxPtr->)

ARRAY TEXT:C222($aryColNames; 0)
ARRAY TEXT:C222($aryHeaderNames; 0)
ARRAY POINTER:C280($aryColVars; 0)
ARRAY POINTER:C280($aryHeaderVers; 0)
ARRAY BOOLEAN:C223($aryColsVisible; 0)
ARRAY POINTER:C280($aryStyles; 0)
ARRAY TEXT:C222($aryFooterNames; 0)
ARRAY POINTER:C280($aryFooterVers; 0)
C_LONGINT:C283($footer_visible)

LISTBOX GET ARRAYS:C832($lstbxPtr->; $aryColNames; $aryHeaderNames; $aryColVars; $aryHeaderVers; $aryColsVisible; \
$aryStyles; $aryFooterNames; $aryFooterVers)

// ヘッダを出力
For ($col; 1; $numOfCols)
	//非表示列は出力しない
	If ($aryColsVisible{$col}=True:C214)
		$str:=OBJECT Get title:C1068(*; $aryHeaderNames{$col})
		$buf:=$buf+$str+$tabChar
	End if 
	
	//最後の列は最後のタブ文字を取り除いて改行を追加
	If ($col=$numOfCols)
		$buf:=Substring:C12($buf; 1; Length:C16($buf)-1)
		$buf:=$buf+$crChar
		
	End if 
End for 

// ボディを出力
For ($row; 1; $numOfRows)
	
	For ($col; 1; $numOfCols)
		//非表示列は出力しない
		If ($aryColsVisible{$col}=True:C214)
			$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある
			$buf:=$buf+$str+$tabChar
		End if 
		
		//最後の列は最後のタブ文字を取り除いて改行を追加
		If ($col=$numOfCols)
			$buf:=Substring:C12($buf; 1; Length:C16($buf)-1)
			$buf:=$buf+$crChar
			
		End if 
	End for 
End for 

// フッターを出力 20210914 //20220626 非表示なら出力しない
$footer_visible:=LISTBOX Get property:C917($lstbxPtr->; lk display footer:K53:20)
If ($footer_visible=1)
	For ($col; 1; $numOfCols)
		//非表示列は出力しない
		If ($aryColsVisible{$col}=True:C214)
			$str:=String:C10($aryFooterVers{$col}->)  // データ型によってはエラーになる可能性がある 20210923
			$buf:=$buf+$str+$tabChar
		End if 
		
		//最後の列は最後のタブ文字を取り除いて改行を追加
		If ($col=$numOfCols)
			$buf:=Substring:C12($buf; 1; Length:C16($buf)-1)
			$buf:=$buf+$crChar
			
		End if 
	End for 
End if 

//最後の改行をとる 20220626
$buf:=Substring:C12($buf; 1; Length:C16($buf)-1)

SET TEXT TO PASTEBOARD:C523($buf)
