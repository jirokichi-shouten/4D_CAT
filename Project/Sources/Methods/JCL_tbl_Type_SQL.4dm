//%attributes = {"shared":true}
//JCL_tbl_Type_SQL
//JCL_tbl_GetSQLType
//20130429 wat
//zz_sql_GetTypeStr
//20111005 wat
//タイプ文字列を得る
//20150826 yabe wat NOT NULL 追加
//20240121 yabe wat UNIQUE 追加

C_TEXT:C284($1; $type)
$type:=$1  //フィールド型
C_TEXT:C284($2; $char_length)
$char_length:=$2  //文字列長さ
C_TEXT:C284($3; $unique)
$unique:=$3  //ユニーク属性
C_TEXT:C284($0; $sql_type)
C_TEXT:C284($ql_unique)
$ql_unique:=""
If ($unique="1")
	$ql_unique:="UNIQUE"
End if 

Case of 
	: ($type="Is Alpha Field")
		$sql_type:=" VARCHAR("+$char_length+") NOT NULL "+$ql_unique+","
	: ($type="Is Text")
		$sql_type:=" VARCHAR NOT NULL "+$ql_unique+","
	: ($type="Is Real")
		$sql_type:=" REAL NOT NULL "+$ql_unique+","
	: ($type="Is Integer")
		$sql_type:=" INT16 NOT NULL "+$ql_unique+","
	: ($type="Is LongInt")
		$sql_type:=" INT32 NOT NULL "+$ql_unique+","
	: ($type="Is Date")
		$sql_type:=" TIMESTAMP NOT NULL "+$ql_unique+","
	: ($type="Is Time")
		$sql_type:=" INTERVAL NOT NULL "+$ql_unique+","
	: ($type="Is Boolean")
		$sql_type:=" BOOLEAN NOT NULL "+$ql_unique+","
	: ($type="Is Picture")
		$sql_type:=" PICTURE NOT NULL "+$ql_unique+","
		//: ($type=Is Subtable )
		//$sql_type:=" VARCHAR,"
	: ($type="Is BLOB")
		$sql_type:=" BLOB "+$ql_unique+","
End case 

$0:=$sql_type
