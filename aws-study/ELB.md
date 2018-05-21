## ELB (Elastic Load Balancing)
* 抽象化されたロードバランサーサービス
* 抑えておきたい点
  * EC2,ELB,RDSをMulti AZ配置すると可用性が高いMulti-Datacenter patternとか
    * http://en.clouddesignpattern.org/index.php/CDP:Multi-Datacenter%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3
  * ヘルスチェックについて
  * スティッキーセッションが利用可能
    * NLB利用できない、そもそも試験にNLBでない
  * ELB自体が自動でscalingすること
  * 負荷が多くなることがある場合はPre-warming(暖機運転) 申請ができること。