# [Amazon S3(Simple Storage Service)](https://d1.awsstatic.com/webinars/jp/pdf/services/20170419_AWS-BlackBelt-S3.pdf)

## Amazon S3 概要
* Amazon Simple Storage Service (S3)はWeb時代のオブジェクトストレージ
* ユーザはデータを**安全に、どこからでも、容量制限なく**保存可能
* 最大限のスケーラビリティを利用者やデベロッパーに提供

## Amazon S3 特徴
- 容量無制限
  - 1ファイル最大5TBまで
- 高い耐久性
  - 99.999999999%
- 安価なストレージ
  - 容量単価:月額1GB / 約3円※
- スケーラブルで安定した性能
  - データ容量に依存しない性能（ユーザが、サーバ台数、媒体本数やRAID、RAIDコントローラを考える必要がない）

## Amazon S3のデータ配置
* ネットワーク越しにファイルを格納
* 複数箇所で自動複製高い耐久性を実現
* ユーザがデータを格納するAWS Regionを指定する

## Amazon S3の用途
* コンテンツ配信や保管サーバ
  - Web・画像・動画などのメディアコンテンツ
  - JavaScriptを活用した2Tier Webシステム
* ログ＆データハブストレージ
  - ログや分析データ保管用ストレージ
  - データロード元
* バックアップやディザスタリカバリ
  - データバックアップストレージ
  - 拠点間レプリケーション

## Amazon S3 用語
### バケット(Bucket)
オブジェクトの保存場所。各AWSアカウントにてデフォルト100個まで作成可能。名前はグローバルでユニークな必要あり。上限緩和申請で100以上も利用可能(*)に。

### オブジェクト(Object)
データ本体。S3に格納されるファイルでURLが付与される。バケット内オブジェクト数は無制限。1オブジェクトサイズは0から5TBまで(1つのPUTでアップロード可能なオブジェクトの最大サイズは5GB)。

### キー(Key)
オブジェクトの格納URLパス。「バケット＋キー＋バージョン」が必ず一意になる。

### メタデータ(MetaData)
オブジェクトに付随する属性の情報。システム定義メタデータ、ユーザ定義メターデータがある。

### リージョン(Region)
* バケットを配置するAWSのロケーション。目的のアプリケーションと同じリージョンであると有利。
* アクセスコントロールリスト(ACL)
* バケットやオブジェクトのアクセス管理。

### オブジェクトはバッケット内にフラットに格納される

### キーのパス指定でフォルダ階層のように表示も可能。「/」が区切り記号として、マネジメントコンソールでは、フォルダ構造を表現する

### ストレージクラス
用途に応じて、オブジェクトを格納するS3の場所の使い分け。

|ストレージクラス | 特徴 | 耐久性（設計上）|
|----|----|----|
|スタンダード |複数箇所にデータを複製。デフォルトのストレージクラス。| 99.999999999% |
| STANDARD-IA (標準低頻度アクセスストレージ) | スタンダードに比べ格納コストが安価。いつでもアクセス可能だが、データの読み出し容量に対して課金。IAはInfrequent Accessの略 | 99.999999999% 
|Glacier (アーカイブ) |最も低コストだが、データの取り出しにコストと時間を要する。ライフサイクルマネジメントにて指定する |99.999999999%
|低冗長化ストレージ(RRS) |RRS はReduced Redundancy Storageの略。Glacierから取り出したデータの置き場所として利用 | 99.99%

### S3のData Consistency モデル
* Amazon S3はデータを複数の場所に複製することで高い可用性を実現するため、データの更新・削除にはEventual Consistency Readモデ
ル（結果整合性）が採用されている。

|オペレーション |Consistencyモデル |挙動|
|----|----|----|
|新規登録 (New PUTs) |Consistency Read(*) |登録後、即時データが参照できる
|更新 (Overwrite PUTs)| Eventual Consistency Read(結果整合性) |更新直後は、以前のデータが参照される可能性がある
|削除 (DELETE) |Eventual Consistency Read（結果整合性）| 削除直後は、削除前のデータが参照される可能性がある

* 同じオブジェクトへの複数同時書き込み制御のためのロック処理は行われず、タイムスタンプが更新される。
* （ロック処理があるような仕組みと比べて）読み込みの待ち時間が小さくなるのがメリット

