# CloudWatch
AWSリソースとAWSで実行するアプリケーションをモニタリングするサービス

## Point
- [X] 基本モニタリング
  - [ ] 無料で使える基本モニタリングで取れる値を把握しておく、ハイパーバイザーレベルで取れる項目を取得している、間隔は5分
- [X] 詳細モニタリング
  - [X] 間隔は1分単位
- [ ] カスタムメトリクスの利用
- [X] アラームのステータス
  - [X] OK
  - [X] ALARM
  - [X] INSUFFICIENT_DATA
- [X] CloudWatch Alarm
  - [X] AlarmをトリガーにAuto scalingを縮退することができる。
  - [X] Alarmをトリガーに他のサービスの起動が可能
- [X] デフォルトのログの保持期間14日(今は15か月になっている)
  - [X] http://dev.classmethod.jp/cloud/aws/cloudwatch-extended-15months/
