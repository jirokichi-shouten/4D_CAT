# JCL4D_Core化 検討メモ

作成日: 2026-09-17

## 目的

`4D_CAT` に含まれている共通ライブラリ部分を `JCL4D_Core` として切り出し、`4D_CAT` をテーブル・フォーム・メソッド生成に集中させる。

`JCL4D_Core` は、どの 4D プロジェクトでも利用できる汎用部品の集合とする。
`4D_CAT` は、`fields.txt` を中心にテーブル・フォーム・メソッドを生成するジェネレータとして残す。

## ソース変更コメント規約

Codex が既存の 4D ソース内容を修正する場合は、変更箇所の履歴コメントとして次の形式を残す。

```4d
//YYYYMMDD Codex/wat 変更内容
```

日付は変更実施日を8桁で記述する。ファイル移動だけでソース内容を変更しない場合は追加しない。

## 分離の基本方針

### JCL4D_Core に入れるもの

- 特定の CAT 画面に依存しない
- `fields.txt` の仕様に依存しない
- メソッド生成テンプレートに依存しない
- 一般的な 4D プロジェクトで再利用できる
- 文字列、ファイル、配列、エラー処理、ダイアログ、リストボックス操作などの基礎部品

### 4D_CAT に残すもの

- テーブル生成
- フォーム生成
- メソッド生成
- `fields.txt` / `fields_labels` 管理
- 生成用テンプレート
- CAT 専用画面
- CAT 専用テスト・実験コード

### 保留するもの

- 汎用に見えるが、構造ファイルや CAT の命名規約に依存している可能性があるもの
- 4D Component 化する場合に扱いを確認したいもの
- UIフォーム・Resources・画像などを一緒に移す必要があるもの

## 目標構成案

```text
JCL4D_Core
  Project/Sources/Classes
    JCL_str.4dm
    JCL_tbl.4dm        # 汎用部分のみ。要分割検討。

  Project/Sources/Methods
    JCL_str_*
    JCL_file_*
    JCL_ary_*
    JCL_err_*
    JCL_dlg_*
    JCL_pgs_*
    JCL_lst_*
    JCL_btn_*
    JCL_frm_*
    JCL_obj_*
    JCL_num_*
    JCL_utl_*

  Project/Sources/Forms
    JCL_D80_YesNo
    JCL_D81_NoYes
    JCL_D82_Inform
    JCL_D83_Surprise
    JCL_D84_InputOne
    JCL_D85_Inform_ShowOnDisk
    JCL_D90_ProgressBar

  Resources/JCL4D_Resources
    error_codes.txt
    error_codes_sql.txt
    national_holidays.txt
    pictures/          # Core側フォームが使うものだけ

4D_CAT
  Project/Sources/Classes
    JCL_D00.4dm
    JCL_D01.4dm
    JCL_D02.4dm
    JCL_D20.4dm        # カレンダーを Core にするかは保留
    JCL_fields.4dm
    JCL_formGenerator.4dm
    JCL_formObjects.4dm
    JCL_tableGenerator.4dm
    JCL_Importer_PostgreSQL.4dm

  Resources/JCL4D_Resources
    fields_labels/
    method_templates_model/
    method_templates_list/
    method_templates_form/
    method_templates_form03/
    method_additionals/
    sql_reserved/
```

## Core 候補

### 文字列系

優先度: 高

- `Classes/JCL_str.4dm`
- `Methods/JCL_str_Datemark.4dm`
- `Methods/JCL_str_Datemark_format.4dm`
- `Methods/JCL_str_DocCreateDatemark.4dm`
- `Methods/JCL_str_DocModifyDatemark.4dm`
- `Methods/JCL_str_Extract.4dm`
- `Methods/JCL_str_Extract_byReturn.4dm`
- `Methods/JCL_str_Extract_mp.4dm`
- `Methods/JCL_str_GetWareki.4dm`
- `Methods/JCL_str_IsCharRetrurn.4dm`
- `Methods/JCL_str_IsNumber.4dm`
- `Methods/JCL_str_Keitai_format.4dm`
- `Methods/JCL_str_LastNumber.4dm`
- `Methods/JCL_str_NextNumber.4dm`
- `Methods/JCL_str_Numbers.4dm`
- `Methods/JCL_str_Platform.4dm`
- `Methods/JCL_str_RPos.4dm`
- `Methods/JCL_str_Remove_LeftSpace.4dm`
- `Methods/JCL_str_Week.4dm`
- `Methods/JCL_str_dateTime.4dm`
- `Methods/JCL_str_isComment.4dm`
- `Methods/JCL_str_unifyCR.4dm`
- `Methods/JCL_str_unifyLF.4dm`

確認事項:

- `JCL_str_Extract_mp.4dm` は `shared` / プリエンプティブ対応の意図を確認する。

### ファイル系

優先度: 高