## Amazon S3 の操作
|オペレーション |処理 |特徴
|----|----|----|
|GET |S3から任意のファイルをダウンロード| * RANGE GETに対応<br /> * Glacierにアーカイブされ、RestoreされていないオブジェクトへのGETリクエストはエラー
|PUT |S3に対してファイルをアップロード(新規・更新)|* シングルPUTオペレーションでは最大5GBまで、<br />Multipart Uploadを利用すると5TBまで格納可能。
|LIST |S3バケット内のオブジェクト一覧を取得|* Prefixによるパス指定での取得一覧のフィルタリングが可能<br />* 1回のリクエストでは1,000オブジェクトまで情報を取得可能。<br />それ以上の場合は再帰的にリクエストを実施する必要がある
|COPY |S3内でオブジェクトの複製を作成|* シングルCOPYオペレーションでは最大5GBまで、Multipart Uploadを利用すると5TBまでのファイルの複製が可能
|DELETE |S3から任意のファイルを削除 |* シングルDELETEオペレーションで最大1,000個のオブジェクトを削除可能<br />* MFA(Multi Factor Authentication)と連携した削除制御が可能
|HEAD |オブジェクトのメタデータを取得|* オブジェクトそのものをGETオペレーションで取得しなくても、メタデータだけを取得可能
|RESTORE |アーカイブされたオブジェクトを一時的にS3に取り出し|* Glacierからのデータの取り出し<br />* 低冗長化ストレージに指定期間オブジェクトがコピーされ、その指定期間中、ダウンロードが可能になる


|操作 ||
|----|----|
|アプリケーション連携|AWS SDK |
|コマンドラインやシェル|AWS CLI
|手動、人間の操作|Management Console 3rdパーティツール

## アクセス管理
### 1. きめ細やかなバケットもしくはオブジェクトへのアクセス権の設定
デフォルトでは、S3のバケットやオブジェクトなどは全てプライベートアクセス権限
(Owner:作成したAWSアカウント)のみに設定

IAMユーザ、クロスアカウントユーザ、匿名アクセスなどバケット/オブジェクト単位で
指定可能

- ユーザポリシー
  - IAM Userに対して、S3やバケットへのアクセス権限を設定
  - 複数バケットやS3以外のものも含めて一元的にユーザ権限を指定する場合など
- バケットポリシー
  - S3バケット毎に、アクセス権限を指定
  - クロスアカウントでのS3バケットアクセス権を付与する場合など
- ACL
  - 各バケットおよびオブジェクトのアクセス権限を指定
  - バケット単位やオブジェクト単位で簡易的に権限を付与する場合など
- ユーザポリシーを利用して、IAMユーザに対して任意のバケットへのアクセス権限を付与
- Condition要素を利用することで、接続元IPアドレス制限なども指定することが可能
```js
{
  "Statement":[
    {
      "Effect":"Allow",
      "Action":[
        "s3:ListAllMyBuckets"
      ],
      "Resource":"arn:aws:s3:::*"
    },
    {
      "Effect":"Allow",
      "Action":[
        "s3:ListBucket","s3:GetBucketLocation"
      ],
      "Resource":"arn:aws:s3:::examplebucket"
    },
    {
      "Effect":"Allow",
      "Action":[
        "s3:PutObject","s3:GetObject","s3:DeleteObject"
      ],
      "Resource":"arn:aws:s3:::examplebucket/*"
    }
  ]
}
```
* バケットポリシーを利用して、全てのユーザに対して、任意のバケットへのGETリクエストを許可
```js
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::examplebucket/*"]
    }
  ]
}
```
* バケットポリシーを利用して、任意のIPアドレスレンジからバケットへののアクセスを許可
* Conditionを利用してIAM User、クロスアカウント、IPアドレス制限、HTTP Referrer制限、CloudFront, MFA制限なども指定可能
```js
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::examplebucket/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "54.240.143.0/24"}
      }
    }
  ]
}
```

### 2. ACLはバケット単位のACLとオブジェクト単位のACLが存在
- バケットACLはバケット内のオブジェクトにも影響を与えるが、オブジェクトが個別にACLを設定している場合、オブジェクトACLが優先させる
- ACLよりも、ユーザポリシーやバケットポリシーが優先される
- ACLはバケットやオブジェクトに対して100個まで指定可能
  - Grantee：Everyone, Authenticated Users, Log Delivery, Me
  - Permission: READ, WRITE, READ_ACP, WRITE_ACP, FULL_CONTROLL
- 例えば、違うアカウントが所有するバケット上のオブジェクトのアクセス許可を管理する場合に、ACLが有用

### 3. Pre-signed Object URL (署名付きURL)
Pre-signed URLを利用することで、セキュアにS3とのデータのやり取りが可能

