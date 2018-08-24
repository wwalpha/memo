* Beanstalk Saved configurations
  * s3://elasticbeanstalk-us-west-2-123456789012/resources/templates/my-app/

* Private keyなくした
  * 新しいKey Pairを作り
  * 秘密鍵を無くしたEC2インスタンスのAMIを作って
  * AMIからEC2インスタンスを作成する際に、新しいKey Pairを適用する

* http://sso.btmu-ai.com/openam/idpssoinit?metaAlias=/idp&spEntityID=urn:amazon:webservices:dev&RelayState=https://faq-dev.btmu-ai.com/v1/saml/auth
