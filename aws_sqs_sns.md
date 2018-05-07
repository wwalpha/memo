# [Amazon Simple Queue Service(SQS) And Amazon Simple Notification Service(SNS)](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-tech-amazon-sqs-amazon-sns)
* Amazon Simple Queue Service (SQS)
* Amazon Simple Notification Service (SNS)
* SQSとSNSを組み合わせた構成
* まとめ

## Amazon Simple Queue Service (SQS)
* 長い歴史を持つ『メッセージキュー』サービス

## メッセージキューサービスとは？
### Message Queue
* ソフトウェアの世界では古くからある概念。MQと略されることも
* メッセージキュー（英: Message queue）は、プロセス間通信や同一プロセス内のスレッド間通信に使われるソフトウェアコンポーネントである。制御やデータを伝達するメッセージのキューである。
* Amazon SQSはPull型のMQサービス
  * 受信側はSQSに問い合わせてメッセージ取得

### Amazon SQSはAWSフルマネージドな分散キュー
* 高い信頼性： 複数のサーバー/データセンターにメッセージを保持
* スケーラブル： 多数の送信者/受信者に対応
* 高スループット： メッセージが増加しても高スループットを出し続ける
* 低コスト： 毎月の無料枠 + 使った分だけの従量課金

### SQSを使う利点: 疎結合 * Loosely Coupled
* 例えば、以下のようなケース
  * ユウタさん: 今すぐ、大量のデータ登録をしたい。
  * ヒロシさん: 今は負荷が高いので困る。一定間隔で少しずつなら…

### Amazon SQSで利用する識別子
* Queue URL（キューURL）
  * キューを作成する際に払い出されるURL
  * https://sqs.リージョン.amazonaws.com/アカウントID/キュー名
* Message ID（メッセージID）
  * システムで割り当てられたID （例：0a41026d-283b-4e5c-9b3f-debffb709ef4）
* Receipt Handle（受信ハンドル）
  * メッセージの削除や可視性(Visibility)の変更には、"受信ハンドル"を指定する必要がある
  * メッセージを受信するたびに"受信ハンドル"も受信する
  * 同じメッセージでも、受信する度に異なる"受信ハンドル"を受け取る
  * このため、常に最新の受信ハンドルを使って削除等をすること

### Amazon SQSをはじめるのは簡単です
* キューの作成（que01という名前のキューを作る）
  * 例：リージョン指定（ここでは東京）
```
C:￥> aws sqs create-queue --queue-name que01 --region ap-northeast-1
```
  * 実行結果：キューURLが表示される
```
{
"QueueUrl": "https://ap-northeast-1.queue.amazonaws.com/＜アカウントID＞/que01"
}
```
  * 例：リージョン指定せず（デフォルトはバージニア北部（us-east-1））
```
C:￥> aws sqs create-queue --queue-name que02
```
  * 実行結果： （us-east-1のときは、queue.amazon.comとなる）
```
{
"QueueUrl": "https://queue.amazonaws.com/＜アカウントID＞/que02"
}
```

* キューの一覧表示: 作成されたことを確認
  * 例： デフォルトリージョンが「オレゴン」（us-west-2）の場合
```
C:￥> aws sqs list-queues
```
* 結果： 存在するキューの、リージョン名付のキューURLが返却されている
```
{
  "QueueUrls": [
    "https://us-west-2.queue.amazonaws.com/ ＜アカウントID＞ /que011",
    "https://us-west-2.queue.amazonaws.com/ ＜アカウントID＞ /que012",
    ～ （中略） ～
    "https://us-west-2.queue.amazonaws.com/ ＜アカウントID＞ /que019"
  ]
}
```

* メッセージの送信
  * 例： デフォルトリージョンが「オレゴン」（us-west-2）の場合（１行で）
```
C:￥> aws sqs send-message --queue-url https://us-west-2.queue.amazonaws.com/＜アカウントID＞ /que011 --message-body AAAAAAAAAAAAAAAAAAAAA
```
  * 結果： ハッシュされた結果とメッセージIDが返却される
```
{
"MD5OfMessageBody": "5bc308c3d25645d2516222e055134c04",
"MessageId": "fc7d64b4-b015-4dd7-b118-11c20fcd85ac"
}
```

* メッセージの受信
  * 例： デフォルトリージョンが「オレゴン」（us-west-2）の場合
```
C:￥> aws sqs receive-message --queue-url https://us-west-2.queue.amazonaws.com/＜アカウントID＞ /que011
```
  * 結果： メッセージと共に、「受信ハンドル」や「メッセージID」も返却される