- AWS SDKを利用して生成される署名されたURLを利用し、S3上のプライベートなオブジェクトに対して一定時間アクセスを許可
- GETとPUTオペレーションで利用可能
  - 任意のユーザへの一時的なオブジェクト共有
  - 任意のユーザからの一時的なS3へのオブジェクトアップロード権限の付与

### 4. Webサイトホスティング機能
静的なWebサイトをS3のみでホスティング可能

- バケット単位で指定
  - Management Consoleで設定可能
  - パブリックアクセスを許可するため別途バケットポリシーで全ユーザにGET権限を付与
- 独自ドメインの指定
  - ドメイン名をバケット名として指定(www.example.com)
    - 通常は http://バケット名.s3-website-ap-northeast-1.amazon.com
  - Route53のAlias設定でドメイン名とS3のバケット名を紐付けたレコードを登録
- リダイレクト機能
  - 任意のドメインにリダイレクト設定が可能
  - x-amz-website-redirect-location(メタデータの一つ)にセットされる
- CORS(Cross-origin Resource Sharing)の設定
  - AJAXなどを利用して、異なるドメインからのS3アクセス時に利用
  - Management Console の場合Bucket PropertiesのPermissionより設定
- CloudFrontとの連携
  - WebサーバとしてS3を利用する場合は、CloudFront経由で配信することを推奨
  - バケットポリシーを利用してCloudFrontからのHTTP/HTTPSリクエストのみを許可することも可能
    - バケットポリシーのPrincipalにCloudFrontのCanonicalUserを指定 (CloudFrontの「Origin Access Identity」のコンフィグレーション)

### 5. VPC Endpoint
VPC内のPrivate Subnet上で稼働するサービスから、NAT GatewayやNATインスタンスを経由せずに直接S3とセキュアに通信させることが可能

- 通信可能なのは同一リージョンのS3のみ
- VPC管理画面のEndpointで作成し、S3と通信したいSubnetのルートテーブルに追加
- Endpoint作成時にアクセスポリシーを定義し、通信可能なBucketや通信元のVPCの指定が可能 (バケットポリシーやIAMポリシーを利用したSource IPやVPC CIDRによる制限は利用不可)
- 別のVPCやSubnetを跨いだ直接のEndpointの利用は不可

### 6. S3 support for IPv6
- 追加の費用はなし
- アクセス先のエンドポイントを以下のように変更する
  - 仮装ホストスタイルの場合
  - http://bucketname.s3.dualstack.aws-region.amazonaws.com
  - パススタイルアドレスの場合い
  - http://s3.dualstack.aws-region.amazonaws.com/bucketname
- AWS SDK/CLIでの利用
  - http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/dual-stack-endpoints.html
- 静的ウェブホスティングでは利用できない
- IPv6ベースでのアクセス制御が可能
- IPアドレスによるアクセス権限の例

### 7. 暗号化によるデータ保護
保管時(Amazon S3 データセンター内のディスクに格納されているとき)のデータを暗号化して保護するもの

- サーバサイド暗号化
  - AWSのサーバリソースを利用して格納データの暗号化処理を実施
  - 暗号化種別
    - SSE-S3 : AWSが管理する鍵を利用して暗号化
    - SSE-KMS：Key Management Service(KMS)の鍵を利用して暗号化
    - SSE-C：ユーザが提供した鍵を利用して暗号化(AWSで鍵は管理しない)
- クライアントサイド暗号化
  - 暗号化プロセスはユーザ管理
  - クライアント側で暗号化したデータをS3にアップロード
  - 暗号化種別
    - AWS KMSで管理されたカスタマーキーを利用して暗号化
    - クライアントが管理するマスターキーを利用して暗号化

### 8. クロスリージョンレプリケーション
異なるリージョン間のS3バケットオブジェクトのレプリケーションを実施

* バケットに対するオブジェクトの作成、更新、削除をトリガーに非同期でレプリケーションが実行
  - 対象元バケットは*バージョニング*の機能を有効にする必要がある
  - バケットはそれぞれ異なるリージョンでなければならない
  - 双方向レプリケーションも可能
  - レプリケーション時は、リージョン間データ転送費用が発生

### 9. バージョン管理機能
ユーザやアプリケーションの誤操作による削除対策に有効

* バケットに対して設定
* バージョン保管されている任意のオブジェクトを参照可能
* バージョニングにより保管されているオブジェクト分も課金
* ライフサイクル管理(後述)と連携し、保存期間(有効期限)も指定可能
* バケットを削除したい場合は、古いバージョンのオブジェクトも削除する