- `Methods/JCL_file_Close.4dm`
- `Methods/JCL_file_CreatedOn.4dm`
- `Methods/JCL_file_DocumentsFolderPath.4dm`
- `Methods/JCL_file_Extension.4dm`
- `Methods/JCL_file_GetDirSeparator.4dm`
- `Methods/JCL_file_GetFromResourcesFolder.4dm`
- `Methods/JCL_file_HTML_toWebArea.4dm`
- `Methods/JCL_file_Logout.4dm`
- `Methods/JCL_file_Logout_mp.4dm`
- `Methods/JCL_file_MakeFilePath.4dm`
- `Methods/JCL_file_OnErrorCall.4dm`
- `Methods/JCL_file_Open.4dm`
- `Methods/JCL_file_OpenForWrite.4dm`
- `Methods/JCL_file_ReadAllSJIS.4dm`
- `Methods/JCL_file_ReadSJIS.4dm`
- `Methods/JCL_file_SelectFileDlg.4dm`
- `Methods/JCL_file_SelectFolder.4dm`
- `Methods/JCL_file_SelectFolder_forWrite.4dm`
- `Methods/JCL_file_SelectSJIS.4dm`
- `Methods/JCL_file_SelectUtf8.4dm`
- `Methods/JCL_file_SelectXMac.4dm`
- `Methods/JCL_file_StructureName.4dm`
- `Methods/JCL_file_Text2Document.4dm`
- `Methods/JCL_file_WriteCRLF.4dm`
- `Methods/JCL_file_WriteSJIS.4dm`
- `Methods/JCL_file_WriteTab.4dm`
- `Methods/JCL_file_csv_ReadRow.4dm`

保留:

- `Methods/JCL_file_SQLOut.4dm`

確認事項:

- `JCL_file_GetFromResourcesFolder.4dm` は Core 側 Resources を読むのか、呼び出し元 Project の Resources を読むのか決める。
- `JCL_file_SQLOut.4dm` は SQL生成ログ用途が強ければ CAT 側に残す。

### 配列系

優先度: 高

- `Methods/JCL_ary_FindInLike.4dm`
- `Methods/JCL_ary_Next_Long.4dm`
- `Methods/JCL_ary_Prev_Long.4dm`
- `Methods/JCL_ary_and.4dm`
- `Methods/JCL_ary_concat.4dm`
- `Methods/JCL_ary_debug_Logout.4dm`
- `Methods/JCL_ary_or.4dm`

確認事項:

- `JCL_ary_debug_Logout.4dm` は `JCL_file_Logout` 依存。Core 内依存として扱える。

### エラー処理

優先度: 高

- `Methods/JCL_err_4D_Error.4dm`
- `Methods/JCL_err_OnErrCall.4dm`
- `Methods/JCL_err_OnErrCall_SQL_EXECUTE.4dm`
- `Methods/JCL_err_OnErrCall_sql.4dm`
- `Methods/JCL_err_OnErrCall_start.4dm`
- `Methods/JCL_err_OnErrCall_stop.4dm`
- `Resources/JCL4D_Resources/error_codes.txt`
- `Resources/JCL4D_Resources/error_codes_sql.txt`

確認事項:

- SQL 用エラー処理は Core に入れる方針でよさそう。ただし CAT の SQL生成機能に寄りすぎていないか確認する。

### ダイアログ系

優先度: 高

- `Methods/JCL_dlg_Inform.4dm`
- `Methods/JCL_dlg_Inform_ShowOnDisk.4dm`
- `Methods/JCL_dlg_InputOne.4dm`
- `Methods/JCL_dlg_NoYes.4dm`
- `Methods/JCL_dlg_Surprise.4dm`
- `Methods/JCL_dlg_YesNo.4dm`
- `Forms/JCL_D80_YesNo`
- `Forms/JCL_D81_NoYes`
- `Forms/JCL_D82_Inform`
- `Forms/JCL_D83_Surprise`
- `Forms/JCL_D84_InputOne`
- `Forms/JCL_D85_Inform_ShowOnDisk`

確認事項:

- 6メソッドと対応する6フォームを第7弾でCoreへ移行した。追加の画像リソースは使用していない。
- 使用例はCAT側の `zz_test_JCL_dlg.4dm` に残す。

### 進捗・待機

優先度: 高

- `Methods/JCL_pgs_Cancel.4dm`
- `Methods/JCL_pgs_DefInit.4dm`
- `Methods/JCL_pgs_GetDenominator.4dm`
- `Methods/JCL_pgs_IsCancel.4dm`
- `Methods/JCL_pgs_Open.4dm`
- `Methods/JCL_pgs_SetValue.4dm`
- `Methods/JCL_pgs_Show.4dm`
- `Forms/JCL_D90_ProgressBar`

確認事項:

- 7メソッドと対応する進捗フォームを第8弾でCoreへ移行した。
- 使用例はCAT側の `zz_test_JCL_pgs.4dm` と `zz_test_JCL_pgs2.4dm` に残す。
- `JCL_wait_*` は進捗メーターを持たない重複実装で、実利用がサンプル内だけだったため削除した。進捗・待機表示は `JCL_pgs_*` に一本化する。

### リストボックス系

優先度: 中〜高

- `Methods/JCL_lst_ColNr_byColName.4dm`
- `Methods/JCL_lst_ColNumber.4dm`
- `Methods/JCL_lst_Copy.4dm`
- `Methods/JCL_lst_Count.4dm`
- `Methods/JCL_lst_Deselect.4dm`
- `Methods/JCL_lst_Export.4dm`
- `Methods/JCL_lst_GetOneRow.4dm`
- `Methods/JCL_lst_GetValue.4dm`
- `Methods/JCL_lst_SelectAll.4dm`
- `Methods/JCL_lst_SelectedCount.4dm`
- `Methods/JCL_lst_SelectedValues.4dm`
- `Methods/JCL_lst_Selected_Long.4dm`
- `Methods/JCL_lst_Selected_Real.4dm`
- `Methods/JCL_lst_Selected_Str.4dm`
- `Methods/JCL_lst_Selected_firstRow.4dm`
- `Methods/JCL_lst_SetSelect_byLong.4dm`
- `Methods/JCL_lst_SetSelect_byRow.4dm`
- `Methods/JCL_lst_SetSelect_byStr.4dm`
- `Methods/JCL_lst_Sort.4dm`
- `Methods/JCL_lst_Sort_Append.4dm`
- `Methods/JCL_lst_Sort_AppendCurrent.4dm`
- `Methods/JCL_lst_Sort_HeaderName.4dm`
- `Methods/JCL_lst_Sort_HeaderReset.4dm`

