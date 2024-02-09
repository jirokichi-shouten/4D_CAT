//KV01_lstKV_Make_asign
//FG v202209 2024/02/09 18:05:58
//Z_KeyValue  オブジェクトの配列からリストボックスのプロセス変数へ転送

C_LONGINT($1;$cnt)
$cnt:=$1
C_POINTER($2;$aryObjPtr)
$aryObjPtr:=$2

  //配列数を指定
ARRAY LONGINT(vKV01_lstKV_ID; $cnt)
ARRAY TEXT(vKV01_lstKV_KEY; $cnt)
ARRAY TEXT(vKV01_lstKV_VALUE; $cnt)
ARRAY LONGINT(vKV01_lstKV_LONG_VALUE; $cnt)
ARRAY LONGINT(vKV01_lstKV_DEL_FLAG; $cnt)

For ($i;1;$cnt)
	//サーバ上でゲットした内容をリストボックスに代入、ここで転送が起こる
	vKV01_lstKV_ID{$i}:=$aryObjPtr->{$i}.KV_ID
	vKV01_lstKV_KEY{$i}:=$aryObjPtr->{$i}.KV_KEY
	vKV01_lstKV_VALUE{$i}:=$aryObjPtr->{$i}.KV_VALUE
	vKV01_lstKV_LONG_VALUE{$i}:=$aryObjPtr->{$i}.KV_LONG_VALUE
	vKV01_lstKV_DEL_FLAG{$i}:=$aryObjPtr->{$i}.KV_DEL_FLAG
	
End for 
