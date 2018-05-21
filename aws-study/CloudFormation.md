## CloudFormation
* AWS CloudFormation は、開発や本運用に必要な、互いに関連する AWS リソースのコレクションを作成しておき、そのリソースを適切な順序でプロビジョニングするためのサービス
* 抑えておきたい点
  * インフラのリソース作成の自動化を行うツールであることに対し
  * 記述形式
    * JSON
    * YAML
  * CloudFormationの用語
    * Resources
    * Stack
    * Template
    * Parameter
    * Conditions
    * Outputs
    * CloudFormer
  * デフォルト時の挙動について
    * デフォルト時の途中でResourceの作成に失敗した場合