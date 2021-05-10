#!/usr/bin/env bash

echo "执行的文件名：$0";
echo "第一个参数为：$1";
echo "第二个参数为：$2";

### admin地址
XXl_ADMIN_HOST=$1
### 服务名称
SERVICE_NAME=$2

#启动php-fpm
mkdir -p /run/php
/usr/sbin/php-fpm7.3 -D

#启动xxl-job客户端
java -jar /opt/xxl-job-executor-sample-springboot.jar --xxl.job.admin.addresses=http://$XXl_ADMIN_HOST/xxl-job-admin --xxl.job.executor.appname=$SERVICE_NAME