```
{
  "Messages": [
    {
      "Body": "'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'",
      "ReceiptHandle": "AQEBP3Zah1+ofjs… ～中略～ …ryXHENpytJ2kAAOFI8n4wr03bVog==",
      "MD5OfBody": "5bc308c3d25645d2516222e055134c04",
      "MessageId": "fc7d64b4-b015-4dd7-b118-11c20fcd85ac"
    }
  ]
}
```

* メッセージの削除
  * 例： デフォルトリージョンが「オレゴン」（us-west-2）の場合
```
C:￥> aws sqs delete-message --queue-url https://us-west-2.queue.amazonaws.com/＜アカウントID＞ /que011
--receipt-handle "AQEBP3Zah1+ofjs… ～中略～ …ryXHENpytJ2kAAOFI8n4wr03bVog=="
```
  * 結果： 何も返却されない

### AWS SDK編
* キューの作成
```
AmazonSQS sqs = new AmazonSQSClient();
CreateQueueRequest createQueueRequest = new CreateQueueRequest("MyQueue");
String myQueueUrl = sqs.createQueue(createQueueRequest).getQueueUrl();
```

* メッセージの送信
```
sqs.sendMessage(new SendMessageRequest(myQueueUrl,"Hello World! "));
```

* メッセージの受信
```
ReceiveMessageRequest receiveMessageRequest = new ReceiveMessageRequest(myQueueUrl);
List<Message> messages = sqs.receiveMessage(receiveMessageRequest).getMessages();
for (Message message : messages) {
// 取得したメッセージを元に処理
}
```

* メッセージの削除
```
String messageRecieptHandle = messages.get(0).getReceiptHandle();
sqs.deleteMessage(new DeleteMessageRequest(myQueueUrl, messageRecieptHandle));
```

* キューの削除
```
sqs.deleteQueue(new DeleteQueueRequest(myQueueUrl));
```

* AWS SDKは現時点では以下の言語をサポート
  * Java http://aws.amazon.com/jp/sdk-for-java/
  * Ruby http://aws.amazon.com/jp/sdk-for-ruby/
  * Python http://aws.amazon.com/jp/sdk-for-python/
  * .NET http://aws.amazon.com/jp/sdk-for-net/
  * PHP http://aws.amazon.com/jp/sdk-for-php/
  * JavaScript http://aws.amazon.com/jp/sdk-for-browser/
  * Node.js http://aws.amazon.com/jp/sdk-for-node-js/
  * Go(Coming Soon!) https://github.com/awslabs/aws-sdk-go

### Amazon SQSのコスト
* 無料利用枠
  * (SQSご利用全ユーザー) 毎月100万キューイングリクエストまで無料
* SQSリクエスト100万件につき0.476 USD （※東京リージョン）
  * 複数メッセージを１つのリクエストとしてバッチ送信することも可能
* データ転送
  * 送信（アウト）
    * 最初の1GB/月： 0 USD
    * 10TBまで/月： 0.140 USD GBあたり
    〜略〜
    * 次の350TBまで /月： 0.120 USD GBあたり
    * 350TBを越える場合の価格はお問い合わせください
    * **同一リージョン内のSQSとEC2インスタンスのデータ転送は無料**

### 効率良くAmazon SQSを使う
* Visibility Timeout + EC2 Spot Instance
* 一度のAPIコールで10件のメッセージを送信/受信
* Long PollでReceive Messageコールの頻度を抑える
* Visibility Timeoutとは
  * メッセージ受信者が複数の場合
  * 受信1がメッセージを取得
  * 30秒間(デフォルト設定。変更可能。最大12時間)、受信2と受信3にはメッセージを見せない(in Flight)
  * 受信1がキューからメッセージを削除せず、タイムアウトした場合はどの受信サーバーからもメッセージが受信可能に
* Amazon EC2 * Spot Instances
  * Amazon EC2 の価格をお客様が指定できるシステム
  * 入札価格がその時点のスポット価格を上回っていれば、インスタンスを実行できる
    * スポット価格は、需要と供給の関係に基づいてリアルタイムで変動
    * スポット価格は一般的に、オンデマンド価格を大幅に下回る（2015年3月時点で、平均で約8割下回っている）
  * 「入札額 >= スポット価格」なら指定したインスタンスが起動
  * 「入札額 < スポット価格」となるとインスタンスがターミネート
  * 1時間未満の使用料は課金されない
* Visibility Timeout + EC2 Spot Instances
  * Spot Instanceを使っていて、受信1がターミネートされても、Visibility Timeout後に他のインスタンスが処理すれば良い
  * コスト削減効果: 大
