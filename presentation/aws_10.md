# [AWS利用開始時に最低限おさえておきたい10のこと](https://d1.awsstatic.com/webinars/jp/pdf/services/20180403_AWS-BlackBelt_aws10.pdf)

# セキュリティ
- どのようにしてルートアカウントでのログインを保護していますか？
  - AWSルートアカウントは極力使用しない
- マネージメントコンソールやAPIを操作するシステム管理者の役割と権限を、どのように制限していますか？
  - ユーザには最小限の権限を付与する
- AWSのリソースに(アプリケーションやスクリプト、サードパーティのツール等から)自動的にアクセスする場合の権限はどのように制限していますか？
  - 認証情報を埋め込まない
- AWSインフラのログを蓄積し分析していますか？
  - 証跡の取得
- どのようにネットワークやホストベースの境界防御をしていますか？
  - 各レイヤでのセキュリティ対策

## AWSルートアカウントは極力利用しない
### 1. AWSルートアカウントとは？
* アカウント作成に使用したメールアドレスと設定したパスワードでのサインイン
* アカウントの全ての AWS サービスとリソースへの完全なアクセス権限を持つ

### 2. AWSルートアカウントはMFAを設定し、★極力★利用しない
* 十分に強度の強いパスワードを設定したの上、多要素認証(MFA)で保護し、通常は極力利用しないような運用を推奨
* Security CredentialのページからAccess Keyを削除する(ただしAccess Keyを使用していないか確認が必要)

### 3. ルートアカウントではなくIAMを利用する
* AWS Identity and Access Management (IAM)とは？
  - AWSリソースへのアクセスを安全に制御するためのサービス
    - ユーザ/認証情報管理
      - IAMユーザ / パスワード
      - MFA (多要素認証)
      - 認証情報のローテーション
    - アクセス権限管理
      - IAMグループ
      - IAMポリシー
    - AWS リソースへの安全なアクセス
      - IAMロール

## ユーザには最小限の権限を付与する
### 1. IAMユーザとIAMグループとは？
- IAMユーザ
  - AWS操作用のユーザ。マネジメントコンソールへのサインインや、`API`または`CLI`の使用時に利用する
  - 名前、マネジメントコンソールにサインインするためのパスワード、`API`または`CLI`で使用できるアクセスキーで構成されている
  - AWSサービスへのアクセス権限をJSON形式でポリシーを記述する
- IAMグループ
  - IAMユーザをまとめるグループ
  - AWSサービスへのアクセス権限をJSON形式でポリシーを記述

### 2. ユーザに最小限の権限を付与する
* IAMユーザとIAMグループを利用する
* 最小限のアクセス権限から開始し、必要に応じて追加のアクセス権限を付与する

## 認証情報を埋め込まない

### 1. IAMロールとは？
* Amazon EC2のようなAWSサービスに対して、AWS操作権限を付与するための仕組み
* 認証情報はSTS(Security Token Service)で生成し、自動的に認証情報のローテーションが行われる

### 2. EC2やLambdaにはIAMロールを利用
* 認証情報をOSやアプリケーション側に持たせる必要がなく、`認証情報の漏えいリスクを低減可能`
* git-secrets を使った認証情報の管理
  - AWS Labsの認証情報をgitリポジトリにコミットすることを防ぐツール
* コミットの防止
```
$ git secrets --register-aws
$ git add git-secret.py
$ git commit -m "This is a test commit for git-secret"
git-secret.py:1:AWSAccessKeyId = ”AKIAIOSFODNN7EXAMPLE"
git-secret.py:2:AWSSecretKey = " wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY "

[ERROR] Matched one or more prohibited patterns
```

## 証跡取得(ログ取得)

### 1. AWS CloudTrailによる操作ログの取得を設定する
* AWSユーザのAPI操作などのアクションをログ取得保存するサービス
* セキュリティインシデント発生時の分析に活用
* CloudTrailのログをCloudWatch Logsに転送し監視することも可能
  - 全リージョン有効化の上、必要に応じた期間を設定することを推奨

### 2. その他ログも有効化する(手動での有効化が必要)
* ELB
* Amazon CloudFront
* VPC Flow Logs
* Amazon S3バケット
* Amazon API Gateway

## 証跡取得(ログ取得) -> 脅威の検出
### 1. Amazon GuardDutyの活用
* CloudTrailやVPC Flow Logs等のデータから疑わしいアクティビティを検知するサービス
* GuardDutyはAWSが管理する基盤で動作し、エージェント等の導入は不要で性能影響もなし
* 検知したイベントは重度に応じてラベリングされ、推奨される対策とともに提示される

## 各レイヤでのセキュリティ対策
### 1. アクセス設定を必要最低限に設定
* インターネット等の外部からのアクセスを必要最小限に限定していなかったり、不必要なポートが開いていたりサービスが稼働していると外部からの攻撃を受けるリスクとなる

### 2. ネットワークレイヤ –ネットワークACL
* VPCのサブネット単位で設定するスレートレスなファイアーウォール
* ベースラインとなるポリシーを設定するのに用いる

### 3. 各リソース (EC2, Amazon RDSなど) –セキュリティグループ
* インスタンス(グループ)単位に設定するステートフルなファイアーウォール
* サーバの機能や用途に応じたルール設定に適している

### 4. ネットワーク境界での防御オプションを活用


# コスト最適化
- コスト目標に応じてリソースをサイジングしていますか？
  - 適切なサイジング
- コスト効率を高めるために適切な購入オプションの検討を実施していますか？
  - 購入オプションの検討