### 10. ライフサイクル管理
バケット内のオブジェクトに対して、ストレージクラスの変更や、削除処理に関する自動化

* バケット全体もしくはPrefixに対して、オブジェクトの更新日をベースに日単位での指定が可能
* 最大1,000までLifecycleのルールを設定可能
* 毎日0:00UTCに処理がキューイングされ順次実行
* Lifecycleを利用してIAに移動できるのは128KB以上のオブジェクトのみでそれ以外はIAに移動されない
* STANARD-IA・アーカイブおよび削除の日程をそれぞれ指定した組み合わせも可能(後述)
* マルチアップロード処理で完了せず残った分割ファイルの削除にも対応
* MFA delete が有効なバケットにはライフサイクル設定は不可
* ライフサイクル管理の設定パターン

||選択可能オプション |処理
|----|----|----|
|通常（複数選択可能）|STANDARD-IAストレージクラスへの移行 |128KB以上のオブジェクトを指定日（30日以上)にSTANDARD-IAに移動
||Glacier ストレージクラスへのアーカイブ |オブジェクトを指定日にGlacierへ移動 (STANDARD-IAを併用する場合は、STANDARD-IAにて30日以上経過している指定日を設定する必要あり)
||完全に削除(expire)| 指定日にオブジェクトを削除(STANDARD-IAやGlacierと併用する場合は、それぞれの指定日より後に設定する必要あり)
|バージョニング有効（複数選択可能）|STANDARD-IAストレージクラスへの移行|既存のオブジェクトを指定日にSTANDARD-IAへ移動<br/>※要件は通常と同様
||Glacier ストレージクラスへのアーカイブ|既存のオブジェクトを指定日にGlacierへ移動<br/>※要件は通常と同様
||失効 |既存のオブジェクトを指定日に削除されバージョニング
|マルチパート| 不完全なマルチパートアップロードのアクション実行| マルチパートアップロードで完了せず残ったファイルを指定日に削除

### 11. アーカイブ及び復元
* アーカイブ
  - オブジェクトのデータはGlacierに移動(アーカイブ後、マスターはGlacier)
  - S3上のデータを削除することで、Glacier側のデータも削除される
  - S3には8KBのオブジェクト名とメタデータのみが保管
  - Glacierには32KBのインデックスおよび関連メタデータが追加で保管
  - アーカイブしたオブジェクトを90日以内に削除しても、90日間アーカイブされたのと同じ課金対象
* オブジェクトの復元(restore)
  - オブジェクト毎に復元
  - データは一時的にS3の低冗長化ストレージに指定日数間複製される
  - 復元後の、S3上での保持期間の変更も可能
  - 復元にかかる時間について、3種類から選択可能に
  - 復元期間中は、S3の低冗長化ストレージとGlacier双方で課金
* 復元リクエスト時に指定できる３つの選択肢
  - Expedited: 少ない数のファイルについて、緊急のアクセスを要する場合の取得
  - Standard: 3-5時間の間にファイルを取得する標準的な取得
  - Bulk: 5-12時間の間にファイルを取得する最も低価格で、大量のデータを取得

||迅速(Expedited)| 標準(Standard)| 大容量(Bulk)
|----|----|----|----|
|データアクセス時間 |1～5 分| 3～5 時間| 5～12 時間
|データ復元容量 |$0.033 / GB |$0.011 / GB| $0.00275 / GB
|復元リクエスト|オンデマンド: $0.011 リクエストごと<br>プロビジョンド： $110プロビジョンドキャパシティユニットごと |$0.0571 : 1,000 リクエストあたり |$0.0275 : 1,000 リクエストあたり

## S3 分析
「STANDARD-IAとGlacierどちらににいつ移動すればいいのだろうか？」この疑問に応える、データのアクセスパターンの簡易可視化

### 開始方法
* 目的のバケットに対して、分析フィルターを定義する
* 結果がが出るまで、フィルター作成してから24〜48時間ほど待つ
* バケットの分析を行う
* バケット内のプレフィックスやタグで分類されたデータのみを分析（フィルターで指定）
* CSVでバケットに出力することも可能（出力先にバケットポリシーを仕込む)
* アクセス頻度の低いデータは、どのくらい経過したデータなのか、を把握
* ライフサイクルポリシーの設定値の元ネタとなる
* この例の場合は、
  - 90日までのオブジェクトは、そこそこアクセスがある。
  - 90日以降のオブジェクトのニーズが急に減っている。
  - 90日以降でも、全くアクセスがないわけではない。
  - 他のコンプライアンス要件などを加味したとして、、、
  - 90日経過したデータをSTANDARD-IAへ移動
  - 365日経過したデータをGlacierへ移動(例)
  - 5年経過したデータは削除(例)

