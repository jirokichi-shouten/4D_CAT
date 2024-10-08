//%attributes = {}
//A00_
//20240207 ike wat
//コミットコメントはここでタイプしてからGitHub Desktopに貼ると便利

//20240813
//リストボックスのイベントに"onAfterSort"が抜けていた不具合を修正。
//ソート順は_SORT_ORDERという名前の列があればそれをソート順に追加。
//Form02とForm03の使い分けを明確にした。０２は新規追加、０３は修正。_btnOKメソッドを修正。_SaveRecordと_GetObjXXを追加。

//20240731
//０１フォームに「削除されたレコードを表示」チェックボックスを追加
//frm_tempatesフォルダ内のfrm01_v3.txtを使わないようにメソッドでフォームを生成。
//frm_tempatesフォルダ内テンプレートファイルが不要になったため、フォルダごと削除。

//20240730
//JCL_D20: カレンダーアシスト。クラスとフォームを追加。v1.2としてリリースする。

//20240717
//additionalMethods　の仕組みを追加したため、v1.1としてリリースする。

//20240619 ike wat
//additionalMethods を追加: method_additionalsフォルダのメソッド群を、テーブルがあればコピーしてSourcesに追加。

//20240614 wat
//カラー設定でカラーピッカー表示時に元の色をとり損ねていた不具合を修正。

//20240605 ike wat
//$JU_idのような大文字小文字の混在を廃止、フィールドを示す変数名、プロパティ名はすべて大文字とする。ex. $JU_ID:=$objJU.JU_IDとか。

//20240602 wat
//JCLからもfirst recordを削除。

//20240601 wat
//_GetRecordのテンプレートに不具合、READ WRITEにしていたのをREAD ONLYに修正。first recordは不要なのでトル。
//_make_onServerのカウンター変数が重複定義されていたのを修正。$i

//20240529 wat
//_SaveValuesのテンプレートに不具合、不要な代入文を削除。

//20240515 wat
//関連テーブルのfrmOnLoadとbtnOKを修正。リストボックス表示とレコード保存ができるようになった。
//D01: カラーの生成ロジックを見直し。淡い色を出すようにした。

//20240510 hisa wat
//関連テーブルのリストボックス作成メソッドを修正中。
//JCL_tblクラス、JCL_strクラスを追加。
//20240508 hisa ike wat
//catFormをリネーム、JCL_formObjectsに変更。

//20240503 wat yabe
//JCL_formGeneratorをD01とD00の親クラスに設定
//D00に［カラー設定］ボタン追加、カラーピッカーを表示して色設定できるようになった。
//fieldsに列が足りないとき、たとえば７列でエラーになる不具合を修正。インポート時に８列以上ないとテーブル作成しないようにした。

//20240430 wat
//リストボックスの列にデータ型を設定。
//関連テーブルのリストボックスに［＋］ボタンで配列用要素追加時にエラー、データ型をあわせる必要があったので修正。

//20240424 wat
//D00に［全フォーム作成］を追加。生成ロジックをリファクター

//20240417
//JCL_D01_Selectをクラス化。JCL_D01（フォームカラー）とした。
//D01: すでに生成したフォームの色（フォームカラー）を変更する
//不要なメソッドを削除
//D01：［変更］で閉じないで、テーブル一覧を更新して、色が変わったことを確認できるようにした。
//D00：D01を閉じたあとで、テーブル選択解除＆フィールド情報クリア

//20240404
//JCL_prj_FormGeneratorをクラス化。JCL_formGenerator
//JCL_tgクラスをJCL_tableGeneratorに改名

//D00_Generatorをクラス化
//次の課題はJCL_prj_FG_XXをクラス化。おそらく名前はJCL_fg
//ボタンメソッドの修正漏れを修正
//これからJCL_D00をJCL_D02に習ってクラス化する
//ジェネレータフォーム名をJCL_D00_Generatorに変更
//関連テーブルの配列行削除（_btnXXRemove）の不具合を修正
//空白のメイン画面を実装
//return文はv19でエラーになるので変更　$0:=を使う
//フィールドの列幅が適用されていなかった不具合を修正
//クラス化で不要になったJCL_prg_XXメソッドを大量削除。
//クラス化で不要になったJCL_method_XXメソッドを削除。

//20240327 ike wat
//テーブルタイトルはラベルが適用された。
//フィールドラベルは適用された。

//20240319 wat
//fieldsクラス化。JCL_tgクラスとJCL_fieldsクラスで構成する。
//fieldsのラベルファイルは「fields_labels」フォルダに複数ファイルで保存
//D02をクラス化
//JCL_TBLの一部をJCL_tgクラス（jcl table generatorの略）として実装
//fieldsとfields_labelsもJCL_tgクラスに記述する。

//20230314 wat
//メイン画面で［テーブル追加］クリック時にfieldsファイルを読み込む動作を廃止。
//SQL予約語がテーブルに含まれているかをチェック。sql_reservedフォルダにある単語があったらアラート。
//たとえばPostgreSQL用、ANSI、非予約語など、複数ファイルに対応させて、開発者が警告してほしい単語をファイルで追加できる。
//SQLエラーハンドリングを追加

//20240309 yabe wat
//起動時のモードをデザインモードに変更。これで最初の実行時に、まだ開発モードにいっていないためReloadが無視される。
//フォーム：削除ボタンが動かない不具合を修正
//ビフォア・アフター比較：ORの連結記号を２回繰り返していた。v20ではTuelyとかいってエラーにならないが、v19はエラー。

//20240306
//追加／編集画面のタイトルを生成。
//０２フォームもビフォア・アフターで変更チェックしてから保存。
//０３フォームでN件削除。
//IDフィールドの出力を制御。コンパイルエラーをなくした。
//[--FIELD_WO_ID]タグを追加、IDの場合は生成しない生成ロジックを追加。これでコンパイルエラーをなくした。
//フォーム生成後にもう一度テーブル行をダブルクリックする手間を省略

//20240304 hisa wat
//ID列修正不可。関連テーブルのModができた
//・ModのためにDBとリストボックスの値を比較するモジュール
//・リストボックスID列は修正不可
//・フォームのIDフィールドは修正不可

//20240223 yabe wat
//fields出力：プリフィックスにはアンダースコアは含まない。テーブル区切りはハイフン。

//20240223 yabe wat
//全テーブル削除を追加
//レコード削除メソッドxx02_btnDeleteのテンプレートを修正。xx02_btnDelは削除

//20240222 wat
//catFormクラスで、02_Inputを生成、OK。

//20240221 wat
//catFormクラスリファクタリング、01_Listに文字列検索機能追加。
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
