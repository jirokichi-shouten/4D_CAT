# JCL4D_Core化 検討メモ

作成日: 2026-09-16  
目的: `4D_CAT` に含まれる共通ライブラリ部分を `JCL4D_Core` として切り出し、`4D_CAT` をテーブル・フォーム・メソッド生成に集中させる。

この文書は初版の分類メモです。まだコード移動は行わず、まず「Core に入れるもの」「CAT 側に残すもの」「保留するもの」を見える化します。

## 基本方針

`JCL4D_Core` は、どの 4D プロジェクトでも使える汎用部品だけを持つ。

`4D_CAT` は、`fields.txt` を読んでテーブル・フォーム・メソッドを生成するアプリ／ジェネレータとして残す。

判断基準:

- Core: 特定の CAT 画面、生成テンプレート、fields 形式に依存しない。
- CAT: テーブル生成、フォーム生成、メソッド生成、fields 管理、CAT 専用 UI に依存する。
- 保留: 汎用にも見えるが CAT 依存や構造依存が強そうなもの。
- 削除候補: 実験用、旧コード、用途不明、テスト専用。

## 作業時の注意

- いきなりファイル移動しない。まず依存関係を確認する。
- 4D Project mode はメソッド名・フォーム名・リソース参照の影響が大きいため、小さく分けて移す。
- `Project/Sources/Methods/JCL_frm_AdjustHeight_byFontSize.4dm` には既存の未コミット変更があるため、Core化作業では触らない。
- Core へ移す候補は、移動前に CAT 側からの参照を `rg` で確認する。

## 目標構成案

```text
JCL4D_Core
  Project/Sources/Classes
    JCL_str.4dm
    JCL_tbl.4dm        # 要検討。汎用部分だけなら Core
  Project/Sources/Methods
    JCL_str_*
    JCL_file_*
    JCL_ary_*
    JCL_err_*
    JCL_dlg_*
    JCL_pgs_*
    JCL_wait_*
    JCL_lst_*
    JCL_btn_*
    JCL_frm_*
    JCL_obj_*
    JCL_num_*
    JCL_utl_*
  Resources/JCL4D_Resources
    error_codes.txt
    error_codes_sql.txt
    national_holidays.txt
    pictures/          # ダイアログや汎用UIで使うものだけ

4D_CAT
  Project/Sources/Classes
    JCL_D00.4dm
    JCL_D01.4dm
    JCL_D02.4dm
    JCL_D20.4dm        # 要検討。汎用カレンダーなら Core 候補
    JCL_fields.4dm
    JCL_formGenerator.4dm
    JCL_formObjects.4dm
    JCL_tableGenerator.4dm
    JCL_Importer_PostgreSQL.4dm
  Resources/JCL4D_Resources
    method_templates_*
    method_additionals/
    fields_labels/
    sql_reserved/
```

## Core 候補

### 文字列系

Core 化優先度: 高

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
- `Methods/JCL_str_byResources.4dm`
- `Methods/JCL_str_dateTime.4dm`
- `Methods/JCL_str_isComment.4dm`
- `Methods/JCL_str_unifyCR.4dm`
- `Methods/JCL_str_unifyLF.4dm`

メモ:

- `JCL_str_byResources.4dm` は Resources 依存があるため、Core 側 Resources の配置ルールを決めてから移す。
- `JCL_str_Extract_mp.4dm` はマルチプロセス/スレッド安全性の意図を確認する。

### ファイル系

Core 化優先度: 高

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

保留寄り:

- `Methods/JCL_file_SQLOut.4dm`

メモ:

- `JCL_file_SQLOut.4dm` は SQL 生成・ログ用途に寄っていれば CAT 側でもよい。
- `JCL_file_GetFromResourcesFolder.4dm` は Core に置く場合、Core/呼び出しプロジェクトどちらの Resources を見るかを決める必要がある。

### 配列系

Core 化優先度: 高

- `Methods/JCL_ary_FindInLike.4dm`
- `Methods/JCL_ary_Next_Long.4dm`
- `Methods/JCL_ary_Prev_Long.4dm`
- `Methods/JCL_ary_and.4dm`
- `Methods/JCL_ary_concat.4dm`
- `Methods/JCL_ary_debug_Logout.4dm`
- `Methods/JCL_ary_or.4dm`

メモ:

- `JCL_ary_debug_Logout.4dm` は `JCL_file_Logout` に依存する想定。Core 内依存なら問題なし。

### エラー処理

Core 化優先度: 高