保留:

- `Methods/JCL_lst_Export_pgs2.4dm`
- `Methods/JCL_lst_Export_pgs4.4dm`
- `Methods/JCL_lst_Make_Join.4dm`
- `Methods/JCL_lst_remake_byStructure.4dm`

確認事項:

- `JCL_lst_remake_byStructure.4dm` は構造ファイル依存が強ければ CAT 側。
- `Export_pgs*` は進捗フォーム依存だけなら Core、CAT 出力仕様に依存するなら保留。

### ボタン・フォーム・オブジェクト系

優先度: 中

- `Methods/JCL_btn_SetEnable.4dm`
- `Methods/JCL_btn_SetEnable_byListCount.4dm`
- `Methods/JCL_btn_SetEnable_byListSelect.4dm`
- `Methods/JCL_btn_SetEnable_byNSelect.4dm`
- `Methods/JCL_btn_SetVisible.4dm`
- `Methods/JCL_frm_AdjustHeight_byFontSize.4dm`
- `Methods/JCL_frm_AdjustWidth_byFontSize.4dm`
- `Methods/JCL_frm_DefaultFontSize.4dm`
- `Methods/JCL_frm_GetObjectSize.4dm`
- `Methods/JCL_frm_isExist.4dm`
- `Methods/JCL_obj_LeftTop.4dm`
- `Methods/JCL_obj_SetVisible.4dm`

確認事項:

- 生成フォームの命名規約や CAT 固有オブジェクト名に依存していないか確認する。

### ポップアップ・印刷・HTTP・数値・ユーティリティ

優先度: 中

- `Methods/JCL_prt_PageBreak.4dm`
- `Methods/JCL_HTTP_Request_POST.4dm`
- `Methods/JCL_num_GetAge.4dm`
- `Methods/JCL_num_GetRGB.4dm`
- `Methods/JCL_num_GetTax.4dm`
- `Methods/JCL_utl_ColorRandom.4dm`
- `Methods/JCL_utl_MacAddress.4dm`
- `Methods/JCL_utl_MachineInfo.4dm`

確認事項:

- `JCL_num_GetTax.4dm` は税率固定なら業務別ライブラリ寄り。
- `JCL_HTTP_Request_POST.4dm` は用途固有のヘッダやURLがないか確認する。

対象外:

- `JCL_pop_*` は、4D標準の `Pop up menu` が選択項目番号を返すためラッパーとしての必要性が薄く、現行CAT内にも呼び出しがないことから削除した。Coreには移行しない。

4Dメニュー文字列の技術メモ:

- `Pop up menu` に渡す項目文字列では、`!` とその直後の1文字がチェック欄の表現として解釈される。
- 旧 `JCL_pop_*` の `!-項目名` は、macOSではチェック欄にハイフンを表示し、Windowsでは標準チェックを表示する記法である。
- この記法が属性の混在状態を表す目的だった可能性はあるが、旧コードとGit履歴から意図を確定できなかった。
- 項目データそのものへ表示用メタ文字を混在させず、必要な箇所でメニュー文字列を組み立てる。

### シリアル番号

優先度: 中〜低

- `Methods/JCL_SerialNumber.4dm`
- `Methods/JCL_SerialNumber_Reset.4dm`

保留:

- `Methods/JCL_tbl_SerialNumber.4dm`
- `Methods/JCL_tbl_SerialNumber_Reset.4dm`
- `Methods/JCL_tbl_ResetSN.4dm`

確認事項:

- テーブルID規約や CAT の生成テーブル規約に依存するなら CAT 側。

## 4D_CAT 側に残す候補

### CAT アプリ・起動・画面

- `Methods/A00_.4dm`
- `Methods/A00_OnStartup.4dm`
- `Methods/A01_DefInit.4dm`
- `Methods/A01_Display.4dm`
- `Methods/A01_SetControlsValues.4dm`
- `Methods/A01_frm.4dm`
- `Methods/A01_frmDefInit.4dm`
- `Methods/A01_frmOnLoad.4dm`
- `Methods/A01_main.4dm`
- `Methods/JCL_D00_Generator.4dm`
- `Forms/A01_main`
- `Forms/JCL_D00_Generator`
- `Forms/JCL_D01_Select`
- `Forms/JCL_D02_Fields`

メモ:

- `A00_.4dm` は変更履歴メモとしての性格が強い。将来的には Documentation へ移してもよい。

### ジェネレータ系クラス

- `Classes/JCL_D00.4dm`
- `Classes/JCL_D01.4dm`
- `Classes/JCL_D02.4dm`
- `Classes/JCL_fields.4dm`
- `Classes/JCL_formGenerator.4dm`
- `Classes/JCL_formObjects.4dm`
- `Classes/JCL_tableGenerator.4dm`
- `Classes/JCL_Importer_PostgreSQL.4dm`

