# Auto Scaling
AWS上にdeployされた仮想サーバー群を条件によって、スケールさせるサービス。負荷が大きい時にはサーバー台数を多く、少ない時はサーバー台数を少なくする。

## Point
- [X] auto scaling policy
  - [X] auto scalingする条件
- [ ] auto scaling launch configuration
  - [ ] auto scalingで扱うインスタンスの種類
- [ ] auto scaling group
  - [ ] auto scalingの台数
- [X] スケールアップ、スケールダウン、スケールイン
- [X] クールダウンの設定
  - [X] Auto Scaling グループにおける構成可能な設定で、以前の規模の拡大や縮小が適用される前に、Auto Scaling が追加のインスタンスを起動または終了しないようにします。
- [ ] デフォルトの挙動について
- [X] auto scalingのインスタンスはstoppedのステータスを持たない。
- [X] auto scalingの利用自体は無料であること
