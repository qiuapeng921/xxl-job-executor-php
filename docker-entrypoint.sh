#!/usr/bin/env bash

### 服务名称
xxlJobAdminHost=$1

#启动php-fpm
mkdir -p /run/php
/usr/sbin/php-fpm7.3 -D

#启动xxl-job客户端
java -jar /opt/xxl-job-executor-sample-springboot-2.2.0.jar -D xxl.job.admin.addresses=$xxlJobAdminHost/xxl-job-admin