メモ:

- `JCL_Importer_PostgreSQL.4dm` は PostgreSQL dump の `CREATE TABLE` 部から `fields.txt` を生成する補助機能。`fields.txt` 形式に依存するため CAT 側。

### テンプレート・fields・予約語

- `Resources/JCL4D_Resources/fields_labels/`
- `Resources/JCL4D_Resources/method_templates_model/`
- `Resources/JCL4D_Resources/method_templates_list/`
- `Resources/JCL4D_Resources/method_templates_form/`
- `Resources/JCL4D_Resources/method_templates_form03/`
- `Resources/JCL4D_Resources/method_additionals/`
- `Resources/JCL4D_Resources/sql_reserved/`

メモ:

- 生成機能そのものなので CAT 側に残す。

### fields 関連

- `Methods/JCL_fields_Label.4dm`
- `Methods/JCL_fields_cache_TableLabel.4dm`

メモ:

- fields ラベル仕様に依存するため CAT 側。

### メソッド import/export

- `Methods/JCL_all_export.4dm`
- `Methods/JCL_method_JCLexport.4dm`
- `Methods/JCL_method_JCLimport.4dm`
- `Methods/JCL_method_export.4dm`
- `Methods/JCL_method_import.4dm`

保留:

- `Methods/JCL_method_cntLines.4dm`
- `Methods/JCL_method_info.4dm`
- `Methods/JCL_method_isExist.4dm`

確認事項:

- `method_info` / `method_isExist` は汎用なら Core 候補。

## 保留候補

### JCL_tbl 系

`JCL_tbl` 系は Core 化の最大の判断ポイント。
構造情報を読むだけの機能は Core 候補、テーブル生成・SQL生成・CAT固有規約に関わる機能は CAT 側候補。

Core 候補:

- `Classes/JCL_tbl.4dm` の汎用部分
- `Methods/JCL_tbl_DataSourceTypeHint.4dm`
- `Methods/JCL_tbl_Fields_withAttr.4dm`
- `Methods/JCL_tbl_Fld_GetPtr.4dm`
- `Methods/JCL_tbl_GetIDFieldPtr.4dm`
- `Methods/JCL_tbl_GetNumOfRecs.4dm`
- `Methods/JCL_tbl_GetPrefix_fromStructure.4dm`
- `Methods/JCL_tbl_Names_fromStructure.4dm`
- `Methods/JCL_tbl_NumOfFlds.4dm`
- `Methods/JCL_tbl_Prefix.4dm`
- `Methods/JCL_tbl_Ptr_byName.4dm`
- `Methods/JCL_tbl_Type.4dm`
- `Methods/JCL_tbl_aryFieldPtr_make.4dm`
- `Methods/JCL_tbl_aryStrFieldPtr_make.4dm`

CAT 候補:

- `Methods/JCL_tbl_DelAll.4dm`
- `Methods/JCL_tbl_DeleteByAry.4dm`
- `Methods/JCL_tbl_DropAllTables.4dm`
- `Methods/JCL_tbl_Export.4dm`
- `Methods/JCL_tbl_ExportOneSQL.4dm`
- `Methods/JCL_tbl_ExportTable.4dm`
- `Methods/JCL_tbl_FindForeignKey.4dm`
- `Methods/JCL_tbl_GenerateSQL.4dm`
- `Methods/JCL_tbl_GetFormColor.4dm`
- `Methods/JCL_tbl_Index_create.4dm`
- `Methods/JCL_tbl_Names_fromFile.4dm`
- `Methods/JCL_tbl_SetInitValue.4dm`
- `Methods/JCL_tbl_Type_SQL.4dm`
- `Methods/JCL_tbl_UpdateFld_byNewStr.4dm`

確認事項:

- `Classes/JCL_tbl.4dm` を分割するか、そのまま保留するか。
- `JCL_tbl_Type_SQL.4dm` は SQL helper として汎用化するか、CAT 側に残すか。

### カレンダー

- `Classes/JCL_D20.4dm`
- `Forms/JCL_D20_Calendar`
- `Resources/JCL4D_Resources/national_holidays.txt`
- `Resources/JCL4D_Resources/pictures/calendar*.png`

判断:

- 汎用カレンダーダイアログとして独立して使えるなら Core 候補。
- CAT の画面や生成機能に従属しているなら CAT 側。

### Common Window

- `Methods/JCL_CW_Dispatch.4dm`

判断:

- `JCL_CW_Dispatch` が汎用なら Core。CAT 固有なら CAT に残す。

## 削除・隔離候補

### 実験・テスト

- `Methods/zz_file_setText.4dm`
- `Methods/zz_frm_A01.4dm`
- `Methods/zz_newBtnText_make.4dm`
- `Methods/zz_test_CAREATE_INDEX.4dm`
- `Methods/zz_test_D00.4dm`
- `Methods/zz_test_D20.4dm`
- `Methods/zz_test_DeleteMethods.4dm`
- `Methods/zz_test_Extract.4dm`
- `Methods/zz_test_GEtFieldNr.4dm`
- `Methods/zz_test_Import.4dm`
- `Methods/zz_test_JCL_4D_Error.4dm`
- `Methods/zz_test_JCL_dlg_NoYes.4dm`
- `Methods/zz_test_OneToMany.4dm`
- `Methods/zz_test_PG_Importer.4dm`
- `Methods/zz_test_SQL_Execute.4dm`
- `Methods/zz_test_select_document.4dm`
- `Methods/zz_test_setRGBColor.4dm`
- `Methods/zz_test_sql_insert.4dm`

