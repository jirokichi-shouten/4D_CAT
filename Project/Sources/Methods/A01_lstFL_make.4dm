//%attributes = {}
//A01_lstFL_make
//20240208 wat
//テーブル番号から、ストラクチャーからフィールド情報を取り出して配列要素に追加

C_LONGINT:C283($1; $tblNr)
$tblNr:=$1
C_LONGINT:C283($numOfFields; $i)
C_TEXT:C284($field_name)
C_LONGINT:C283($type; $length)
C_BOOLEAN:C305($index; $unique; $invisible)
C_TEXT:C284($comment; $remark)

//フィールド情報取得
$numOfFields:=Get last field number:C255($tblNr)
For ($i; 1; $numOfFields)
	
	If (Is field number valid:C1000($tblNr; $i)=True:C214)
		
		$field_name:=Field name:C257($tblNr; $i)
		GET FIELD PROPERTIES:C258($tblNr; $i; $type; $length; $index; $unique; $invisible)
		
		APPEND TO ARRAY:C911(vA01_lstFL_Nr; $i)  //フィールド番号
		APPEND TO ARRAY:C911(vA01_lstFL_NAME; $field_name)  // フィールド名
		APPEND TO ARRAY:C911(vA01_lstFL_DATA_TYPE; String:C10($type))  // データ型
		APPEND TO ARRAY:C911(vA01_lstFL_LENGTH; $length)  // 文字長さ
		APPEND TO ARRAY:C911(vA01_lstFL_INDEX; $index)  // True = インデックス付き、False = インデックスなし
		APPEND TO ARRAY:C911(vA01_lstFL_UNIQUE; $unique)  // True = 重複不可、 False = 重複あり
		APPEND TO ARRAY:C911(vA01_lstFL_INVISIBLE; $invisible)  // True = 非表示、 False = 表示
		
		//以下、field_labelsから取得
		$fldLabel:=JCL_fields_Label($field_name)
		$comment:=JCL_fields_Comment($field_name)
		$remark:=JCL_fields_Remark($field_name)
		APPEND TO ARRAY:C911(vA01_lstFL_LABEL; $fldLabel)  // フィールドラベル（論理名）
		APPEND TO ARRAY:C911(vA01_lstFL_COMMENT; $comment)  // 説明
		APPEND TO ARRAY:C911(vA01_lstFL_REMARK; $remark)  // サンプルデータ等
		
	End if 
End for 