## S3 インベントリ
S3に入っているオブジェクトのリストを、一気にcsvファイルで取得する

* オブジェクトのリストを取得するにあたって、List Bucketの処理に時間や手間がかかる場合に有益
* スケジュール化（日単位・週1回）してレポートを取得
* 初回の結果が出るまで、48時間待つ
* ある時点のsnapshotとしてのPUT/DELETE（結果整合性）結果のインベントリリストとなる

## S3 イベント通知
バケットにてイベントが発生した際に、Amazon SNS, SQS, Lambdaに対して通知することでシームレスなシステム連携が可能データ加工

|イベントタイプ| 概要|
|----|----|
|s3:ObjectCreated:* |S3バケットにオブジェクト作成された時（PUT/POST/COPYのAPIがコールされた時）
|s3:ObjectCreated:Put |
|s3:ObjectCreated:Post|
|s3:ObjectCreated:Copy|
|s3:ObjectCreated:CompleteMultipartUpload|
|s3:ObjectRemoved:* |S3バケットから、オブジェクトが削除された時<br>Delete = バージョニンングされていないオブジェクトの削除、または
バージョニングされているバケットのオブジェクトの完全な削除<br>DeleteMarkerCreated = バージョニンングされているオブジェクトの削除マーカ作成
|s3:ObjectRemoved:Delete|
|s3:ObjectRemoved:DeleteMarkerCreated|
|s3:ReducedRedundancyLostObject |低冗長化ストレージにてデータロストが発生した時

* 通知、または連携システム
  - Amazon SNS: メール送信, HTTP POST, モバイルPushなどのTopics実行
  - Amazon SQS: キューメッセージの登録
  - Amazon Lambda: 指定Lambda Functionの実行
* S3からの実行権限の付与
  - SNSおよびSQSはそれぞれのPolicyに対してS3からの実行権限を付与
  - Lambdaに関しては、Lambdaが利用するIAM RoleにS3の権限を付与
* イベントでの通知内容

||通知項目|
|----|----|
|共通情報| リージョン, タイムスタンプ, Event Type
|リクエスト情報| Request Actor Principal ID, Request Source IP, Request ID, Host ID
|バケット情報| Notification Configuration Destination ID, バケット名, バケットARN, バケットOwner Principal ID
|オブジェクト情報 |オブジェクトキー, オブジェクトサイズ, オブジェクトETag, オブジェクトバージョンID

## Amazon CloudWatchによるメトリクス管理
* バケットに対するストレージメトリクス -> 日単位
* オブジェクトに対するリクエストメトリクス -> 分単位

