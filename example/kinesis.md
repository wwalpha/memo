# EC2 + Kinesis Agent + Kinesis Firehose + ElasticSearch

## Kinesis FireHose
|Configs||
|---|---|
Source| **Direct PUT or other sources**
Source record transformation| **Disabled**
Backup mode| **Failed records only**
S3 bucket| **transcoder-test-1224**
Prefix| **no prefix specified******
Buffer conditions| **1 MB or 6**0 seconds**
Compression| **Disabled**
Encryption| **Disabled**
Domain|**es-test-0217**
Index|**es-2017**
Index rotation|**No rotation**
Type|**log**
Retry duration|**300 seconds**
Buffer conditions|**1 MB or 60 seconds**

<br />

## EC2
OS: Amazon Linux2
Role: Administrator

### Apache
```sh
yum install -y httpd
systemctl enable httpd
systemctl start httpd
```

### Kinesis Agent
```sh
yum install –y https://s3.amazonaws.com/streaming-data-agent/aws-kinesis-agent-latest.amzn1.noarch.rpm
```

設定ファイル編集：`/etc/aws-kinesis/agent.json`
```
{
  "cloudwatch.emitMetrics": true,
  "kinesis.endpoint": "https://kinesis.ap-northeast-1.amazonaws.com",
  "firehose.endpoint": "https://firehose.ap-northeast-1.amazonaws.com",
  "flows": [
    {
      "filePattern": "/var/log/httpd/access_log",
      "deliveryStream": "firehose-es"
    }
  ]
}
```

Agentのログファイルでしっかり動いていることを確認
```
tail -f /var/log/aws-kinesis-agent/aws-kinesis-agent.log
```