* メッセージ送信/受信は1度にMAX10件
  * SQSへのリクエストが少なければ少ないほどコスト効率が良い
  * 送信例: AWS CLI で send-message-batch を利用
```
$ aws sqs send-message-batch
--queue-url https://リージョン.queue.amazonaws.com/アカウントID/blackbelt2015
--entries '[{ "Id": "01", "MessageBody": "test message 01" },{ "Id": "02",
"MessageBody": "test message 02" },…]’
{
"Successful": [
{
"MD5OfMessageBody": "fa27aa462b939f0c8cf67189198f1b2d",
"Id": "01",
"MessageId": "041d1604-1c80-4440-90bf-598db00cf752"
}, ...
〜略〜
```
  * 受信例: AWS CLI で receive-message の--max-number-ofmessagesオプションを利用(デフォルト1。最大10)
```
$ aws sqs receive-message
--queue-url https://リージョン.queue.amazonaws.com/アカウントID/blackbelt2015
--max-number-of-messages 10
{
"Messages": [
{
"Body": "test message 01",
"ReceiptHandle": "AQEB 〜略〜 7g/jA=",
"MD5OfBody": "fa27aa462b939f0c8cf67189198f1b2d",
"MessageId": "041d1604-1c80-4440-90bf-598db00cf752"
},…
```

* クライアントサイドでのバッファリング
  * AWS SDK for Java の AmazonSQSAsyncClient を利用
  * 最大10リクエストのバッファリング処理を簡単に実現可能
  * 下記のパラメータを設定し微調整することが可能
    * maxBatchOpenMs: 最大待ち時間をミリ秒単位で指定
    * maxBatchSize: 1回のリクエストのメッセージの最大数を指定
* Long Polling
  * 受信者が頻繁にSQSに対してReceive Messageコールをするとリクエスト回数がかさみ、コスト効率がよくない
  * "メッセージが取得出来るまで"待つ時間を設定できる(0秒から20秒)
* Long Polling と Short Polling の使い分け
  * 基本的に Long Polling 推奨(呼び出し元のCPU負荷, リクエスト課金等)
    * 複数のキューを使う場合は、マルチスレッドでPolling
  * Receive Message呼び出し後、直ちに応答が必要な場合はShortPolling
    * 例えば複数のキューを単一スレッドでポーリングする場合、LongPollingするとその間、他のキューにアクセスできない

## 最近アップデートされた新機能のご紹介
1. SQS Message Attributes
2. AWS CloudTrail対応
3. Delete All Messages in SQS Queue
4. SQS Client Library for Java Messaging Service (JMS)

### SQS Message Attributes
* メッセージBodyとは別に属性を10個まで定義可能に
* 属性はName、Type(String/Number/Binary)、Valueで定義
  * Typeはカスタム可能(例: float, int)

### AWS CloudTrail対応
* キューの設定変更等に関するAPIコールのログをS3に保存

### Delete All Messages in SQS Queue
* PurgeQueue （「キューの消去」）アクションでキュー内のメッセージの一括削除が可能に

### SQS Client Library for Java Messaging Service (JMS)
* JMS: Javaでメッセージングサービスを利用するための標準API
* SQSをJMSプロバイダーとして利用可能に
  * ご自身でJMSクラスタサーバーの保守運用が不要に！

## Amazon SQSを使う上での注意点
### 順序はベストエフォート
* 出来る限り順序を維持しようとするが保証しない
* タイムスタンプやシーケンス番号をメッセージに

### 同じメッセージを複数回受信する可能性がある(少なくとも1回の配信)
* SQSはメッセージを複数のサーバ/データセンタに保持
* メッセージ削除時にサーバが一時故障中の場合、復旧後に受信される可能性がある
* 同じメッセージを複数回処理した場合に悪影響を出さないように、冪等性を意識したアプリケーションの設計を行う（冪等性（べきとうせい）・・・１回行っても複数回行っても同じ結果になること）

## Amazon SQSの上限
### メッセージ保持期限
* 削除されないメッセージはデフォルトで4日間保持
* 保持期間は60秒から14日の間で変更可能

### In Flight(受信されたメッセージ＆Visibility Timeout内)メッセージ
* １つのキューごとに最大120,000 In Flightメッセージ
* 超えるとOverLimitエラー

### メッセージの最大サイズは256KB
* 2013年6月に64KBから256KBに
* 画像やムービー等の大容量データには適していない
  * S3に配置しメッセージ内にそのパスを記述
