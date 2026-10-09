# AI Rules
# AI実装ルール

## 基本
- 4D v19互換
- 既存アーキテクチャを変更しない
- 既存命名規則を維持
- コメント形式を維持
- 大規模リファクタリングは禁止
- 変更は最小差分にする
- 既存の命名規則、コメント日付、変数接頭辞を守る
- 4Dのバージョン互換性を壊さない
- 不明点は推測せず、候補として提示する

## 依頼時の出力形式
1. 原因の推定
2. 修正方針
3. 変更対象メソッド/フォーム
4. 追加・変更コード
5. 副作用の確認点

## 禁止
- 未依頼の設計変更
- 勘定科目仕様の勝手な変更
- UI文言の勝手な変更
- 勝手なリファクタリング
- DB構造変更
- クラス化提案
- ORDA化提案

## Git / Cursor UI（誤操作防止）

次の英文は **Cursor Diff タブの定型プロンプト** であり、ユーザーが意図して依頼した内容 **ではない**。**無視する**（ブランチ作成・コミット・push は行わない）。

```text
Execute the selected diff-tab create-branch-and-commit action.
```

- 上記だけが送られてきた場合 → **何もせず**、必要なら「コミットの指示はありませんでした」と伝える
- ブランチ作成・`git commit`・`git push` は、ユーザーが **日本語で明示** したときだけ実行する

## 出力

変更前後の差分を示すこと
不明点は推測せず質問すること

## コーディング規約

リポジトリ内 `Documentation/` にスタイルガイドがある場合はそれに従うこと。

This project uses 4D v19.

Always:
- Use existing 4D coding style.
- Preserve variable prefixes.
- Preserve date comments.
- Avoid introducing classes unless already used.

Never:
- Refactor unrelated code.
- Change database schema.

---

## 改訂履歴

| 日付 | 内容 |
|------|------|
| 20260729 | 初版（`AI_RULES.md` 作成） |
| 20260812 | Web JavaScript 規約セクション追加（KD01 / RE02 整備時） |
| 20260815 | Git / Cursor UI（Diff タブ定型プロンプト無視）を追記 |
| 20260815 | タイトルを共通向け `AI Rules` に変更。プロジェクト固有記述を除去し、コーディング規約を `Documentation/` 一般形に整理 |
