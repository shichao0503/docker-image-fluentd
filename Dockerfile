FROM fluent/fluentd:v0.12-debian

RUN apt-get update && apt-get install -y gcc make ruby2.3-dev \
&& fluent-gem install fluent-plugin-mongo \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false gcc make \
&& set -ex \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
