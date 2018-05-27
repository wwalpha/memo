# DynamoDB
Amazon DynamoDB は、整合性があり、10 ミリ秒未満のレイテンシーを必要とする、すべての規模のアプリケーションに対応した、高速かつフレキシブルな NoSQL データベースサービス

## Point
- [X] ユースケースについて
- [X] スループットを出すためのキャパシティユニット数の計算方法
  - [X] 読み込み時 4KB * 1秒 につき1キャパシティユニット
  - [X] 強い整合性を持つ読み込みの場合は2KB * 1秒 につき1キャパシティユニット
  - [X] 書き込み 1KB * 1秒 につき1キャパシティユニット
- [X] API名やその使い方
- [X] レンジインデックスとハッシュインデックスについて
- [ ] synchronously replicates data across three AZ’s in a region
- [ ] durability with shared data
- [ ] secutiry&permission 
  - [ ] IAM Role that allows write access to the DynamoDB, 
  - [ ] Launch an EC2 Instance with the IAM Role included
- [ ] Secondary Indexes 
  - [ ] gloabl, An index with a hash and range key that can be different from those on the table