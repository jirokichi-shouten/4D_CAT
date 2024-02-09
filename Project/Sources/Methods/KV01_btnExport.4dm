//KV01_btnExport
//FG v202209 2024/02/09 18:05:58
//リストボックスの一覧をテキストファイルに書き出す, プログレスバー付き、ShowOnDisk付きpgs4

C_TEXT($name)
$name:="KV_"
C_TEXT($filePath)
C_TEXT($title; $msg; $okStr)

$filePath:=JCL_lst_Export_pgs4 (->vKV01_lstKV;->$name;1)
If (OK=1)
	//完了メッセージ表示
	$title:="KV01_btnExport"
	$msg:="KV01 を書き出しました。"+Char(Carriage return)
	$msg:=$msg+"ファイル名："+$name
	$okStr:="OK"
	JCL_dlg_Inform_ShowOnDisk($title; $msg; $okStr; $filePath)
	
End if 
