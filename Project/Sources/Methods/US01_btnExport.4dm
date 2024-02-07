//US01_btnExport
//FG v202209 2024/02/07 17:24:49
//リストボックスの一覧をテキストファイルに書き出す, プログレスバー付き、ShowOnDisk付きpgs4

C_TEXT($name)
$name:="US_"
C_TEXT($filePath)
C_TEXT($title; $msg; $okStr)

$filePath:=JCL_lst_Export_pgs4 (->vUS01_lstUS;->$name;1)
If (OK=1)
	//完了メッセージ表示
	$title:="US01_btnExport"
	$msg:="US01 を書き出しました。"+Char(Carriage return)
	$msg:=$msg+"ファイル名："+$name
	$okStr:="OK"
	JCL_dlg_Inform_ShowOnDisk($title; $msg; $okStr; $filePath)
	
End if 
