//US02_Input_Dup
//FG v202103 2024/02/07 17:24:49
//USERS レコード複製フォーム

C_LONGINT($1)//ID
$US_id:=$1
C_POINTER($2)
C_LONGINT($new_US_id)
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
US02_DefInit 
US02_varMode_Set ("dup")

READ WRITE([USERS])
$new_US_id:=US_Duplicate($US_id)
US02_LoadValues 

$dlg_ok:=US02_Display ($new_US_id)//OK変数の値を保持
If ($dlg_ok#1)
//dupモードの場合は、追加したレコードを完全に削除する
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$new_US_id)
DELETE SELECTION([USERS])

Else 
//更新日をＤＢに保存
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$new_US_id)
US02_SaveValues 
[USERS]US_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([USERS])

End if 

UNLOAD RECORD([USERS])
READ ONLY([USERS])

$2->:=$new_US_id//IDを返す
$0:=$dlg_ok
