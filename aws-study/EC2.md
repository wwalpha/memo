# EC2 (Elastic Compute Cloud)
クラウド環境上に仮想サーバーを構築するサービス

## Point
- [X] ユーザーデータとメタデータの違い
  - [X] ユーザーデータはインスタンスの起動時にコマンドを渡すことができる。
  - [X] メタデータはインスタンスのpublic IP,Instance Typeなどのインスタンスの各種情報を取得することができる。
- [X] オンデマンドインスタンス
  - [X] 通常で購入するインスタンスのこと
- [X] リザーブドインスタンスとスポットインスタンスの活用
  - [X] リザーブドインスタンスは1年、3年単位でインスタンスを予約して購入することで安く利用できる。
  - [X] スポットインスタンスは入札ベースでインスタンスを購入し、安く利用できる。
- [X] EBS最適化インスタンス
- [X] KMSのキーペアをSSHの鍵にできる
- [ ] EC2のライフサイクルを把握する
- [X] AMI(Amazon Machine Image)
- [X] Amazon EBS-Backed と Instance Store-Backed の違い
  - [X] Instance Storeは停止ができない。
  - [X] AMIは指定したregionのみで使用できる。
  - [X] 暗号化
  - [X] 暗号化されたAMIはprivateとなり、他のアカウントと共有することができない。
- [ ] 基盤にしているソフトウェアは Xen
- [ ] Placement group
- [ ] Amazon Instance Store/EBS-backed instance
- [ ] Security 
  - [ ] EC2 Key Pairs
  - [ ] Security Groups
  - [ ] Connection Tracking
  - [ ] IAM Role
- [ ] Tags 
  - [ ] billing Allocation report
  - [ ] Restriction 
    - [ ] Maximum tags 10
    - [ ] Maximum key length – 128 Unicode characters in UTF-8
    - [ ] Maximum value length – 256 Unicode characters in UTF-8
  - [ ] show 
    - [ ] keyName = value1|value2|value3 or keyName = key1|value1;key2|value2