方針:

- Core には入れない。
- 残すなら `Tests` または `Examples` 相当として隔離する。

### `.DS_Store`

- `Resources/JCL4D_Resources/.DS_Store`
- テンプレートフォルダ内の `.DS_Store`

方針:

- Git管理から外す。
- `.gitignore` を整備する。

## 第一段階の作業案

### Phase 1: 分類確定

1. この文書をレビューする。
2. `JCL_tbl` 系を Core / CAT / 保留に分ける。
3. `JCL_D20` カレンダーを Core に入れるか決める。
4. `usage` / `SampleCode` / `zz_test_*` の扱いを決める。

### Phase 2: Core候補の依存関係確認

優先順:

1. `JCL_str_*`
2. `JCL_file_*`
3. `JCL_ary_*`
4. `JCL_err_*`
5. `JCL_dlg_*`
6. `JCL_pgs_*`
7. `JCL_lst_*`
8. `JCL_btn_*` / `JCL_frm_*` / `JCL_obj_*`

確認内容:

- 呼び出している JCL メソッド
- 依存フォーム
- 依存 Resources
- CAT 専用メソッドへの依存
- 4D Component 化した場合の参照可否

### Phase 3: Coreプロジェクト作成方針

候補:

1. 新しい 4D Project として `JCL4D_Core` を作る。
2. 4D Component として配布できる形にする。
3. 当面は `4D_CAT` 内で Core 候補を整理し、依存確認後に切り出す。

推奨:

- 最初は 3。
- 依存関係が整理できたら 1 または 2 に進む。

## 初回移行候補

低リスクで Core 化しやすい候補:

- `Methods/JCL_str_Extract.4dm`
- `Methods/JCL_str_Extract_byReturn.4dm`
- `Methods/JCL_str_unifyCR.4dm`
- `Methods/JCL_str_unifyLF.4dm`
- `Methods/JCL_file_MakeFilePath.4dm`
- `Methods/JCL_file_Extension.4dm`
- `Methods/JCL_ary_concat.4dm`
- `Methods/JCL_ary_and.4dm`
- `Methods/JCL_ary_or.4dm`

理由:

- 生成UIへの依存が薄い。
- 基礎部品として他メソッドから利用される。
- Core 化の効果を確認しやすい。

## 第2弾移行結果（文字列系）

実施日: 2026-09-21

文字列系のうち、CAT 固有の Resources やクラス名前空間に依存しない次のメソッドを `JCL4D_Core` へ移した。

- `JCL_str_Datemark`
- `JCL_str_Datemark_format`
- `JCL_str_DocCreateDatemark`
- `JCL_str_DocModifyDatemark`
- `JCL_str_Extract_mp`
- `JCL_str_GetWareki`
- `JCL_str_IsCharRetrurn`
- `JCL_str_IsNumber`
- `JCL_str_Keitai_format`
- `JCL_str_LastNumber`
- `JCL_str_NextNumber`
- `JCL_str_Numbers`
- `JCL_str_Platform`
- `JCL_str_RPos`
- `JCL_str_Remove_LeftSpace`
- `JCL_str_Week`
- `JCL_str_dateTime`
- `JCL_str_isComment`

全メソッドをホスト公開し、Core 内の相互依存が解決していることを確認した。

保留:

- `Classes/JCL_str.4dm`: CAT が `cs.JCL_str` として参照しており、コンポーネントへ移すとクラス名前空間の変更が必要になるため。

マニュアルとの照合:

- 掲載されている `JCL_str_Datemark` は今回移行した。
- 掲載されている `JCL_str_Extract` は第1弾で移行済み。
- マニュアル掲載の `JCL_str_RandomAlphaNumbers` と `JCL_str_RandomAlphabets` は現行の `4D_CAT` に実装ファイルがなかったため、2026-09-22 にマニュアル掲載コードを基に `JCL4D_Core` へ新規追加した。HTML上で欠けていた改行を補い、4Dのプロジェクトソース形式に合わせた。

## 第2弾移行結果（ファイル系）

実施日: 2026-09-22

ファイル系のうち、Core 内で依存関係が完結する次のメソッドを `JCL4D_Core` へ移した。

- `JCL_file_Close`
- `JCL_file_CreatedOn`
- `JCL_file_DocumentsFolderPath`
- `JCL_file_Logout`
- `JCL_file_Logout_mp`
- `JCL_file_OnErrorCall`
- `JCL_file_Open`
- `JCL_file_OpenForWrite`
- `JCL_file_ReadAllSJIS`
- `JCL_file_ReadSJIS`
- `JCL_file_SelectFileDlg`
- `JCL_file_SelectFolder`
- `JCL_file_SelectFolder_forWrite`
- `JCL_file_SelectUtf8`
- `JCL_file_Text2Document`
- `JCL_file_WriteCRLF`
- `JCL_file_WriteSJIS`
- `JCL_file_WriteTab`
- `JCL_file_csv_ReadRow`

`JCL_file_Open` と `JCL_file_ReadAllSJIS` に残っていた旧名 `Jiro_file_OnErrorCall` は、Core 内の現行名 `JCL_file_OnErrorCall` へ修正した。

保留:

