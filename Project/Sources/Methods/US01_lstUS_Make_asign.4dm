//US01_lstUS_Make_asign
//FG v202209 2024/02/07 20:51:08
//USERS  オブジェクトの配列からリストボックスのプロセス変数へ転送

C_LONGINT($1;$cnt)
$cnt:=$1
C_POINTER($2;$aryObjPtr)
$aryObjPtr:=$2

  //配列数を指定
ARRAY LONGINT(vUS01_lstUS_ID; $cnt)
ARRAY TEXT(vUS01_lstUS_NAME; $cnt)
ARRAY TEXT(vUS01_lstUS_EMAIL; $cnt)
ARRAY TEXT(vUS01_lstUS_EMAIL_VERIFIED_AT; $cnt)
ARRAY TEXT(vUS01_lstUS_PASSWORD; $cnt)
ARRAY TEXT(vUS01_lstUS_REMEMBER_TOKEN; $cnt)
ARRAY TEXT(vUS01_lstUS_CREATE_AT; $cnt)
ARRAY TEXT(vUS01_lstUS_UPDATE_AT; $cnt)
ARRAY LONGINT(vUS01_lstUS_DEL_FLAG; $cnt)

For ($i;1;$cnt)
	//サーバ上でゲットした内容をリストボックスに代入、ここで転送が起こる
	vUS01_lstUS_ID{$i}:=$aryObjPtr->{$i}.US_ID
	vUS01_lstUS_NAME{$i}:=$aryObjPtr->{$i}.US_NAME
	vUS01_lstUS_EMAIL{$i}:=$aryObjPtr->{$i}.US_EMAIL
	vUS01_lstUS_EMAIL_VERIFIED_AT{$i}:=$aryObjPtr->{$i}.US_EMAIL_VERIFIED_AT
	vUS01_lstUS_PASSWORD{$i}:=$aryObjPtr->{$i}.US_PASSWORD
	vUS01_lstUS_REMEMBER_TOKEN{$i}:=$aryObjPtr->{$i}.US_REMEMBER_TOKEN
	vUS01_lstUS_CREATE_AT{$i}:=$aryObjPtr->{$i}.US_CREATE_AT
	vUS01_lstUS_UPDATE_AT{$i}:=$aryObjPtr->{$i}.US_UPDATE_AT
	vUS01_lstUS_DEL_FLAG{$i}:=$aryObjPtr->{$i}.US_DEL_FLAG
	
End for 
