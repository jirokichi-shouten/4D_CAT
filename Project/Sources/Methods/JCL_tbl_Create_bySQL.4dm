//%attributes = {"shared":true}
////JCL_tbl_Create_bySQL
////JCL_tbl_CreateTable
////zz_CreateTable
////20111005 wat
////20121001 wat rename, 20130430 mod
////テーブルを作成

//C_TEXT($1; $inFileText)
//$inFileText:=$1  //読み込んだファイルの中身
//C_TEXT($2; $inTableName)
//$inTableName:=$2  //テーブル名
//C_LONGINT($3; $inStartLineNr)
//$inStartLineNr:=$3  //テーブル定義始まりの行番号,スタート行番号
//C_TEXT($4; $inPrefix)
//$inPrefix:=$4  //フィールドのプリフィックス
//C_LONGINT($0; $cnt)
//ARRAY TEXT($lineAry; 0)
//ARRAY TEXT($itemAry; 0)
//C_LONGINT($numOfLines; $numOfItems; $sizeOfAry)
//ARRAY TEXT($aryFieldName; 0)  //フィールド名の配列
//ARRAY TEXT($aryFieldType; 0)  //フィールドタイプの配列
//ARRAY TEXT($aryCharLength; 0)  //文字長さの配列
//C_TEXT($sql)

////改行で切り分ける
//$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$lineAry)  //add_ikeda 20221227

////スタート行番号の次の行からフィールド定義を得る
//For ($i; $inStartLineNr+1; $numOfLines)
//DELETE FROM ARRAY($itemAry; 1; Size of array($itemAry))
//$numOfItems:=JCL_str_Extract($lineAry{$i}; Char(Tab); ->$itemAry)
//If (3<=$numOfItems)
//If ($itemAry{1}#"_")
////最初のセルが＿（アンダーバー）じゃなかったらフィールド情報取得
//APPEND TO ARRAY($aryFieldName; $itemAry{1})  //フィールド名
//APPEND TO ARRAY($aryFieldType; $itemAry{2})  //タイプ
//APPEND TO ARRAY($aryCharLength; $itemAry{3})  //文字長さ

//Else 
////最初のセルが＿（アンダーバー）だったらフィールド情報取得は終わり
//$i:=$numOfLines+1  //ループを抜ける

//End if 
//Else 
//$i:=$numOfLines+1  //ループを抜ける

//End if 
//End for 

//$sizeOfAry:=Size of array($aryFieldName)
////テーブル作成
//$sql:="CREATE TABLE "+$inTableName+"("
//For ($i; 1; $sizeOfAry)
////ＳＱＬのカラム定義節を組み立て
//$aryFieldName{$i}:=Replace string($aryFieldName{$i}; " "; "_")
//$aryFieldName{$i}:=$inPrefix+"_"+$aryFieldName{$i}  //20130501
//$typeStr:=JCL_tbl_Type_SQL($aryFieldType{$i}; $aryCharLength{$i})
//$sql:=$sql+$aryFieldName{$i}+$typeStr

//End for 

////最後のカンマを削除して括弧とセミコロンを追加
//$sql:=Substring($sql; 1; Length($sql)-1)
//$sql:=$sql+");"

//ON ERR CALL("")
//ON ERR CALL("JCL_D02_OnErrCall_SQL_EXECUTE")
//SQL LOGIN(SQL_INTERNAL; ""; "")
//SQL EXECUTE($sql)
//SQL LOGOUT
//ON ERR CALL("JCL_OnErrCall")

//$0:=$cnt
