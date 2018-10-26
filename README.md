# fluentd

## 概述

日志收集工具

## 配置文件

```
<system>
  log_level error
</system>

<source>
  @type tcp
  tag system.kong # required
  format json # required
  port 20001
</source>

<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<source>
  @type mysql_slow_query
  path /mysql/slow.log
  tag mysqld.slow_query
  <parse>
    @type none
  </parse>
</source>

<filter *.**>
  @type parser
  format json
  key_name log
  reserve_data true
</filter>

<match fluent.**>
  @type stdout
</match>

<match mysqld.**>
    @type copy
    <store>
    @type elasticsearch
    host elasticsearch
    port 9200
    index_name log-mysql
    type_name ${tag}

    flush_interval 5s
    </store>
    <store>
    @type stdout
    </store>
</match>

<match system.**>
    @type copy
    <store>
    @type elasticsearch
    host elasticsearch
    port 9200
    index_name log-system
    type_name ${tag}

    flush_interval 5s
    </store>
    <store>
    @type stdout
    </store>
</match>

<match application.**>
    @type copy
    <store>
    @type elasticsearch
    host elasticsearch
    port 9200
    index_name log-application
    type_name ${tag}

    flush_interval 5s
    </store>
    <store>
    @type stdout
    </store>
</match>
```

* `tcp`模式: 用于收集`kong`的日志
* `mysql_slow_query`: 收集`MySQL`慢日志
* 存储到`es`

## 版本

### 1.0

* 安装使用`es`收集作为默认`master`分支.
* 安装针对`mysql-slow-log`收集工具.