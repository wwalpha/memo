## 概念
* [ ] cloud-init

## 検証
* [ ] Realtime log search
  * [ ] CloudFront log -> Elasticsearch + Kibana
* [ ] ECR + ECS + Fargate
* [ ] 3Tier Model -> CloudFormation


## 実験項目
* [ ] SQSの標準キューでシーケンス情報でFIFO実現
* [ ] SQSのFIFOキューでFIFO実現
* [ ] 一時認証(STS/SAML)の認証

## 2018/06/25 ~ 2018/07/22: **IoT**やりましょう
* [X] Raspberry Pi install
* [X] IOS App Deploy
* 06/28
  * Windows Ver. [TV SideView](https://www.microsoft.com/ja-jp/p/tv-sideview/9wzdncrfj2fw?activetab=pivot%3aoverviewtab) download
  * Wireshark download, SideViewのdiscoveryを監視
  * [mDNS + CastV2](https://qiita.com/vanx2/items/3c20bf8e4111da9eb68d)
  * [参考](http://shimobepapa.hatenadiary.jp/entry/2016/12/18/002916)
* [X] SAA試験
* [ ] IoTについて
  * [ ] DialogFlow
  * [ ] Firebase
  * [ ] Bravia
* [ ] 赤外線について

## 2018/06/18: AWS Solution復習+
* [ ] CPU Burst
* [ ] HVM
* [ ] 拡張ネットワーキング
* [X] 準仮想化
  * 仮想機械へのソフトウェアインタフェースを提供する仮想化技術の一つである
* [ ] EC2Config
* [ ] EC2 Classic
* [ ] Elastic Network Interface
* [ ] Route53
* [X] EC2
  * 汎用
    * T2  | M5 | M4
  * コンピューティング最適化
    * C5  | C4
  * メモリ最適化
    * x1e | X1 | R4
  * 高速コンピューティング
    * P3  | G3 | F1
  * ストレージ最適化
    * H1  | I3 | D2
* [X] Raid
  * [X] Raid0: ストライピング(2HDD)
    * ブロック単位で並行的に書込み、処理速度が速い
  * [X] Raid1: ミラーリング(2HDD)
  * [X] Raid5: **パリティ**RAID(3HDD)
  * [X] Raid6: **ダブルパリティ**RAID(4HDD)
  * [X] Raid0+1: Raid0 + Raid1 高速(4HDD)
  * [X] Raid1+0: Raid1 + Raid0 耐久性(4HDD)
  * [X] Raid5+0: Raid5 + Raid0 耐久性(6HDD)

## 2018/06/11: AWS Solution復習
* [ ] SAA
  * [X] Chapter1
  * [X] Chapter2
  * [X] Chapter3
  * [X] Chapter4
  * [X] Chapter5
  * [X] Chapter6
  * [X] Chapter7
  * [X] Chapter8
  * [X] Chapter9
  * [ ] Chapter10

## 2018/06/04: AWS Solution復習 -> 延期
* [X] AWS WorkSpaces
* [X] AWS Storage Gateway
* [X] Direct Connect

## 2018/05/28: AWS CloudPattern
* [ ] [clouddesignpattern](http://aws.clouddesignpattern.org/index.php/%E3%83%A1%E3%82%A4%E3%83%B3%E3%83%9A%E3%83%BC%E3%82%B8)
  * [ ] 目標月2ドル
* [ ] API: Java -> NodeJS + Lambda
* [ ] DB: RDS -> DynamoDB
* [ ] DynamoDB
  * [ ] Table構築
  * [ ] データ登録
* [ ] sam-local
  * [X] API Gateway構築
  * [X] Lambdaテスト
  * [ ] Lambda deploy

## 2018/05/21: AWS復習
* GSI, LSI
* CloudFormation Functions
* Kinesis
* https://docs.aws.amazon.com/AmazonS3/latest/dev/DataDurability.html
* https://docs.aws.amazon.com/ja_jp/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html
* EBS最適化インスタンス
* AMIのS3移動
* AMIの暗号化
* 仮想VPNゲートウェイ??
* プレースメントグループ??
* DHCPオプションセット??
* CloudWatch　基本メタ
* CloudWatch　カスタム
* auto scalingで扱うインスタンスの種類???
  * ManualScalingパターンやSWF-Scalingパターン
* auto scaling group
  * auto scalingの台数????
* S3 パフォーマンスとの最適化
* S3 web strage pattern
* AWS STS (AWS Security Token Service）
* AWS federationによる連携
* IAMのベストプラクティスは読んでおいたほうがよい。
  * http://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/best-practices.html
* CDNサービスの概要
* エッジロケーションとは何か？
* 署名つきURLを使った配信
* OpsWork???
* AWSのセキュリティのベストプラクティスを読んでおくべき
  * https://d0.awsstatic.com/International/ja_JP/Whitepapers/AWS_Security_Best_Practices.pdf






## 2018/05/14: AWS 検証
* IAM
  * User
  * Group
  * Policy
* Amazon Simple Storage Service(S3)
  * ライフサイクル
  * 暗号化
  * バージョン管理機能
  * アーカイブ及び復元
* Connect to EC2

## 2018/05/07: AWS BlackBelt
* Amazon Simple Storage Service
* Amazon DynamoDB
* Amazon Simple Queue Service
* Amazon Simple Notification Service
* Amazon Simple Workflow Service
* AWS Elastic Beanstalk
* AWS CloudFormation
* AWS SDK によって AWS のサービスを活用し、ソリューションを開発する。
* サービスの認証に AWS Identity and Access Management (IAM) を使用する。
* ユーザー認証にウェブアイデンティティフレームワークと Amazon Cognito を使用する。
* Amazon ElastiCache と Amazon CloudFront を使用してアプリケーションのスケーラビリティを向上させる。
* AWS Elastic Beanstalk と AWS CloudFormation を使用してアプリケーションをデプロイする。

