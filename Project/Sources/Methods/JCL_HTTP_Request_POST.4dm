//%attributes = {"shared":true}
  //zz_HTTP_Request_POST
  //20171121 yabe
  //HTTP Requestを連続で呼ぶとヘッダーが上書きされPOST変数が正しく送信できないためラップする

C_TEXT:C284($1;$url)
$url:=$1
C_TEXT:C284($2;$param)
$param:=$2
C_POINTER:C301($3;$contentsPtr)
$contentsPtr:=$3
C_LONGINT:C283($0;$ret)

  //4DのHTTP Requestは”HTTP POST method”でも”Content-Type”を”text/plain; charset=UTF-8”
  //で送信するため、サーバ側でPOST変数を受ける場合は”application/x-www-form-urlencoded”を設定する
ARRAY TEXT:C222($headerNames;0)
APPEND TO ARRAY:C911($headerNames;"Content-Type")
ARRAY TEXT:C222($headerValues;0)
APPEND TO ARRAY:C911($headerValues;"application/x-www-form-urlencoded")

$ret:=HTTP Request:C1158(HTTP POST method:K71:2;$url;$param;$contentsPtr->;$headerNames;$headerValues;*)

$0:=$ret
