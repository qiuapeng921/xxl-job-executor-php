FROM openjdk:8-jdk-alpine AS java

FROM php:7.3-fpm-alpine

LABEL maintainer="qiuapeng <qiuapeng@vchangyi.com>"

COPY --from=java /usr/lib/jvm/java-1.8-openjdk /usr/lib/jvm/java-1.8-openjdk

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV LANG=c.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV JAVA_VERSION=8u212
ENV JAVA_ALPINE_VERSION=8.212.04-r0

ENV XXl_ADMIN_HOST="127.0.0.1:8080"
ENV SERVICE_NAME="test"

### 替换镜像源安装软件
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN set -ex \
    && apk update \
    && apk add --no-cache libstdc++ wget openssl \
    libmcrypt-dev libzip-dev libpng-dev libc-dev zlib-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    # 安装php常用扩展
    && docker-php-ext-install gd bcmath mysqli pdo pdo_mysql sockets zip \

    # 安装 Composer
    && wget https://mirrors.cloud.tencent.com/composer/composer.phar \
    && mv composer.phar  /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

ADD ./xxl-job-executor-sample-springboot-2.1.0.jar /opt/xxl-job-executor-sample-springboot.jar

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]