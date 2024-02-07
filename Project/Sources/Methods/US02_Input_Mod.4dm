//US02_Input_Mod
//FG v202103 2024/02/07 17:24:49
//USERS レコード編集フォーム

C_LONGINT($1;$US_id)
$US_id:=$1
C_LONGINT($0;$display_ok)//システム変数OKを保持

//モードを渡す、フォームの［削除］ボタンを非表示にするためだったり．．
US02_DefInit 
US02_varMode_Set ("mod")

READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
US02_LoadValues 
$display_ok:=US02_Display ($US_id)//OK変数の値を保持
If ($display_ok=1)

//更新日をＤＢに保存
READ WRITE([USERS])
QUERY([USERS];[USERS]US_ID=$US_id)
US02_SaveValues 
[USERS]US_UPDATE_DATEMARK:=JCL_str_Datemark (Current date;Current time)
SAVE RECORD([USERS])

End if 

UNLOAD RECORD([USERS])
READ ONLY([USERS])

$0:=$display_ok