- `JCL_file_GetFromResourcesFolder`: Component とホストのどちらの Resources を読むか未決定。
- `JCL_file_HTML_toWebArea`: Web Area とホストフォームの実行コンテキスト、および固定フォルダ名 `DMS4D_TMP` の整理が必要。
- `JCL_file_SQLOut`: CAT の SQL 出力用途として残す。
- `JCL_file_SelectSJIS`: 固定プロンプトとデバッグ用 `ALERT` があり、汎用化が必要。
- `JCL_file_SelectXMac`: 固定プロンプトがあり、汎用化が必要。
- `JCL_file_StructureName`: Component から `Structure file` を呼んだ場合の対象がホストかCoreかを確認する必要がある。

マニュアルとの照合:

- 掲載されている `JCL_file_Close`、`JCL_file_OpenForWrite`、`JCL_file_WriteCRLF`、`JCL_file_WriteTab`、`JCL_file_WriteSJIS`、`JCL_file_Logout`、`JCL_file_OnErrorCall`、`JCL_file_SelectFolder` は今回移行した。
- 掲載されている `JCL_file_GetDirSeparator` と `JCL_file_MakeFilePath` は第1弾で移行済み。
- マニュアル掲載の `JCL_file_List` と `JCL_print_toPDF` は、現行の `4D_CAT` に実装ファイルがないため今回の対象外。

## 第3弾移行結果

実施日: 2026-09-22

配列・数値・ユーティリティ系のうち、Core 内で依存関係が完結する次のメソッドを `JCL4D_Core` へ移した。

- `JCL_ary_FindInLike`
- `JCL_ary_Next_Long`
- `JCL_ary_Prev_Long`
- `JCL_ary_debug_Logout`
- `JCL_num_GetAge`
- `JCL_num_GetRGB`
- `JCL_num_GetTax`
- `JCL_utl_ColorRandom`
- `JCL_utl_MacAddress`
- `JCL_utl_MachineInfo`

全メソッドをホスト公開した。`JCL_ary_debug_Logout` が使用する `JCL_file_Logout` と、`JCL_utl_MacAddress` が使用する `JCL_str_Extract` は移行済みのため、Core 内で依存関係が完結する。

## 第4弾移行結果

実施日: 2026-09-22

フォーム上のオブジェクトを扱う基本メソッドを `JCL4D_Core` へ移した。

- `JCL_btn_SetEnable`
- `JCL_btn_SetVisible`
- `JCL_obj_LeftTop`
- `JCL_obj_SetVisible`
- `JCL_frm_GetObjectSize`
- `JCL_frm_DefaultFontSize`
- `JCL_frm_AdjustHeight_byFontSize`
- `JCL_frm_AdjustWidth_byFontSize`

全メソッドをホスト公開した。フォントサイズ調整の2メソッドが呼ぶ `JCL_frm_GetObjectSize` も同時に移しており、Core 内依存は解決する。これらのメソッドは現在フォームのオブジェクトやウィンドウに依存するため、ホスト側フォームからコンポーネントメソッドとして呼び、対象オブジェクトに操作が反映されることを4D上で確認する必要がある。

動作確認（ホストフォームから呼び出し）:

- `JCL_btn_SetVisible`: ボタンの表示切り替えを確認済み。
- `JCL_frm_AdjustHeight_byFontSize`: フォントサイズの縮小を確認済み。
- `JCL_frm_AdjustWidth_byFontSize`: 今回はテストを省略。未検証として扱う。
- その他の移行メソッド: 個別の動作確認は未実施。

保留:

- `JCL_btn_SetEnable_byListCount`、`JCL_btn_SetEnable_byListSelect`、`JCL_btn_SetEnable_byNSelect`: 第4弾では `JCL_lst_*` への依存により保留し、第5弾で移行した。
- `JCL_frm_isExist`: テーブルフォーム名の探索を伴うため、コンポーネントからホストのフォームを検索する仕様を確認してから扱う。

## 第5弾移行結果

実施日: 2026-09-22

リストボックスの件数・選択件数を数える基本メソッドと、それを使ってボタンの有効状態を切り替えるメソッドを `JCL4D_Core` へ移した。

- `JCL_lst_Count`
- `JCL_lst_SelectedCount`
- `JCL_btn_SetEnable_byListCount`
- `JCL_btn_SetEnable_byListSelect`
- `JCL_btn_SetEnable_byNSelect`

5メソッドとも既存の `shared:true` 属性を維持し、ソース内容は変更していない。ボタン系3メソッドが呼ぶ `JCL_btn_SetEnable` は第4弾でCoreへ移行済みであり、Core内依存が完結する。

4D上での確認項目:

- 親フォームからボタン系メソッドを呼び、リスト行数が0件と1件以上の場合に有効状態が切り替わること。
- 選択が0件、1件、複数件の場合に、`byListSelect` は1件だけ、`byNSelect` は1件以上でボタンを有効にすること。

動作確認（2026-09-23）:

- ホスト側から `JCL_lst_SelectedCount` とボタン制御メソッドを呼び出すテストを実施済み。
- `JCL_lst_Count` と `JCL_btn_SetEnable_byListCount` の個別確認結果は未記録。

## 第6弾移行結果

実施日: 2026-09-23

リストボックスの選択・値取得・列情報・コピー・ソートを扱う次のメソッドを `JCL4D_Core` へ移した。

