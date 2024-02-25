//%attributes = {}
//zz_tbl_FindForeignKey
//20240225 wat
//外部キーを見つける。xx_yy_IDの形を見つけて、配列でテーブル名を返す。
//相手のテーブルが存在したら外部キーとみなす

C_TEXT:C284($1; $inTablName)
$inTablName:=$1
C_POINTER:C301($2; $outAryTblNrPtr)
$outAryTblNrPtr:=$2
C_POINTER:C301($3; $outAryFldNamePtr)
$outAryFldNamePtr:=$3
C_LONGINT:C283($cnt; $0)
$cnt:=0
C_LONGINT:C283($tblNr; $numOfTables)
ARRAY POINTER:C280($aryFldPtr; 0)
C_LONGINT:C283($numOfFlds; $k)
C_TEXT:C284($table_name; $field_name; $field_name_wo_prefix)

//自テーブルの外部キーを見つける。プリフィックス＋IDに決め打ち
$prefix:=JCL_tbl_GetPrefix_fromStructure($inTablName)
$foreign_key:=$prefix+"_ID"

//自テーブル以外の各テーブルについて
$numOfTables:=Get last table number:C254
For ($tblNr; 1; $numOfTables)
	//有効なテーブルについて実行
	If (Is table number valid:C999($tblNr))
		$table_name:=Table name:C256($tblNr)
		If ($inTablName#$table_name)
			//テーブル名が異なるので別テーブル
			DELETE FROM ARRAY:C228($aryFldPtr; 1; Size of array:C274($aryFldPtr))
			$numOfFlds:=JCL_tbl_aryFieldPtr_make($tblNr; ->$aryFldPtr)
			For ($k; 1; $numOfFlds)
				$field_name:=Field name:C257($aryFldPtr{$k})
				$pos:=Position:C15("_"; $field_name)
				
				//VV_IDがYY_VV_IDに入っているようなケース。マッチングZZxVV_IDの場合は ZZxVV_VV_IDもあるはず
				//フィールド名からプリフィックスを除いた文字列を対象に判断する
				//ER_MAKER_NAMEもあるから1文字目からアンダーバーまでを除く
				$field_name_wo_prefix:=Substring:C12($field_name; $pos+1)
				If (Position:C15($foreign_key; $field_name_wo_prefix)=1)
					//プリフィックスを除いたあとの文字列の先頭が、外部キーなら、このテーブルは１対多の多と判断。
					$cnt:=$cnt+1
					APPEND TO ARRAY:C911($outAryTblNrPtr->; $tblNr)
					APPEND TO ARRAY:C911($outAryFldNamePtr->; $field_name)
					
				End if 
			End for 
		End if 
	End if 
End for 

$0:=$cnt

