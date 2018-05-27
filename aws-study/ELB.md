# ELB (Elastic Load Balancing)
抽象化されたロードバランサーサービス

## Point
- [X] EC2,ELB,RDSをMulti AZ配置すると可用性が高いMulti-Datacenter patternとか
  - [X] http://en.clouddesignpattern.org/index.php/CDP:Multi-Datacenter%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3
- [X] ヘルスチェックについて
- [X] スティッキーセッションが利用可能
  - [X] NLB利用できない、そもそも試験にNLBでない
- [X] ELB自体が自動でscalingすること
- [X] 負荷が多くなることがある場合はPre-warming(暖機運転) 申請ができること。
- [ ] Pre-Warming
- [ ] Connection Draining
- [ ] Client-Side SSL certificates
- [ ] Server Order Preference
- [ ] Cross-Zone
- [ ] SSL termination
- [ ] ELB HTTPS listener does not support Client-Side SSL certificates
- [ ] autoscaling 
  - [ ] Scheduled scaling can not be overlap
  - [ ] choose greatest impact when Multiple Policies
  - [ ] cooldown period
  - [ ] Termination Policy