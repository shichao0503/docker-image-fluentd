FROM fluent/fluentd:v0.12-debian

RUN apt-get update && apt-get install gcc make ruby2.3-dev \
&& fluent-gem install fluent-plugin-mongo \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false gcc make 
