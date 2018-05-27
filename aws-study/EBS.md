# EBS (Elastic Block Store)
AWS クラウド内で Amazon EC2 インスタンスと組み合わせて使用できる、永続的なブロックストレージボリューム

## Point
- [X] 各ボリュームタイプの特性
- [X] 暗号化
  - [X] 作成時に行う
  - [X] 既存のEBSボリュームの暗号化はできない
- [X] snapshot
  - [X] ディスクIOを止めてから撮ると、その時点のsnapshotをとることができる。
  - [X] snapshotの取得は非同期に行われるので、取得の終了を待つ必要がない。
  - [X] snapshotの実態はS3にデータ保存されている。
  - [X] 実態はネットワークストレージだが、ユーザーは意識する必要がない。
- [ ] general 
  - [ ] attached in same AZ
  - [ ] create snapshot cross AZ or region
  - [ ] Root EBS volume is deleted, by default
  - [ ] persists independently
- [ ] encrypted 
  - [ ] Public or shared snapshots of encrypted volumes are not supported
  - [ ] Existing unencrypted volumes cannot be encrypted directly. Can migrate from copy encripted snapshot
  - [ ] Supported on all Amazon EBS volume types, not instance type
- [ ] performence 
  - [ ] use raid0 , raid1 improve iops
  - [ ] EBS optimized with PIOPS EBS
- [ ] price 
  - [ ] charge with storage, I/O requests and snapshot storage
  - [ ] EBS backed EC2,very stop/start it will be charged as a separate hour
- [ ] snapshot