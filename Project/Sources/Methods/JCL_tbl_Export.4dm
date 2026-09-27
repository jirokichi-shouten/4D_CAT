//%attributes = {"shared":true}
  //JCL_tbl_export 
  //フィールドプロパティをタブ区切りで書き出し
  //20080807　矢部　新規作成
  //20130430　矢部　JCL4Dに追加

C_LONGINT:C283($i;$numOfTables)

ARRAY TEXT:C222($aryTableName;0)
ARRAY TEXT:C222($aryFieldName;0)
ARRAY TEXT:C222($aryFieldType;0)
ARRAY TEXT:C222($aryFieldLength;0)
ARRAY TEXT:C222($aryFieldIndex;0)

  //ファイル保存ダイアログ表示
$doc:=Create document:C266("";"TEXT")
If ((OK=1) & ($doc#0))
	
	//20260926 Codex/wat テーブル情報取得をJCL_tblクラスに統一
	cs:C1710.JCL_tbl.new().getNames(->$aryTableName)
	$numOfTables:=Size of array:C274($aryTableName)
	
	For ($i;1;$numOfTables)
		
		//20260926 Codex/wat フィールド属性取得をJCL_tblクラスに統一
		cs:C1710.JCL_tbl.new().getFieldsAttributes($aryTableName{$i}; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)
		
		JCL_tbl_ExportTable ($doc;$aryTableName{$i};->$aryFieldName;->$aryFieldType;->$aryFieldLength;->$aryFieldIndex)
		
	End for 
	
	  //ファイルを閉じる
	CLOSE DOCUMENT:C267($doc)
	
	  //終了メッセージ
	ALERT:C41("出力が終わりました。")
	
End if 
