## IAM (Identity and Access Management)
* AWS操作を権限管理周りの仕組み
* 抑えておきたい点
  * ロール、ユーザー、グループの違い
  * 暗号化
    * 暗号化されIAMは鍵を持つ人以外で共有することができない
  * IAMで使う認証情報の種類について
    * アクセスキーID
    * シークレットアクセスキー
    * パスワード
    * MFA(多要素認証)
  * 最小責任で設定することがベストプラクティスということを理解する
  * JSON形式で記載する
  * デフォルトの設定は全拒否
    * 明示的な拒否は明示的な許可よりも優先される。
  * AWS STS (AWS Security Token Service）
    * Tokenを利用することで一時的なユーザーを作成し、権限を委譲することができる
  * AWS federationによる連携
  * IAMのベストプラクティスは読んでおいたほうがよい。
    * http://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/best-practices.html
  * IAMの使用自体は無料