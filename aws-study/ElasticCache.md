# ElastiCache
クラウドでのメモリ内データストアまたはキャッシュのデプロイ、運用、および縮小/拡張を容易にするウェブサービス

## Point
- [X] マネージドサービス
- [X] RDBMSのクエリ結果をインメモリにキャッシュしてDBの負荷を下げることができる。
- [ ] RedisとMemchachedの二週類を選んで使うことができる。
- [X] セッションキャッシュにも利用できる。
- [X] Multi AZ - Multi AZの利点について
- [ ] フェイルオーバー時の挙動
- [ ] ElastiCache currently allows access only from the EC2 network
- [ ] Memcache not support multi-AZ
- [ ] REDIS replica read can not across regions
- [ ] Redis Replication Groups, max 5 replica
- [ ] Redis Multi-AZ with Automatic Failover, promote one replica as primary, disabled Filover, create new instance and sync with exist replica