//JCL_tbl
//20240510
//テーブル関連メソッド群

Class constructor
	
Function getNames()
	//JCL_tbl_Names_fromStructure
	//JCL_tbl_GetTableNameAry
	//20130430 yabe
	//テーブル名配列を返す
	//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。
	
	C_POINTER:C301($1; $ioAryTableNamePtr)
	$ioAryTableNamePtr:=$1
	C_LONGINT:C283($i; $numOfTables)
	C_TEXT:C284($tblName)
	C_BOOLEAN:C305($isValid)
	
	DELETE FROM ARRAY:C228($ioAryTableNamePtr->; 1; Size of array:C274($ioAryTableNamePtr->))
	
	$numOfTables:=Get last table number:C254
	
	For ($i; 1; $numOfTables)
		
		$isValid:=Is table number valid:C999($i)
		If ($isValid=True:C214)
			$tblName:=Table name:C256($i)
			
			APPEND TO ARRAY:C911($ioAryTableNamePtr->; $tblName)
			
		End if 
	End for 
	
Function getNumber()
	//JCL_tbl_GetNumber
	//20210330 ike wat
	//テーブル名からテーブル番号を得る
	//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。
	
	C_TEXT:C284($1; $inTableName)
	$inTableName:=$1
	C_LONGINT:C283($0; $outTblNr)
	$outTblNr:=0
	C_LONGINT:C283($i; $numOfTables)
	C_BOOLEAN:C305($isValid)
	
	$numOfTables:=Get last table number:C254
	For ($i; 1; $numOfTables)
		$isValid:=Is table number valid:C999($i)
		If ($isValid=True:C214)
			If (Table name:C256($i)=$inTableName)
				$outTblNr:=$i
				
			End if 
		End if 
	End for 
	
	$0:=$outTblNr
	
Function dataType()
	//JCL_tbl_DATATYPE
	//20130501
	//メソッド生成時、テンプレートのDATATYPEを得る
	
	C_TEXT:C284($1; $fieldType)
	$fieldType:=$1  //フィールド型
	C_TEXT:C284($0; $dataType)
	
	$dataType:=""
	Case of 
		: ($fieldType="Is Alpha Field")
			$dataType:="TEXT"
			
		: ($fieldType="Is Text")
			$dataType:="TEXT"
			
		: ($fieldType="Is Real")
			$dataType:="REAL"
			
		: ($fieldType="Is Integer")
			$dataType:="LONGINT"
			
		: ($fieldType="Is LongInt")
			$dataType:="LONGINT"
			
		: ($fieldType="Is Date")
			$dataType:="DATE"
			
		: ($fieldType="Is Time")
			$dataType:="TIME"
			
		: ($fieldType="Is Boolean")
			$dataType:="BOOLEAN"
			
		: ($fieldType="Is Picture")
			$dataType:="PICTURE"
			
		: ($fieldType="Is Subtable")
			$dataType:=""
			
		: ($fieldType="Is BLOB")
			$dataType:=""
	End case 
	
	$0:=$dataType
	
Function initValue()
	//JCL_tbl_InitValue
	//20130507 wat
	//メソッド生成時、テンプレートの INITVALUE を変換
	
	C_TEXT:C284($1; $fieldType)
	$fieldType:=$1  //フィールド型
	C_TEXT:C284($0; $initValue)
	
	$initValue:=""
	Case of 
		: ($fieldType="Is Alpha Field")
			$initValue:="\"\""
			
		: ($fieldType="Is Text")
			$initValue:="\"\""
			
		: ($fieldType="Is Real")
			$initValue:="0.0"
			
		: ($fieldType="Is Integer")
			$initValue:="0"
			
		: ($fieldType="Is LongInt")
			$initValue:="0"
			
		: ($fieldType="Is Date")
			$initValue:="Current date"
			
		: ($fieldType="Is Time")
			$initValue:="Current time"
			
		: ($fieldType="Is Boolean")
			$initValue:="false"
			
		: ($fieldType="Is Picture")
			$initValue:=""
			
		: ($fieldType="Is Subtable")
			$initValue:=""
			
		: ($fieldType="Is BLOB")
			$initValue:=""
	End case 
	
	$0:=$initValue
	
Function findForeignKey()
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
	$prefix:=This:C1470.getPrefix_fromStructure($inTablName)
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
				$numOfFlds:=This:C1470.aryFieldPtr_make($tblNr; ->$aryFldPtr)
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
	
