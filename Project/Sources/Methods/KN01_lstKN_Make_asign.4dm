//KN01_lstKN_Make_asign
//FG v202209 2024/02/07 18:10:39
//Z_KeyNValue  オブジェクトの配列からリストボックスのプロセス変数へ転送

C_LONGINT($1;$cnt)
$cnt:=$1
C_POINTER($2;$aryObjPtr)
$aryObjPtr:=$2

  //配列数を指定
ARRAY LONGINT(vKN01_lstKN_ID; $cnt)
ARRAY TEXT(vKN01_lstKN_KEY; $cnt)
ARRAY TEXT(vKN01_lstKN_CODE; $cnt)
ARRAY TEXT(vKN01_lstKN_VALUE; $cnt)
ARRAY LONGINT(vKN01_lstKN_LONG_VALUE; $cnt)
ARRAY LONGINT(vKN01_lstKN_SORT_ORDER; $cnt)
ARRAY LONGINT(vKN01_lstKN_DEL_FLAG; $cnt)

For ($i;1;$cnt)
	//サーバ上でゲットした内容をリストボックスに代入、ここで転送が起こる
	vKN01_lstKN_ID{$i}:=$aryObjPtr->{$i}.KN_ID
	vKN01_lstKN_KEY{$i}:=$aryObjPtr->{$i}.KN_KEY
	vKN01_lstKN_CODE{$i}:=$aryObjPtr->{$i}.KN_CODE
	vKN01_lstKN_VALUE{$i}:=$aryObjPtr->{$i}.KN_VALUE
	vKN01_lstKN_LONG_VALUE{$i}:=$aryObjPtr->{$i}.KN_LONG_VALUE
	vKN01_lstKN_SORT_ORDER{$i}:=$aryObjPtr->{$i}.KN_SORT_ORDER
	vKN01_lstKN_DEL_FLAG{$i}:=$aryObjPtr->{$i}.KN_DEL_FLAG
	
End for 