- `JCL_lst_Deselect`
- `JCL_lst_SelectAll`
- `JCL_lst_SetSelect_byRow`
- `JCL_lst_SetSelect_byLong`
- `JCL_lst_SetSelect_byStr`
- `JCL_lst_ColNr_byColName`
- `JCL_lst_ColNumber`
- `JCL_lst_Copy`
- `JCL_lst_GetOneRow`
- `JCL_lst_GetValue`
- `JCL_lst_SelectedValues`
- `JCL_lst_Selected_Long`
- `JCL_lst_Selected_Real`
- `JCL_lst_Selected_Str`
- `JCL_lst_Selected_firstRow`
- `JCL_lst_Sort`
- `JCL_lst_Sort_Append`
- `JCL_lst_Sort_AppendCurrent`
- `JCL_lst_Sort_HeaderName`
- `JCL_lst_Sort_HeaderReset`

全メソッドをホスト公開した。`JCL_lst_SetSelect_byStr`、`JCL_lst_ColNr_byColName`、`JCL_lst_Copy` には `shared:true` を追加し、変更履歴コメントを残した。選択・ソート系が呼ぶ他の `JCL_lst_*` メソッドもCore内にあり、依存関係が完結する。

4D上での確認項目:

- 親フォームのリストボックスで、行番号・数値キー・文字列キーによる選択が反映されること。
- 複数選択可能なリストボックスで、全選択と選択解除が反映されること。
- キーに一致する行がない場合に選択が解除され、`byLong` と `byStr` が0を返すこと。
- 列名からの列番号取得、選択値の取得、コピー、ソートが親フォームから動作すること。これらは個別の実行確認が必要。

保留:

- `JCL_lst_Export`、`JCL_lst_Export_pgs2`、`JCL_lst_Export_pgs4`: ダイアログと進捗表示への依存がある。
- `JCL_lst_Make_Join`: ホストのテーブル選択を変更する。
- `JCL_lst_remake_byStructure`: テーブル構造・命名規約への依存がある。

## 第7弾移行結果

実施日: 2026-09-24

汎用ダイアログのメソッドと対応フォームを `JCL4D_Core` へ移した。

- `JCL_dlg_YesNo` / `Forms/JCL_D80_YesNo`
- `JCL_dlg_NoYes` / `Forms/JCL_D81_NoYes`
- `JCL_dlg_Inform` / `Forms/JCL_D82_Inform`
- `JCL_dlg_Surprise` / `Forms/JCL_D83_Surprise`
- `JCL_dlg_InputOne` / `Forms/JCL_D84_InputOne`
- `JCL_dlg_Inform_ShowOnDisk` / `Forms/JCL_D85_Inform_ShowOnDisk`

6メソッドは既存の `shared:true` 属性を維持した。`JCL_dlg_NoYes` の `vJCL_D81_txtMsg` 宣言の誤記を修正し、`YesNo`、`NoYes`、`Inform`、`Inform_ShowOnDisk` にボタン名省略時の初期値を追加した。ソース変更箇所には `//20260924 Codex/wat` を記録した。

CAT側の `zz_test_JCL_dlg` と `zz_test_JCL_dlg_NoYes` は、ホストプロジェクトからの動作確認用として残した。

4D上での確認項目:

- 6種類のダイアログがホスト側から開くこと。
- `YesNo` と `NoYes` で、既定ボタンと戻り値が正しいこと。
- `InputOne` で、OK時だけポインタ先の文字列が更新されること。
- `Inform_ShowOnDisk` から指定ファイルをFinderまたはExplorerに表示できること。

## 第8弾移行結果

実施日: 2026-09-25

進捗表示とキャンセル制御のメソッド群と対応フォームを `JCL4D_Core` へ移した。

- `JCL_pgs_Cancel`
- `JCL_pgs_DefInit`
- `JCL_pgs_GetDenominator`
- `JCL_pgs_IsCancel`
- `JCL_pgs_Open`
- `JCL_pgs_SetValue`
- `JCL_pgs_Show`
- `Forms/JCL_D90_ProgressBar`

`JCL_pgs_GetDenominator` に `shared:true` を追加し、件数範囲の境界で分母が意図しない値になる条件と、到達不能だった条件を修正した。`JCL_pgs_Show` には `New process` が返すプロセス番号の変数宣言を追加した。ソース変更箇所には `//20260925 Codex/wat` を記録した。

CAT側の `zz_test_JCL_pgs` と `zz_test_JCL_pgs2` は、ホストプロジェクトからの動作確認用として残した。

4D上での確認項目:

- ホスト側から進捗フォームを開き、メーター、メッセージ、処理件数が更新されること。
- キャンセルボタンと `JCL_pgs_Cancel` のどちらからでもフォームが閉じ、`JCL_pgs_IsCancel` がキャンセル状態を返すこと。
- `JCL_pgs_GetDenominator` が100、10000、100000、1000000の境界値でそれぞれ意図した分母を返すこと。

## 不要メソッド整理

実施日: 2026-09-24

Coreへの移行候補を見直し、呼び出しがなく、標準機能で代替できるもの、重複実装、使用例だけのメソッドをCATから整理した。この作業はCoreへの移行回数には含めない。

削除:

