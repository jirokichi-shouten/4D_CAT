//testVisible
//20260922 wat
//Core化に伴い、コンポーネントに移したメソッドの動作確認用

C_POINTER:C301($buttonPtr)
$buttonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vA02_btnTest")

JCL_btn_SetVisible($buttonPtr; False:C215)  // 非表示
// JCL_btn_SetVisible($buttonPtr; True)  // 再表示