* Extended Client Libraryを利用すると、2GBまでのメッセージの送受信が可能に

## 現場で使える実践的な機能
* 時間をおいてからメッセージを見せたい
  * Delay Queue と Message Timers
* 何度受信されてもキューに残り続けるメッセージをなんとかしたい
  * Dead Letter Queue
* SQS を使って簡単にスケーラブルなバッチ処理基盤を構築したい
  * Elastic Beanstalk: Worker Tier
* セキュリティ
  * AWS Identity and Access Management (IAM)連携
* モニタリング
  * CloudWatchでの監視
  
## 時間をおいてからメッセージを見せたい
### Delay Queue（遅延キュー）
* キューに送られた新しいメッセージをある一定秒の間見えなくする
* 0〜900秒で設定
* 設定すると、そのキューに送信されるメッセージ全てに適用

### Message Timers（メッセージタイマー）
* 個々のメッセージに対して、送信されてから見えるようになるまでの時間を設定
* 0〜900秒で設定
* Message TimersはDelay Queueの遅延時間の設定を上書き

## キューに残り続けるメッセージをなんとかしたい
### Dead Letter Queue（デッドレターキュー）
* メッセージを、指定回数(1〜1000で指定)受信後に、自動で別のキュー(Dead Letter Queue)に移動する機能
* デフォルトは無効0〜900秒で設定

## スケーラブルなバッチ処理基盤
### AWS Elastic Beanstalk: Worker Tier
* SQS ＋ Auto Scalingでスケーラブルなバッチ処理基盤

### Job Observerパターン
* CDP（Cloud Design Pattern）
  * http://aws.clouddesignpattern.org/index.php/CDP:Job_Observerパターン
* AWSブログ
  * http://aws.typepad.com/aws_japan/2015/01/auto-scaling-with-sqs.html

## セキュリティ
* AWS Identity and Access Management (IAM)連携
  * ポリシーの設定例
    * 特定のリソースやアクセス元のみアクセス許可/拒否
    * 特定の時間帯のみアクセス許可
```
{
  "Version":"2012-11-05",
  "Id":"cd3ad3d9-2776-4ef1-a904-4c229d1642ee",
  "Statement" : [
    {
    "Sid":"1",
    "Effect":"Allow",
    "Principal" : {
      "aws": "111122223333"
    },
    "Action":["sqs:SendMessage","sqs:ReceiveMessage"],
    "Resource": "arn:aws:sqs:us-east-1:444455556666:queue2",
    "Condition" : {
    "IpAddress" : {
    "aws:SourceIp":"10.52.176.0/24"
    },
    "DateLessThan" : {
    "aws:CurrentTime":"2009-06-30T12:00Z"
```

## モニタリング
* CloudWatchでの監視
* 利用可能メトリクス

|||
|---|---|
|NumberOfMessageSent |キューに追加されたメッセージ数
|SentMessageSize |キューに追加されたメッセージの合計サイズ
|NumberOfMessageReceived |ReceiveMessageコールによって返されたメッセージ数
|NumberOfEmptyReceives |ReceiveMessageによって返さなかったメッセージ数
|NumberOfMessagesDeleted |キューから削除されたメッセージ数
|ApproximateNumberOfMessageDelayed |Delayされすぐに読み込みができなかったメッセージ数。Delay Queueまたは<br />メッセージ送信時のDelay設定によるもの
|ApproximateNumberOfMessageVisible| キューから利用可能になったメッセージ数
|ApproximateNumberOfMessageNotVisible |クライアントから送信されたが削除されていないか、visibility winodowの<br />endまで到達していないメッセージ数

# Amazon Simple Notification Service (SNS)
Amazon SNSはマルチプロトコルに対応したフルマネージド通知サービス

## Amazon SNSのコスト
### Amazon SNSを使えば安価で簡単に通知が送れます

### 無料枠:
* モバイルプッシュ通知: 100万件
* Email/Email-JSON: 1,000件
* HTTP/HTTPS: 100,000件
* Simple Queue Service（SQS）: 無料

### リクエスト単価(64 KB のチャンク毎に 1リクエストとして課金)
* モバイルプッシュ通知: 100万件あたり0.5 USD
* Email/Email-JSON: 100,000件あたり2 USD
* HTTP/HTTPS: 100万件あたり0.6 USD
* Simple Queue Service（SQS）: 無料

### データ転送（アウト）:
  * 最初の 1 GB / 月： 0 USD /GB
  * 10TBまで / 月： 0.140 USD /GB
  〜中略〜
  * 次の350TB / 月： 0.120 USD /GB

