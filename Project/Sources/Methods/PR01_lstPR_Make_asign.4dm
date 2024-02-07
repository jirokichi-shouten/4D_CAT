//PR01_lstPR_Make_asign
//FG v202209 2024/02/07 20:50:34
//PASSWORD_RESETS  オブジェクトの配列からリストボックスのプロセス変数へ転送

C_LONGINT($1;$cnt)
$cnt:=$1
C_POINTER($2;$aryObjPtr)
$aryObjPtr:=$2

  //配列数を指定
ARRAY LONGINT(vPR01_lstPR_ID; $cnt)
ARRAY LONGINT(vPR01_lstPR_US_ID; $cnt)
ARRAY TEXT(vPR01_lstPR_EMAIL; $cnt)
ARRAY TEXT(vPR01_lstPR_TOKEN; $cnt)
ARRAY TEXT(vPR01_lstPR_CREATE_AT; $cnt)
ARRAY LONGINT(vPR01_lstPR_DEL_FLAG; $cnt)

For ($i;1;$cnt)
	//サーバ上でゲットした内容をリストボックスに代入、ここで転送が起こる
	vPR01_lstPR_ID{$i}:=$aryObjPtr->{$i}.PR_ID
	vPR01_lstPR_US_ID{$i}:=$aryObjPtr->{$i}.PR_US_ID
	vPR01_lstPR_EMAIL{$i}:=$aryObjPtr->{$i}.PR_EMAIL
	vPR01_lstPR_TOKEN{$i}:=$aryObjPtr->{$i}.PR_TOKEN
	vPR01_lstPR_CREATE_AT{$i}:=$aryObjPtr->{$i}.PR_CREATE_AT
	vPR01_lstPR_DEL_FLAG{$i}:=$aryObjPtr->{$i}.PR_DEL_FLAG
	
End for 
