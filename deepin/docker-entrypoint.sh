#!/usr/bin/env bash

echo "第一个参数为：$XXl_ADMIN_HOST";
echo "第二个参数为：$SERVICE_NAME";

#启动php-fpm
mkdir -p /run/php
/usr/sbin/php-fpm7.3 -D

#启动xxl-job客户端
java -jar /opt/xxl-job-executor-sample-springboot.jar --xxl.job.admin.addresses=http://$XXl_ADMIN_HOST/xxl-job-admin --xxl.job.executor.appname=$SERVICE_NAME