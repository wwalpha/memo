## CloudWatch
* AWSリソースとAWSで実行するアプリケーションをモニタリングするサービス
* 抑えておきたい点
  - [ ] 基本モニタリング
    - [ ] 無料で使える基本モニタリングで取れる値を把握しておく、ハイパーバイザーレベルで取れる項目を取得している、間隔は5分
  - [ ] 詳細モニタリング
    - [ ] 間隔は1分単位
  - [ ] カスタムメトリクスの利用
  - [ ] アラームのステータス
    - [ ] OK
    - [ ] ALARM
    - [ ] INSUFFICIENT_DATA
  - [ ] CloudWatch Alarm
    - [ ] AlarmをトリガーにAuto scalingを縮退することができる。
    - [ ] Alarmをトリガーに他のサービスの起動が可能
  - [ ] デフォルトのログの保持期間14日(今は15か月になっている)
    - [ ] http://dev.classmethod.jp/cloud/aws/cloudwatch-extended-15months/