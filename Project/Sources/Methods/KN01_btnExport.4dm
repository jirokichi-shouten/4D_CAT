//KN01_btnExport
//FG v202209 2024/02/09 18:04:40
//リストボックスの一覧をテキストファイルに書き出す, プログレスバー付き、ShowOnDisk付きpgs4

C_TEXT($name)
$name:="KN_"
C_TEXT($filePath)
C_TEXT($title; $msg; $okStr)

$filePath:=JCL_lst_Export_pgs4 (->vKN01_lstKN;->$name;1)
If (OK=1)
	//完了メッセージ表示
	$title:="KN01_btnExport"
	$msg:="KN01 を書き出しました。"+Char(Carriage return)
	$msg:=$msg+"ファイル名："+$name
	$okStr:="OK"
	JCL_dlg_Inform_ShowOnDisk($title; $msg; $okStr; $filePath)
	
End if 