Amazon CloudWatchによるメトリクス管理(続き)
53
メトリクス 詳細
BucketSizeBytes 標準ストレージクラス、STANDARD IAストレージクラス、または低冗長化ストレージ (RRS) クラスのバケッ
トに保存されたバイト単位のデータ量
NumberOfObjects GLACIER ストレージクラスを除く、すべてのストレージクラスのバケットに保存されたオブジェクトの総数
ストレージメトリクス
- バケット単位および、Storage Type(Glacierを除く）ごとにメトリクスを把握する
- １日間隔でのレポート、状況把握（追加料金なし）
メトリクス 単位
AllRequests Count
PutRequests Count
GetRequests Count
ListRequests Count
DeleteRequests Count
HeadRequests Count
PostRequests Count
リクエストメトリクス
- タグやプレフィックスの指定にて細かい粒度での把握も可能
- １分間隔でのメトリクスで、通常のCloudWatchの料金
メトリクス 単位
BytesDownloaded MB
BytesUploaded MB
4xxErrors Count
5xxErrors Count
FirstByteLatency ms
TotalRequestLatency ms
2016.11月
AWS CloudTrailによるAPI管理
* いつ、どこから、誰がS3の操作を行ったか、コンプライアンスの目的
で把握可能(S3 イベント通知との使い分けを意識）
* 監査対象とは別のS3バケットを用意することを推奨
* 100,000イベントごとに、$0.1の料金
* ログに記録されるS3オペレーションは下記を参照
http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/cloud
trail-logging.html
54 http://docs.aws.amazon.com/ja_jp/awscloudtrail/latest/userguide/logging-management-and-data-events-with-cloudtrail.html
CloudTrailでのイベント 操作
データイベント GetObject, DeleteObject, PutObjectなどのS3のオブジェク
トに対するAPI操作
管理イベント S3のバケット操作はもちろん、その他のすべてのAPI操作
2016.11月
CloudTrailを有効にすることでS3への操作ログ(API Call)を収集することが可能
その他のモニタリングや管理に有効な機能
* Logging
- バケット単位でバケットに対するアクセスログの出力設定が可能
- 出力先としてS3バケットを指定
- ログフォーマットは下記を参照
http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/LogFormat.html
* Tag管理
- バケットに対してタグの指定が可能
- タグ指定によりリソースグループにて関連するAWSサービスとの紐付
けが可能
- オブジェクトに対してのタグもできるようになり、ここまで紹介したラ
イフサイクル、分析、モニタリング機能で活用可能
55
2016.11月
パフォーマンス最適化
56
パフォーマンスの最適化
* GETリクエストについて、RANGE GETを活用することで、マ
ルチスレッド環境では高速にダウンロードが可能
- マルチパードアップロード時と同じチャンクサイズを利用する
* マルチパートアップロードの活用によるアップロード(PUT)オ
ペレーションの高速化
- チャンクサイズと並列コネクション数のバランスが重要
* 帯域が太い場合は20MB-50MBチャンクサイズから調整
* モバイルや帯域が細い場合は10MB程度から調整
57
大きなサイズのファイルを快適に、ダウンロード、アップロード
パフォーマンス最適化(続き)
* S3にアップロードする際に、ファイルを複数の
チャンクに分割して並列アップロードを実施
- ファイルが100MBを超える場合、利用することを推奨
- 各チャンクは5GB以下に設定(5MB-5GB)
- 全てのチャンクがアップロードされるとS3側で結合
- Multipart Uploadを利用することで単一オブジェクト
で5TBまで格納可能
* 各SDKにてMultipart Uploadの機能は実装済み
AWS CLIの場合は、ファイルサイズを元に自動
的に判別
* PUT処理を並列化することでのスループット向上
を期待ー＞広帯域ネットワークが重要
58 http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/mpuoverview.html
http://docs.aws.amazon.com/cli/latest/topic/s3-config.html
目安100MB以上のファイルのアップロードを快
適にしたい場合のマルチパートアップロード機能
パフォーマンスの最適化(続き)
59
定常的にS3バケットへのPUT/LIST/DELETEリクエストが100RPSを超える、もしく
はGETリクエストが300RPSを超える場合、キー名先頭部分の文字列をランダムにする
ことを推奨
examplebucket/2013-26-05-15-00-00/cust1234234/photo1.jpg
examplebucket/2013-26-05-15-00-00/cust3857422/photo2.jpg
・・・
examplebucket/2013-26-05-15-00-01/cust1248473/photo4.jpg
examplebucket/2013-26-05-15-00-01/cust1248473/photo5.jpg
・・・
examplebucket/232a-2013-26-05-15-00-00/cust1234234/photo1.jpg
examplebucket/7b54-2013-26-05-15-00-00/cust3857422/photo2.jpg
・・・
examplebucket/9810-2013-26-05-15-00-01/cust1248473/photo4.jpg
examplebucket/c34a-2013-26-05-15-00-01/cust1248473/photo5.jpg
・・・
例 (ハッシュ文字列の追加)
* 大量のGETリクエストが発生する
ワークロードの場合は、Amazon
CloudFrontを併用することを推奨
Amazon CloudFront Amazon S3
参考：http://aws.typepad.com/aws_japan/2012/03/amazon-s3-performance-tips-tricks-.html
1 秒あたり 100 個以上のリクエストを定常的に処理している場合
http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/request-rate-perf-considerations.html
Amazon S3 Transfer Acceleration
60
* 全世界73箇所(*)にあるAWSのエッジネット
ワークから、最適化されたAWSのネットワー
クを経由して、高速にAmazon S3とのデータ
転送を実現
- 利用者は自動的に最短のエッジネットワークに誘導
* S3 Bucketに対してAccelerationを有効化
- S3へのアクセスエンドポイントを変更するだけで利用
可能
- Acceleration有効後、転送速度が高速化されるまでに最
大30分かかる場合がある
- バケット名はピリオド”.”が含まれない名前にする必要が
ある
- IPv6 (dualstack)エンドポイントも指定可能
* 利用している端末からの無料スピード測
定ツールも提供
2016.4月より
マネージメントコンソール
からも起動可能
http://s3-accelerate-speedtest.s3-accelerate.amazonaws.com/en/accelerate-speed-comparsion.html
AWSのマネージドバックボーンネットワークを活用した
高速ファイル転送サービス
ユースケース
61
Amazon S3の用途（再掲）
* コンテンツ配信や保管サーバ
- Web・画像・動画などのメディアコンテンツ
- JavaScriptを活用した2Tier Webシステム
* ログ＆データハブストレージ
- ログや分析データ保管用ストレージ
- データロード元
* バックアップやディザスタリカバリ
- データバックアップストレージ
- 拠点間レプリケーション
62
コンテンツ配信サーバ
63
写真などのコンテンツを含む動的Webサイト
CloudFront S3
クライアント
フルマネージド
コンテンツ配信サーバ
動的ページアクセス
静的コンテン
ツ取得
Webサーバ CMS
静的ファイルやコン
テンツをS3に配置
フルマネージドコンテンツ配信サーバとして配信負荷をオフロード
写真や動画などのファイルサイズの大きなものをS3に配置する
静的コンテンツ中心のサイト
クライアント CloudFront S3
CMS
静的ファイルに
出力しS3に転送
フルマネージド
Webサーバ
フルマネージドWebサーバとして活用
Java Scriptで動的部分がクライアントで処理さ
れるシステム
JavaScriptSDK
JS SDKを活用した2Tier
アーキテクチャも実現可能
転送量が多くなりがちなデータをS3にオフロードし、CloudFrontでキャッシュさせる
ログ＆データハブストレージ
64
オンプレミス
システム
外部データソース
- 市況情報
- ソーシャルメ
ディア
収集
収集
Direct Connect
Kinesis
データレイク
S3
元データ 変形済データ
中間データ
前処理
分析
分析
可視化
EMR
EMR
Athena
Redshift
QuickSight
BI tool
on EC2
- トランザクショ
ナルデータ
- ログデータ
S3の汎用性を活用して、データ分析に必要なツールをじっくり試せる
場所を作る
結果
Glacier
データレイクを中心としたデータ処理基盤の例
バックアップ/DRストレージ
65
S3 S3
NAS
Backup
SW
クラウドバックアップ
(バックアップ)
グローバルDR
(レプリケーション)
Production
環境 DR環境 DR環境
バックアップ
バックアップストレージ バックアップストレージ
災害時
リストア
災害時
リストア
災害時
リストア
東京リージョン シンガポールリージョン
オンプレ
クラウドバックアップ用途
用途に合わせてバックアップ/DR環境を安価に構築可能
VPCでのデータ保護先 クロスリージョンでデー
タの複製を保持(DR等)
料金
66
Amazon S3の料金
スタンダード STANDARD-IA(*) Glacier
最初の50TB/月 $0.025 / GB $0.019 / GB $0.005 / GB
次の450TB/月 $0.024 / GB $0.019 / GB $0.005 / GB
500TB月以上 $0.023 / GB $0.019 / GB $0.005 / GB
67
ストレージ料金
2017年4月時点の東京リージョン料金表
http://aws.amazon.com/jp/s3/pricing/
(*) STANDARD-IAの請求対象となる最小オブジェクトサイズは 128 KB です。128 KB より小さいサイズのオブジェクトは、128 KBとして課金
されます。
リクエスト料金
スタンダード STANDARD-IA Glacier
PUT、COPY、POST、または
LIST リクエスト $0.0047 : 1,000 リクエストあたり $0.01 : 1,000 リクエストあたり -
GET および他のすべてのリクエ
スト $0.0037 : 10,000 リクエストあたり $0.01 : 10,000 リクエストあたり -
ライフサイクル移行リクエスト - $0.01 : 1,000 リクエストあたり $0.0571 : 1,000 リクエストあたり
取り出し（容量） $0.01 GB あたり Glacier取り出し料金(slide 45)
Amazon S3の料金
管理 料金
S3 Inventory リストされるオブジェクト 100 万個ご
とに $0.0028
S3 Analytics
Storage Class Analysis
モニターされるオブジェクト 100 万個
ごとに月あたり $ 0.10
S3 Object Tagging 10,000 タグごとに月あたりUS$0.01
CloudWatch
リクエストメトリクス CloudWatch 料金
CloudTrail
データイベント 100,000 件のイベントあたり $0.1
68
ストレージマネジメント料金
2017年4月時点の東京リージョン料金表
http://aws.amazon.com/jp/s3/pricing/
データ転送料金
転送方向 価格
IN 全てのデータ転送「IN」 $0.000/GB
OUT
(AWS
Network)
同じリージョンのAmazon EC2 $0.000/GB
別のAWSリージョン $0.090/GB
Amazon CloudFront $0.000/GB
OUT
(Internet)
最初の1GB/月 $0.000/GB
10TBまで/月 $0.140/GB
次の40TB/月 $0.135/GB
次の100TB/月 $0.130/GB
次の350TB/月 $0.120/GB
350TB/月以上 お問い合わせ
Amazon S3の料金
69
S3 Transfer Acceleration料金
2017年4月時点の東京リージョン料金表
http://aws.amazon.com/jp/s3/pricing/
S3 無料枠(１年)
* 標準ストレージ 5GB
* 20,000 GETリクエスト / 2,000 PUTリクエスト
* 15GBデータ送信
転送方向 価格
S3へのデータIN 米国、欧州、日本のエッジロケーションによる高速化 $0.04/GB
その他の国のエッジロケーションによる高速化 $0.08/GB
S3からのデータOUT
(Internet)
エッジロケーションによる高速化 $0.04/GB
S3と別のAWSリージョン間 エッジロケーションによる高速化 $0.04/GB
S3 Transfer Accelerationの費用は、S3のデータ転送コストとは別に加算されることに注意
S3 Transfer Accelerationを利用してデータをやり取りする場合、通常のS3との転送よりも高速であるかを確認します。
通常の転送に比べTransfer Accelerationが高速でないと判断した場合は、Transfer Accelerationの料金は請求されず、
Transfer Accelerationシステムをバイパスする可能性があります。
まとめ
70
Amazon Simple Storage Service (S3)
71
* 特徴 (http://aws.amazon.com/jp/s3/)
- 高い耐久性 99.999999999%
- 格納容量無制限、利用した分のみの課金
- 様々なAWSサービスと連携するセンター
ストレージ
* 価格体系 (http://aws.amazon.com/jp/s3/pricing/)
- データ格納容量
- データ転送量(OUT)
- APIリクエスト数
マネージドオンラインストレージサービス
Amazon S3
まとめ
* Amazon S3を活用することで
- 想定が難しいストレージサイジングからの解放
- 堅牢性が高くセキュアにデータを保管
- コンテンツ配信などWeb負荷のオフロード
- お手元の「データ」の活用を促進することができる
72
参考資料
* Amazon S3
- http://aws.amazon.com/jp/s3/
* Amazon S3 開発者ガイド
- http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/Welcome.html
* Amazon S3 FAQ
- http://aws.amazon.com/jp/s3/faqs/
* Amazon S3 Pricing
- http://aws.amazon.com/jp/s3/pricing/
* Amazon Web Services ブログ
- https://aws.amazon.com/jp/blogs/news/
73
オンラインセミナー資料の配置場所
* AWS クラウドサービス活用資料集
- http://aws.amazon.com/jp/aws-jp-introduction/
* AWS Solutions Architect ブログ
- 最新の情報、セミナー中のQ&A等が掲載されています
- http://aws.typepad.com/sajp/
74
AWSの導入、お問い合わせのご相談
AWSクラウド導入に関するご質問、お見積り、資料請求を
ご希望のお客様は以下のリンクよりお気軽にご相談ください
https://aws.amazon.com/jp/contact-us/aws-sales/
※「AWS 問い合わせ」で検索してください
75
76
付録：前回のBlackBeltオンラインセミナーS3
のスライドで、今回取り上げなかったスライド
77
AWS Direct Connect経由でのS3アクセス
* Direct Connectを利用してAWSに接続する場合、多くはPrivate ASを
利用しVPCへの接続となるため、オンプレミス環境からS3への通信は、
VPC内のEC2で構築したProxyサーバを経由するパターンが多い
Proxy on EC2
EC2の運用負荷と経由することでのオーバヘッドによるDirect
Connectの回線スピードの有効活用に課題
オンプレ環境 Direct Connect
ルータ
VGW
IGW
S3 Amazon S3はAWSの
Publicセグメントに存在
するため
78
AWS Direct Connect経由でのS3アクセス
* AWSからパブリックIPの割り当てを受け、オンプレミスルータ側の
IPアドレスでNATさせることで、VPCを経由せずオンプレミス環境
からDirect Connect回線を利用して直接S3と通信が可能
(詳細は AWS SA Blog参照: http://aws.typepad.com/sajp/2014/12/aws-direct-connect-public.html)
Direct Connectの回線スピードをフル活用
VPC内のEC2インスタンス含むAWSリソースへのアクセスも可能
オンプレ環境 Direct Connect
ルータ
VGW
IGW
S3
EC2
NAT
79