# IAM (Identity and Access Management)
AWS操作を権限管理周りの仕組み

## Point
- [X] ロール、ユーザー、グループの違い
- [X] 暗号化
  - [X] 暗号化されIAMは鍵を持つ人以外で共有することができない
- [X] IAMで使う認証情報の種類について
  - [X] アクセスキーID
  - [X] シークレットアクセスキー
  - [X] パスワード
  - [X] MFA(多要素認証)
- [X] 最小責任で設定することがベストプラクティスということを理解する
- [X] JSON形式で記載する
- [X] デフォルトの設定は全拒否
  - [X] 明示的な拒否は明示的な許可よりも優先される。
- [X] AWS STS (AWS Security Token Service）
  - [X] Tokenを利用することで一時的なユーザーを作成し、権限を委譲することができる
- [ ] AWS federationによる連携
- [ ] IAMのベストプラクティスは読んでおいたほうがよい。
  - [ ] http://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/best-practices.html
- [X] IAMの使用自体は無料
- [ ] root account, user, group
- [ ] MultiFactor Authentication 
  - [ ] Security token-based, 6位数字设备
  - [ ] SMS text
- [ ] policy 
  - [ ] An explicit allow overrides default deny
  - [ ] 语法 Principal, action,Effect,Resource,condition
  - [ ] Capability policies, Resource policies, IAM policies
- [ ] Role delegation 
  - [ ] Identity Providers
  - [ ] Amazon Cognito
  - [ ] SAML
  - [ ] Custom Identity broker Federation
  - [ ] Cross account access
  - [ ] EC2 has role, app inside can take role
- [ ] User-based and Resource-based