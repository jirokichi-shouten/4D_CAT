//KN02_Input_Dup
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue レコード複製フォーム

C_LONGINT($1)//ID
$KN_id:=$1
C_POINTER($2)
C_LONGINT($new_KN_id)
C_LONGINT($0;$dlg_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KN02_DefInit 
KN02_varMode_Set ("dup")

READ WRITE([Z_KeyNValue])
$new_KN_id:=KN_Duplicate($KN_id)
KN02_LoadValues 

$dlg_ok:=KN02_Display ($new_KN_id)//OK変数の値を保持
If ($dlg_ok#1)
//dupモードの場合は、追加したレコードを完全に削除する
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$new_KN_id)
DELETE SELECTION([Z_KeyNValue])

Else 
//更新日をＤＢに保存
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$new_KN_id)
KN02_SaveValues 
[Z_KeyNValue]KN_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyNValue])

End if 

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

$2->:=$new_KN_id//IDを返す
$0:=$dlg_ok