- AWSのコストをどのように管理していますか？
  - 使用料金の把握

## 適切なサイジング
### 1. AWS CloudWatchでリソース利用状況を把握する
* AWS上で稼働するシステム監視サービス
* システム全体のリソース使用率、アプリケーションパフォーマンスを把握
* 予め設定した閾値を超えたら、メール通知、AutoScalingなどのアクションも可能することも可能
* またCloudWatch LogsでOS上やアプリケーションのログも取得可能

### 2. 利用状況に応じた適切なインスタンスタイプなどを選択
- 使用率が安定している場合
  - 使用率が低い/高い場合は、インスタンスファミリーやタイプの見直し
  - 使用率が適切な場合は、リザーブドインスタンス(後述)の購入も検討
- 使用率が一定でない場合
  - 時刻ごとの台数増減、AutoScaling活用を検討
  - バッファベース(Amazon SQSやAmazon Kinesisを活用した) の処理も検討

### 3. インスタンスタイプの見直しを検討する
- インスタンスファミリーとサイズ
  - 利用特性に合わせて、汎用(M5,M4,T2)、コンピューティング最適化(C5,C4)、メモリ最適化(R4)などのインスタンスファミリーと、サイズ(large,smallなど)を選択
- 最新インスタンスファミリーを活用する
  - 最新インタンスファミリーのほうが高性能かつ安価なことが多い
  - アジアパシフィック(東京)のEC2メモリ最適化インスタンスの価格比較例

### 4. 購入オプションの活用
- 時間課金系サービス
  - AWSには、さまざまな購入オプションがあります。お客様のビジネスニーズに合った最も費用対効果の高い購入オプションを選択してください
- リザーブドインスタンス(RI)の適用箇所を検討
  - コストエクスプローラーのリザーブドインスタンス関連ビューを活用して、適用箇所を検討する。下記はカバレッジ(どれだけ適用されているか)のビュー
  - 後述のコストエクスプローラー有効化の設定が必要
- その他

## 使用料金の把握
### 1. IAMユーザの請求情報へアクセス有効化
* IAMユーザが請求情報にアクセス出来るようにするための設定。IAMポリシーとは別に設定が必要

### 2. コストエクスプローラーの有効化
* 料金情報可視化ツールのコストエクスプローラーも有効化することを推奨

### 3. 請求情報とコスト管理ダッシュボード、請求書
* 利用状況サマリとサービスごとのご利用状況が確認可能
* 日頃から確認することを推奨

### 4. コストエクスプローラー
* サービスごとや、アカウントなど様々なビューで、使用量と使用料金が確認可能
* コストエクスプローラー有効化後のデータが閲覧対象になる

### 5. 請求アラーム(Billing Alert)の活用
* 利用状況を監視し、閾値を越えたら通知することが可能
* 設定した閾値を越えた場合、Simple Notification Service(SNS)にて通知SNSの機能により、EメールやHTTP/HTTPS等で通知出来る


# 信頼性
- どのようにデータのバックアップをしていますか？
  - データのバックアップ
- システムはコンポーネントの障害や不具合に耐えられるようにしていますか？その手段は？
  - 障害や不具合への対策

## データのバックアップ 
### 1. AWS各サービスのバックアップ機能を活用する
- EC2のAMI
  - 必要に応じて、EC2のAmazon マシンイメージ (AMI)を作成
- Amazon EBSのスナップショット
  - 必要に応じて、EBSのスナップショットを取得
  - 作成時はデータ整合性を保つため、静止点を設ける事を推奨
- RDSの自動バックアップ機能
  - 1日1回のスナップショット取得と、スナップショット取得から5分前までのトランザクションログ取得し、Point-in-Timeリカバリ(DBイン
  スタンス作成)を実現
  - 最長35日まで設定可能(それ以上の期間をバックアップしたい場合、手動でのスナップショット取得が可能)

### 2. 障害や不具合への対策
- 単一障害点の排除
  - 冗長化しておくなどの準備が重要
- すぐに出来る対策
  - RDSのMultiAZデプロイメント(オプション)
    - 同期レプリケーション(冗長化)と自動フェイルオーバーを実現
    - データ冗長化と、可用性向上を実現できる
    - 非常に有効なので本番環境では、必ず設定すべきオプション
  - ELB(Elastic Load Balancing)の活用
    - AutoScalingの活用や、各種セキュリティサービスの観点からも活用したい
  - EC2 - AutoScalingの活用
    - 最小台数を設定し、インスタンス異常時にも起動している台数を維持する
  - EC2 - AutoRecovery
    - インスタンスの異常を検知し、復旧する仕組み
    - CloudWatchアラームの"Recover this Instance"を活用
- マネージドサービスの活用
  - AWSの多様なサービスは、大半が「マネージドサービス」お客様からの「○○の管理や運用が大変なので、AWSでマネージドサー
ビスを提供欲しい」という声にお答えした結果として充実

### 3. AWSサポートの活用
- AWSはサポートを(あえて)バンドルしていない
  - デフォルトでは、サポートをバンドルせず、最適なプランを選択できる
  - お客様の「24時間365日体制の電話サポートが必要」「専任担当者アサインが欲しい」「サポート不要なので1円でも安価に利用したい」などの様々なニーズにお答えできるように、3種類のサポートプランをご用意
- Trusted Advisor
  - ご利用実績を元に、自動的にセキュリティリスクの指摘やコスト最適化提案を実施するツール
  - 全項目の確認にはAWSサポート(ビジネスプラン・エンタープライズプラン)が必要
  - ビジネスプラン以上のチェックは50項目以上