- `Methods/JCL_err_4D_Error.4dm`
- `Methods/JCL_err_OnErrCall.4dm`
- `Methods/JCL_err_OnErrCall_SQL_EXECUTE.4dm`
- `Methods/JCL_err_OnErrCall_sql.4dm`
- `Methods/JCL_err_OnErrCall_start.4dm`
- `Methods/JCL_err_OnErrCall_stop.4dm`
- `Resources/JCL4D_Resources/error_codes.txt`
- `Resources/JCL4D_Resources/error_codes_sql.txt`

メモ:

- SQL 用エラー処理を Core に入れるかは判断が必要。ただし汎用 DB 操作でも使えるため、初期候補に入れる。

### ダイアログ系

Core 化優先度: 高

- `Methods/JCL_dlg_Inform.4dm`
- `Methods/JCL_dlg_Inform_ShowOnDisk.4dm`
- `Methods/JCL_dlg_InputOne.4dm`
- `Methods/JCL_dlg_NoYes.4dm`
- `Methods/JCL_dlg_Surprise.4dm`
- `Methods/JCL_dlg_Wait_Show.4dm`
- `Methods/JCL_dlg_YesNo.4dm`
- `Methods/JCL_dlg_usage.4dm`

関連フォーム:

- `Project/Sources/Forms/JCL_D80_YesNo`
- `Project/Sources/Forms/JCL_D81_NoYes`
- `Project/Sources/Forms/JCL_D82_Inform`
- `Project/Sources/Forms/JCL_D83_Surprise`
- `Project/Sources/Forms/JCL_D84_InputOne`
- `Project/Sources/Forms/JCL_D85_Inform_ShowOnDisk`

メモ:

- ダイアログフォームも Core 側へ移す必要がある。
- フォームが Resources の画像に依存している場合、その画像も Core 側候補。

### 進捗・待機

Core 化優先度: 高

- `Methods/JCL_pgs_Cancel.4dm`
- `Methods/JCL_pgs_DefInit.4dm`
- `Methods/JCL_pgs_GetDenominator.4dm`
- `Methods/JCL_pgs_IsCancel.4dm`
- `Methods/JCL_pgs_Open.4dm`
- `Methods/JCL_pgs_SetValue.4dm`
- `Methods/JCL_pgs_Show.4dm`
- `Methods/JCL_pgs_usage.4dm`
- `Methods/JCL_pgs_usage2.4dm`
- `Methods/JCL_wait_Cancel.4dm`
- `Methods/JCL_wait_DefInit.4dm`
- `Methods/JCL_wait_IsCancel.4dm`
- `Methods/JCL_wait_Open.4dm`
- `Methods/JCL_wait_SampleCode.4dm`
- `Methods/JCL_wait_SetValue.4dm`
- `Methods/JCL_wait_Show.4dm`

関連フォーム:

- `Project/Sources/Forms/JCL_D90_ProgressBar`
- `Project/Sources/Forms/JCL_D91_Progress`

メモ:

- `usage` / `SampleCode` は Core 本体ではなく Documentation または Examples に移す選択肢もある。

### リストボックス系

Core 化優先度: 中〜高

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

メモ:

- `JCL_lst_remake_byStructure.4dm` は構造/テーブル依存が強そうなので CAT 寄り。
- `Export_pgs*` は進捗依存だけなら Core、CAT 固有出力なら保留。

### ボタン・フォーム・オブジェクト系

Core 化優先度: 中

- `Methods/JCL_btn_SetEnable.4dm`
- `Methods/JCL_btn_SetEnable_byListCount.4dm`
- `Methods/JCL_btn_SetEnable_byListSelect.4dm`
- `Methods/JCL_btn_SetEnable_byNSelect.4dm`
- `Methods/JCL_btn_SetVisible.4dm`
- `Methods/JCL_fld_SetFontSize_byLen.4dm`
- `Methods/JCL_frm_AdjustHeight_byFontSize.4dm`
- `Methods/JCL_frm_AdjustWidth_byFontSize.4dm`
- `Methods/JCL_frm_DefaultFontSize.4dm`
- `Methods/JCL_frm_GetObjectSize.4dm`
- `Methods/JCL_frm_isExist.4dm`
- `Methods/JCL_obj_LeftTop.4dm`
- `Methods/JCL_obj_SetVisible.4dm`
- `Methods/JCL_key_NumFilter_onBeforeKey.4dm`

メモ:

- `JCL_frm_AdjustHeight_byFontSize.4dm` は現在未コミット変更があるため、Core化作業では一旦触らない。
- 汎用フォーム操作として有用だが、生成フォームの規約に依存していないか確認する。

