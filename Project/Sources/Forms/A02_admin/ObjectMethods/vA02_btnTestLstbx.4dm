//vA02_btnTestHeight
//20260922 wat
//Core化に伴い、コンポーネントに移したメソッドの動作確認用
//20260923 Codex/wat 選択数の期待値を実際のTrue件数に合わせた

ARRAY BOOLEAN:C223($selected; 4)
$selected{1}:=False:C215
$selected{2}:=False:C215
$selected{3}:=True:C214
$selected{4}:=False:C215

C_LONGINT:C283($count)
$count:=JCL_lst_SelectedCount(->$selected)

ALERT:C41("選択数: "+String:C10($count))  // 1 と表示されれば成功

JCL_btn_SetEnable_byListSelect(->$selected; ->vA02_btnTest)

JCL_btn_SetEnable_byNSelect(->$selected; ->vA02_btnTestHeight)