- `JCL_Add_byInitValues_generate`: 呼び出しがなく、`JCL_tableGenerator.createMethods()` と `method_templates_model/[--TBL_PREFIX]_Add_byInitValues` による現行のテンプレート生成と重複していた。生成コードが存在しない `JCL_Sequence number` と旧プラグイン処理に依存していたため、2026-09-26に削除した。
- `JCL_tbl_DataType`: ジェネレーター用の型変換は `JCL_tbl.dataType()` と重複し、旧メソッドはBLOB対応も不足していたため削除した。
- `JCL_tbl_InitValue`: ジェネレーター用の初期値変換は `JCL_tbl.initValue()` と重複し、旧メソッドはPictureとBLOBの仕様も不足していたため削除した。残存呼び出しは2026-09-26にクラスメソッドへ統一した。
- `JCL_tbl_StrValue`: 2024年3月の生成テンプレート用途で追加されたが、対応タグとテンプレートは同月中に削除され、現行コードに呼び出しがないため削除した。
- `JCL_tbl_GetNumber`: `JCL_tbl.getNumber()` と実装が重複していた。5か所の呼び出しをクラスメソッドへ統一し、2026-09-26に削除した。
- `JCL_str_byResources`: `Resources/jiro` 固定のテキスト読み込みで、汎用版の `JCL_file_GetFromResourcesFolder` と機能が重複し、呼び出しもなかった。
- `JCL_model_saveLong`
- `JCL_model_saveReal`
- `JCL_model_saveText`: 3メソッドとも呼び出しがなく、旧モデル保存用の実装だった。
- `JCL_Notes`: 呼び出しがなく、CATまたはCoreの現行機能として使用されていなかった。
- `JCL_dlg_Wait_Show`: 存在しない旧名 `Jiro_dlg_Wait_Open` と旧インタープロセス変数に依存していた。
- `JCL_fld_SetFontSize_byLen`: 呼び出しがなく、フォームのフォント調整は第4弾で移行した `JCL_frm_AdjustHeight_byFontSize` と `JCL_frm_AdjustWidth_byFontSize` に整理した。
- `JCL_key_NumFilter_onBeforeKey`: 呼び出しがなく、フォームイベントへ直接記述できる小規模な入力フィルターだった。
- `JCL_prt_PageSetup`: 呼び出しがなく、旧コマンド `_O_PAGE SETUP` とホストフォーム名に依存していた。
- `JCL_wait_Cancel`
- `JCL_wait_DefInit`
- `JCL_wait_IsCancel`
- `JCL_wait_Open`
- `JCL_wait_SampleCode`
- `JCL_wait_SetValue`
- `JCL_wait_Show`
- `Forms/JCL_D91_Progress`: `JCL_wait_*` 専用フォーム。進捗・待機表示は `JCL_pgs_*` と `JCL_D90_ProgressBar` に一本化した。

テスト用へ改名:

- `JCL_dlg_usage` → `zz_test_JCL_dlg`
- `JCL_pgs_usage` → `zz_test_JCL_pgs`
- `JCL_pgs_usage2` → `zz_test_JCL_pgs2`

## 開発時とビルド時の構成方針（暫定）

- 開発時は `JCL4D_Core` を独立した隣接リポジトリとして管理し、Core の `.4DProject` ファイルに対する macOS の Finder エイリアスを親プロジェクトの `Components` に置いて参照する。POSIX シンボリックリンクは使用しない。
- 4D プロジェクトをビルドせずに配布する場合は、`JCL4D_Core` をコンポーネントのまま配布する。特にクライアント／サーバー構成では、この方式を基本候補とする。
- 親プロジェクトをビルドして配布する場合は、コンポーネントとして同梱する方法に加え、`JCL4D_Core` のメソッド・クラス・フォーム・Resources を親プロジェクトへ展開してからビルドする方法も候補とする。
- 展開する場合も `JCL4D_Core` を正本とし、親プロジェクトへ展開されたファイルは直接編集しない。
- 展開処理は手作業ではなく、対象ファイル、上書き条件、名前衝突、削除済みファイルを管理できる再現可能なスクリプトまたはビルド工程として実装する。
- 最終的な方式は、解釈実行配布、クライアント／サーバー配布、ビルド済み配布の各形態で検証して確定する。

### OS と 4D バージョンごとの開発時接続

- Dependency Manager を使用しない環境では、macOS は `.4DProject` ファイルの Finder エイリアス、Windows は同ファイルへのショートカットを親プロジェクトの `Components` に置く。
- Finder エイリアスと Windows ショートカットには互換性がなく、別PCでリンク先が変わる可能性もあるため、原則として各開発環境で作成する。
- 4D 20 R6 以降または 4D 21 系へ移行した環境では、`Project/Sources/dependencies.json` と Dependency Manager による参照を検討する。この方式はOS固有のエイリアス／ショートカットを不要にし、ローカルまたはGitHub上のコンポーネントを4Dが解決する。
- `dependencies.json` への切り替えは、対象となる4Dのエディションとバージョンで動作を確認してから行う。現行環境へ無条件には導入しない。

## 未決事項

- ビルド済み配布で 4D Component を同梱するか、ビルド時に親プロジェクトへ展開するか。
- 親プロジェクトへ展開する場合の対象、競合解決、更新・削除方法をどう自動化するか。
- Core 側 Resources の参照パスをどうするか。
- Core に `JCL_D20` カレンダーを含めるか。
- `JCL_tbl` 系を分割するか。
- メソッド名の `JCL_` prefix は維持するか。
- CAT 側から Core をどう参照するか。
- Dependency Manager へ切り替える4Dの対象バージョンと時期。
- バージョン番号・リリースノートをどこで管理するか。