### ポップアップ・印刷・HTTP・数値・ユーティリティ

Core 化優先度: 中

- `Methods/JCL_pop_Check.4dm`
- `Methods/JCL_pop_CurrentSelected.4dm`
- `Methods/JCL_pop_Get.4dm`
- `Methods/JCL_pop_Init.4dm`
- `Methods/JCL_pop_Make.4dm`
- `Methods/JCL_prt_PageBreak.4dm`
- `Methods/JCL_prt_PageSetup.4dm`
- `Methods/JCL_HTTP_Request_POST.4dm`
- `Methods/JCL_num_GetAge.4dm`
- `Methods/JCL_num_GetRGB.4dm`
- `Methods/JCL_num_GetTax.4dm`
- `Methods/JCL_utl_ColorRandom.4dm`
- `Methods/JCL_utl_MacAddress.4dm`
- `Methods/JCL_utl_MachineInfo.4dm`

メモ:

- `JCL_HTTP_Request_POST.4dm` は汎用だが、認証/用途依存がないか確認する。
- `JCL_num_GetTax.4dm` は税率固定などがあれば Core ではなく業務別ライブラリの方がよい可能性がある。

### モデル保存・シリアル番号

Core 化優先度: 中〜低

- `Methods/JCL_model_saveLong.4dm`
- `Methods/JCL_model_saveReal.4dm`
- `Methods/JCL_model_saveText.4dm`
- `Methods/JCL_SerialNumber.4dm`
- `Methods/JCL_SerialNumber_Reset.4dm`

保留:

- `Methods/JCL_tbl_SerialNumber.4dm`
- `Methods/JCL_tbl_SerialNumber_Reset.4dm`
- `Methods/JCL_tbl_ResetSN.4dm`

メモ:

- テーブル構造や ID 命名規約に依存していれば CAT 側。
- 汎用ユーティリティとして切れるなら Core。

## CAT 側に残す候補

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
- `Methods/JCL_A00_OnStartup.4dm`
- `Methods/JCL_A01_Display.4dm`
- `Methods/JCL_A01_main.4dm`
- `Methods/JCL_D00_Generator.4dm`
- `Project/Sources/Forms/A01_main`
- `Project/Sources/Forms/JCL_D00_Generator`
- `Project/Sources/Forms/JCL_D01_Select`
- `Project/Sources/Forms/JCL_D02_Fields`

メモ:

- `A00_.4dm` は変更履歴メモとしての性格が強い。将来的には Documentation へ移す候補。

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

- `JCL_Importer_PostgreSQL.4dm` は fields.txt 生成補助に縮退済み。CAT の fields 形式に依存するため CAT 側。

### テンプレート・fields・予約語

- `Resources/JCL4D_Resources/method_templates_model/`
- `Resources/JCL4D_Resources/method_templates_list/`
- `Resources/JCL4D_Resources/method_templates_form/`
- `Resources/JCL4D_Resources/method_templates_form03/`
- `Resources/JCL4D_Resources/method_additionals/`
- `Resources/JCL4D_Resources/fields_labels/`
- `Resources/JCL4D_Resources/sql_reserved/`

メモ:

- これらは CAT の生成機能そのものなので Core には入れない。

### fields 関連メソッド

- `Methods/JCL_fields_Label.4dm`
- `Methods/JCL_fields_cache_TableLabel.4dm`

メモ:

- fields ラベル仕様に依存するため CAT 側。

### メソッド import/export・生成

- `Methods/JCL_Add_byInitValues_generate.4dm`
- `Methods/JCL_all_export.4dm`
- `Methods/JCL_method_JCLexport.4dm`
- `Methods/JCL_method_JCLimport.4dm`
- `Methods/JCL_method_export.4dm`
- `Methods/JCL_method_import.4dm`

保留:

- `Methods/JCL_method_cntLines.4dm`
- `Methods/JCL_method_info.4dm`
- `Methods/JCL_method_isExist.4dm`

メモ:

- `method_info` / `method_isExist` は汎用なら Core 候補。ただし CAT の import/export と一体なら CAT 側。

## 保留候補

### `JCL_tbl` 系

`JCL_tbl` は Core 化で一番判断が必要。

Core 候補:

