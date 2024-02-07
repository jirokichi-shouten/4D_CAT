//KN02_Input_Mod
//FG v202103 2024/02/07 18:10:39
//Z_KeyNValue レコード編集フォーム

C_LONGINT($1;$KN_id)
$KN_id:=$1
C_LONGINT($0;$display_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
KN02_DefInit 
KN02_varMode_Set ("mod")

READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
KN02_LoadValues 
$display_ok:=KN02_Display ($KN_id)//OK変数の値を保持
If ($display_ok=1)

//更新日をＤＢに保存
READ WRITE([Z_KeyNValue])
QUERY([Z_KeyNValue];[Z_KeyNValue]KN_ID=$KN_id)
KN02_SaveValues 
[Z_KeyNValue]KN_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([Z_KeyNValue])

End if 

UNLOAD RECORD([Z_KeyNValue])
READ ONLY([Z_KeyNValue])

$0:=$display_ok
