//%attributes = {}
//A00_
//20240207 ike wat
//コミットコメントはここでタイプしてからGitHub Desktopに貼ると便利

//20240223 yabe wat
//全テーブル削除を追加
//レコード削除メソッドxx02_btnDeleteのテンプレートを修正。xx02_btnDelは削除

//20240222 wat
//Form01クラスで、02_Inputを生成、OK。

//20240221 wat
//Form01クラスリファクタリング、01_Listに文字列検索機能追加。
//メソッド生成までクラス化。

//20240214 wat
//JCL_prj_FG_tblFrm01V3: テキスト、ボタン、リストボックス生成。
//テーブル番号０のフォルダができる不具合修正。
//01のリストボックスをダブルクリックしても選択状態が取得できない不具合を修正。dataSourceが空だった。（Sが大文字）

//20240212 yabe wat
//JCL_prj_FG_tblFrm01V3: テキスト、ボタン、リストボックス生成。テーブル番号０のフォルダができる不具合。4D異常終了する。

//20240212 wat
//テーブル一覧リストボックス：テーブル追加のあとで色が正しく反映されない不具合を修正。

//20240211 wat
//テーブル一覧リストボックス：クリックで選択解除してもフィールド一覧のタイトルが変化しない不具合を修正

//20240210 wat
//テーブル削除を追加。
//テーブル削除：レコードをTRUNCATEして、テーブルフォルダを中身ごと削除。関連メソッドも削除。
//main画面：テーブル行ダブルクリックでフォーム生成したあとテーブル一覧再作成

//20240209 wat
//テーブル作成：PRIMARY KEYとINDEXに対応。
//02_btnOK：Modで保存されない不具合を修正

//20240208 wat
//main画面のリストボックスを編集不可にした。

//20240208 wat
//main画面、テーブル一覧に色を付けた。
//テーブル一覧で行を選択すると、選択色になってしまって色がわからなくなる。
//このため、クリックでテーブルが選択されたときに右のフィールド一覧のタイトルにも色を付けた。

//20240208 wat
//main画面にフィールド一覧を追加
//テーブルリストをクリックするとフィールド一覧が表示される

//20240207 wat
//main画面のテーブルリストボックスにラベル名と接頭辞を追加。レイアウト調整。

//20240207 hisa ike wat
//OKで保存、に変更。フォーム用テンプレート修正
//add, mod, delなど修正
//フォントを游ゴシックに統一

//20240207 hisa wat
//個別メソッドジェネレータ、JCL_prj_FormGenerator02作成。
//メソッドジェネレータ後にRELOAD PROJECTするとメソッドを認識させやすい
//メソッド生成直後の実行は失敗するので回避。生成までにとどめてもう一度ダブルクリックしてもらう
//fields->field_labelsに変更。

//20240207
//メイン画面にテーブルリストボックスを追加。
//・JSON Parse/Json stringfyを使ったフォームファイル編集機能をテスト中。
//・エラーハンドリング実装中
//・SQLのPrimary keyなどをテスト中