- `Classes/JCL_tbl.4dm` のうち、テーブル名取得・フィールドポインタ取得・型変換などの汎用部分
- `Methods/JCL_tbl_DataSourceTypeHint.4dm`
- `Methods/JCL_tbl_DataType.4dm`
- `Methods/JCL_tbl_Fields_withAttr.4dm`
- `Methods/JCL_tbl_Fld_GetPtr.4dm`
- `Methods/JCL_tbl_GetIDFieldPtr.4dm`
- `Methods/JCL_tbl_GetNumOfRecs.4dm`
- `Methods/JCL_tbl_GetNumber.4dm`
- `Methods/JCL_tbl_GetPrefix_fromStructure.4dm`
- `Methods/JCL_tbl_Names_fromStructure.4dm`
- `Methods/JCL_tbl_NumOfFlds.4dm`
- `Methods/JCL_tbl_Prefix.4dm`
- `Methods/JCL_tbl_Ptr_byName.4dm`
- `Methods/JCL_tbl_StrValue.4dm`
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
- `Methods/JCL_tbl_InitValue.4dm`
- `Methods/JCL_tbl_Names_fromFile.4dm`
- `Methods/JCL_tbl_SetInitValue.4dm`
- `Methods/JCL_tbl_Type_SQL.4dm`
- `Methods/JCL_tbl_UpdateFld_byNewStr.4dm`

メモ:

- テーブル構造を読むだけなら Core。
- テーブルを作る、削除する、SQLを生成する、CAT のフォーム色や fields ファイルに依存するものは CAT。
- `JCL_tbl_Type_SQL.4dm` は SQL生成で使うため CAT 寄り。ただし汎用 SQL helper として切るなら別モジュール。

### カレンダー

- `Classes/JCL_D20.4dm`
- `Project/Sources/Forms/JCL_D20_Calendar`
- `Resources/JCL4D_Resources/national_holidays.txt`
- `Resources/JCL4D_Resources/pictures/calendar*.png`

判断:

- 汎用カレンダーダイアログとして使えるなら Core 候補。
- CAT の生成UIに従属しているなら CAT 側。

現時点では「保留」。独立性を確認してから決める。

### Common Window / Notes

- `Methods/JCL_CW_Dispatch.4dm`
- `Methods/JCL_Notes.4dm`

判断:

- 用途が汎用なら Core。
- CAT デバッグや内部メモ用途なら CAT または削除候補。

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
- 残すなら `Tests` または `Examples` 相当の場所へ隔離する。
- 4D Project mode 上でフォルダ分け可能か確認する。

### `.DS_Store`

- `Resources/JCL4D_Resources/.DS_Store`
- 各テンプレートフォルダ内の `.DS_Store`

方針:

- Git管理から外せるなら削除候補。
- `.gitignore` の整備も検討。

## 第一段階の具体作業案

### Phase 1: 分類確定

1. この文書をレビューする。
2. `JCL_tbl` 系を Core/CAT に分割する基準を決める。
3. `JCL_D20` カレンダーを Core に入れるか決める。
4. `usage` / `SampleCode` / `zz_test_*` の扱いを決める。

### Phase 2: Core候補の依存関係確認

優先して確認する順:

1. `JCL_str_*`
2. `JCL_file_*`
3. `JCL_ary_*`
4. `JCL_err_*`
5. `JCL_dlg_*`
6. `JCL_pgs_*` / `JCL_wait_*`

確認内容:

- 呼び出している JCL メソッド
- 依存フォーム
- 依存 Resources
- CAT 専用メソッドへの依存

### Phase 3: Coreプロジェクトの作成方針

候補:

1. 新しい 4D Project として `JCL4D_Core` を作る。
2. 4D Component として配布できる形にする。
3. 当面は `4D_CAT` 内に `Core候補` を残し、ドキュメントと依存整理だけ進める。

推奨:

- 最初は 3。
- 依存関係が見えたら 1 または 2 に進む。

## 初回移行候補

まず Core 化しやすい低リスク候補:

- `JCL_str_Extract.4dm`
- `JCL_str_Extract_byReturn.4dm`
- `JCL_str_unifyCR.4dm`
- `JCL_str_unifyLF.4dm`
- `JCL_file_MakeFilePath.4dm`
- `JCL_file_Extension.4dm`
- `JCL_ary_concat.4dm`
- `JCL_ary_and.4dm`
- `JCL_ary_or.4dm`

理由:

- 生成UIへの依存が薄い。
- 他メソッドから使われる基礎部品で、Core 化の効果が大きい。

## 未決事項

- Core は 4D Component として配布するのか、Project source としてコピーするのか。
- Core 側 Resources の参照パスをどうするか。
- Core にフォームを含めるか。含めるならダイアログ/進捗/カレンダーの扱い。
- メソッド名の `JCL_` prefix は維持するか。
- CAT 側から Core をどう参照するか。
- バージョン番号・リリースノートをどこで管理するか。