Function getPrefix_fromStructure()
	//20210106 wat
	//テーブル名からテーブルプリフィックスを取得
	//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。
	
	C_TEXT:C284($1; $tableName)
	$tableName:=$1
	C_TEXT:C284($0; $prefix)
	$prefix:=""
	C_LONGINT:C283($i; $numOfTables)
	C_LONGINT:C283($pos)
	C_BOOLEAN:C305($isValid)
	
	$numOfTables:=Get last table number:C254
	For ($i; 1; $numOfTables)
		
		$isValid:=Is table number valid:C999($i)
		If ($isValid=True:C214)
			If ($tableName=Table name:C256($i))
				$fieldName:=Field name:C257($i; 1)
				
				//最初のアンダースコアより前の文字列をプリフィックスとする
				$pos:=Position:C15("_"; $fieldName)
				$prefix:=Substring:C12($fieldName; 1; $pos-1)
				
			End if 
		End if 
	End for 
	
	$0:=$prefix
	
Function aryFieldPtr_make()
	//20221013 wat
	//フィールドポインタの配列を作成
	
	C_LONGINT:C283($1; $tblNr)  //テーブル番号を得る
	$tblNr:=$1
	C_POINTER:C301($2; $aryFldPtr)
	$aryFldPtr:=$2
	C_LONGINT:C283($0; $numOfFlds)
	$numOfFlds:=0
	C_LONGINT:C283($numOfFields; $i)
	
	//フィールド情報取得
	$numOfFields:=Get last field number:C255($tblNr)
	For ($i; 1; $numOfFields)
		
		If (Is field number valid:C1000($tblNr; $i)=True:C214)
			
			$fldPtr:=Field:C253($tblNr; $i)
			APPEND TO ARRAY:C911($aryFldPtr->; $fldPtr)
			
			
		End if 
		
	End for 
	
	$0:=$numOfFields
	
Function getFieldsAttributes
	//JCL_tbl_Fields_withAttr
	//JCL_tbl_GetFields
	//20130430 yabe
	//フィールド属性をストラクチャから取得して、呼び出し元の配列のポインタに返す
	// 20220516 hisa wat valid検知を追加、削除されているテーブルがあるとエラーになるため。
	
	C_TEXT:C284($1; $tableName)
	$tableName:=$1
	C_POINTER:C301($2; $ioAryFieldName)
	$ioAryFieldName:=$2
	C_POINTER:C301($3; $ioAryFieldType)
	$ioAryFieldType:=$3
	C_POINTER:C301($4; $ioAryFieldLength)
	$ioAryFieldLength:=$4
	C_POINTER:C301($5; $ioAryFieldIndex)
	$ioAryFieldIndex:=$5
	
	C_LONGINT:C283($i; $numOfTables)
	C_LONGINT:C283($k; $numOfFields)
	C_TEXT:C284($name)
	C_LONGINT:C283($type)
	C_LONGINT:C283($len)
	C_BOOLEAN:C305($index)
	C_BOOLEAN:C305($unique)
	C_BOOLEAN:C305($visible)
	C_TEXT:C284($tbName)
	
	DELETE FROM ARRAY:C228($ioAryFieldName->; 1; Size of array:C274($ioAryFieldName->))
	DELETE FROM ARRAY:C228($ioAryFieldType->; 1; Size of array:C274($ioAryFieldType->))
	DELETE FROM ARRAY:C228($ioAryFieldLength->; 1; Size of array:C274($ioAryFieldLength->))
	DELETE FROM ARRAY:C228($ioAryFieldIndex->; 1; Size of array:C274($ioAryFieldIndex->))
	
	$numOfTables:=Get last table number:C254
	
	For ($i; 1; $numOfTables)
		
		If (Is table number valid:C999($i)=True:C214)  // 20220516 hisa wat
			
			$tbName:=Table name:C256($i)
			If ($tbName=$tableName)
				$numOfFields:=Get last field number:C255($i)
				
				For ($k; 1; $numOfFields)
					$name:=Field name:C257($i; $k)
					GET FIELD PROPERTIES:C258($i; $k; $type; $len; $index; $unique; $visible)
					
					APPEND TO ARRAY:C911($ioAryFieldName->; $name)
					APPEND TO ARRAY:C911($ioAryFieldType->; JCL_tbl_Type($type))
					APPEND TO ARRAY:C911($ioAryFieldLength->; String:C10($len))
					APPEND TO ARRAY:C911($ioAryFieldIndex->; String:C10(Num:C11($index); "1;;0"))
					
				End for 
			End if 
			
		End if 
		
	End for 
	