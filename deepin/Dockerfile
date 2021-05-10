FROM openjdk:8-jre-slim

ENV XXl_ADMIN_HOST="127.0.0.1:8080"
ENV SERVICE_NAME="test"

LABEL maintainer="qiuapeng <qiuapeng@vchangyi.com>" version="1.0"

### 替换镜像源安装软件
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's|deb http://security.debian.org|#deb http://security.debian.org|g' /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone \
    && apt update

RUN apt install composer libz-dev \
    libpcre3-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    php7.3 \
    php7.3-fpm \
    php7.3-redis \
    php7.3-mysql \
    php7.3-curl \
    php7.3-gd \
    php7.3-bcmath \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    php7.3-opcache -y

ADD ../xxl-job-executor-sample-springboot-2.3.0.jar /opt/xxl-job-executor-sample-springboot.jar

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]