## Amazon SNSをはじめるのは簡単です
* マネジメントコンソールでは Mobile Services の中に
1. Topicの作成
2. TopicをSubscribe
3. Topicへ向けてメッセージをPublish

### Topicの作成
TopicのARN(Amazon Resource Name)が生成される。リトライポリシー等も設定可能

### TopicのSubscribe
「Create Subscription」にてプロトコルを選択

### TopicのSubscribe
Endpoint側でConfirmすることでメッセージ送信可能に（EMailでは、確認のメールが送られてくる。その本文にあるURLをクリックすることで、Confirm完了）

### Topicへ向けてメッセージをPublish（EMailの場合）
* マネジメントコンソールからPublish
* メッセージの受信(メッセージのメールを受信）

## Amazon Simple Notification Service (SNS)
### AWSの様々なサービスと連携して通知可能
* 利用例
  * Amazon CloudWatch
    * Billing Alertの通知
  * Amazon SES
    * Bounce/Complaintのフィードバック通知
  * Amazon S3
    * ファイルがアップロードされた時の通知
  * Amazon Elastic Transcoder
    * 動画変換処理完了/失敗時の通知

## Amazon SNSと他サービスの連携
### Amazon CloudWatchのBilling Alertの通知
### Amazon SESのBounce/Complaintのフィードバック通知
### Amazon S3にファイルがアップロードされた時の通知
### Amazon Elastic Transcoderでの動画変換処理完了/失敗時の通知

## 最近アップデートされた新機能のご紹介
* HTTPS enhancements
  * Server Name Indication (SNI) サポート
  * Basic認証 および Digest認証のサポート
* Message Attributes
* Time To Live (TTL) サポート

### HTTPS enhancements
* Server Name Indication (SNI)サポート
  * SNIはSSL/TLSの拡張仕様。SSLハンドシェイク時にクライアントがアクセスしたいホスト名を伝えることで、サーバ側がグローバルIPごとではなくホスト名によって異なる証明書を使い分けることを可能に
  * http://ja.wikipedia.org/wiki/Server_Name_Indication
* Basic認証 および Digest認証のサポート
  * HTTP POST で HTTPS URLにユーザー名とパスワードを指定
  * http://www.rfc-editor.org/info/rfc2617

### Message Attributes
  * String, Number, Binaryの属性をサポート
  * Mobile Push用Reserved Message Attributes
    * Baidu
    * MPNS
    * WNS

### TTLサポート
* Time To Live
  * メッセージ単位で生存期間を設定
* 生存期間が過ぎて配信されていないメッセージは削除
  * 例えば、飛行機を降りた後に受け取る、既に終わったフラッシュセールのメッセージ

## SQSとSNSを組み合わせた構成
### Cloud Design Pattern: Fanoutパターン
* http://aws.clouddesignpattern.org/index.php/CDP:Fanoutパターン

### 画像をフォームからアップロードして登録
* 画像ファイルはS3
* 画像のコメントはRDS
* 画像のメタデータはDynamoDB

### SNS→SQSは無料です
* リクエスト単価(64 KB のチャンク毎に 1リクエストとして課金)
  * Simple Queue Service（SQS）: 無料

## まとめ
* Amazon SQS
  * 信頼性が高く、スケーラビリティに優れ、十分に管理されたメッセージキューサービス
  * 簡単にコスト効率良く、疎結合で柔軟なシステムを構築することができる
* Amazon SNS
  * 信頼性が高く、スケーラビリティに優れ、十分に管理されたプッシュメッセージングサービス
  * 簡単にコスト効率良く、マルチプロトコルで通知ができる
  * AWSの様々なサービスと連携して通知可能

## 参考
* 256KB以上のメッセージを送ったら
  * Status Code 400でエラーとなる。
```
Amazon SQS からの応答にエラーが含まれています:
com.amazonaws.AmazonServiceException: One or more
parameters are invalid. Reason: Message must be shorter than
262144 bytes. (Service: AmazonSQS; Status Code: 400; Error
Code: InvalidParameterValue; Request ID: 693c5fec-04d0-5212-
adac-10e2d431a14e) 
```

## 参考資料
* Amazon SQS Document
  * http://aws.amazon.com/jp/documentation/sqs/
* Amazon SQS FAQ
  * http://aws.amazon.com/jp/sqs/faqs/
* Amazon SNS Document
  * http://aws.amazon.com/jp/documentation/sns/
* Amazon SNS FAQ
  * http://aws.amazon.com/jp/sns/faqs/
* AWSクラウドデザインパターン
  * http://aws.clouddesignpattern.org/index.php
