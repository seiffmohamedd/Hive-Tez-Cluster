FROM ubuntu:20.04 

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    HADOOP_HOME=/opt/hadoop \
    ZOOKEEPER_HOME=/opt/zookeeper \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    TEZ_HOME=/opt/tez \
    TEZ_CONF_DIR=/opt/tez/conf \
    HIVE_HOME=/opt/hive \
    HIVE_CONF_DIR=/opt/hive/conf \
    HIVE_AUX_JARS_PATH=/opt/hive/lib \
    SQOOP_HOME=/opt/sqoop \
    SQOOP_CONF_DIR=/opt/sqoop/conf \
    PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin:/opt/zookeeper/bin:/opt/hive/bin:/opt/sqoop/bin

ENV HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_HOME/*:$TEZ_HOME/lib/*:$HADOOP_HOME/share/hadoop/tools/lib/*:/opt/sqoop/lib/*
ENV SQOOP_CLASSPATH=/opt/sqoop/lib/*

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    openjdk-8-jdk \
    wget nano \
    openssh-server \
    netcat \
    net-tools \
    sudo \
    postgresql-client \
    libpostgresql-jdbc-java \
    python3 \
    python3-pip 

RUN pip3 install \
    pandas \
    pyhive \
    thrift==0.13.0 \  
    sqlalchemy \
    pymysql \
    mysql-connector-python

RUN apt-get update && apt-get install -y \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pyhive[hive] thrift thrift_sasl sasl


RUN addgroup hadoop
RUN adduser --disabled-password --ingroup hadoop hadoop

ADD https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz /hadoop.tar.gz
RUN tar -xzvf /hadoop.tar.gz -C /opt && \
    mv /opt/hadoop-3.3.6 /opt/hadoop && \
    rm /hadoop.tar.gz
RUN chown -R hadoop:hadoop /opt/hadoop


ADD https://dlcdn.apache.org/zookeeper/zookeeper-3.8.4/apache-zookeeper-3.8.4-bin.tar.gz /zookeeper.tar.gz
RUN tar -xzvf /zookeeper.tar.gz -C /opt && \
    mv /opt/apache-zookeeper-3.8.4-bin /opt/zookeeper && \
    cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
    rm /zookeeper.tar.gz
RUN chown -R hadoop:hadoop /opt/zookeeper

ADD https://dlcdn.apache.org/hive/hive-4.0.1/apache-hive-4.0.1-bin.tar.gz /hive.tar.gz
RUN tar -xzvf /hive.tar.gz -C /opt && \
    mv /opt/apache-hive-4.0.1-bin /opt/hive && \
    rm /hive.tar.gz && \
    chown -R hadoop:hadoop /opt/hive

ADD https://dlcdn.apache.org/tez/0.10.4/apache-tez-0.10.4-bin.tar.gz /tez.tar.gz
RUN tar -xzvf /tez.tar.gz -C /opt && \
    mv /opt/apache-tez-0.10.4-bin /opt/tez && \
    rm /tez.tar.gz && \
    chown -R hadoop:hadoop /opt/tez

ADD https://jdbc.postgresql.org/download/postgresql-42.2.5.jar /postgresql-42.2.5.jar
RUN mv /postgresql-42.2.5.jar /opt/hive/lib/ && \
    chown -R hadoop:hadoop /opt/hive/lib/postgresql-42.2.5.jar

ADD https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz /sqoop.tar.gz
RUN tar -xzvf /sqoop.tar.gz -C /opt && \
    mv /opt/sqoop-1.4.7.bin__hadoop-2.6.0 /opt/sqoop && \
    rm /sqoop.tar.gz && \
    chown -R hadoop:hadoop /opt/sqoop

RUN cp /opt/hive/lib/postgresql-42.2.5.jar /opt/sqoop/lib/
RUN chown -R hadoop:hadoop /opt/sqoop/lib/*

RUN cp /opt/sqoop/conf/sqoop-env-template.sh /opt/sqoop/conf/sqoop-env.sh && \
    echo "export HADOOP_COMMON_HOME=/opt/hadoop" >> /opt/sqoop/conf/sqoop-env.sh && \
    echo "export HADOOP_MAPRED_HOME=/opt/hadoop" >> /opt/sqoop/conf/sqoop-env.sh && \
    echo "export HIVE_HOME=/opt/hive" >> /opt/sqoop/conf/sqoop-env.sh && \
    chown -R hadoop:hadoop /opt/sqoop/conf
    
RUN echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER hadoop
WORKDIR /home/hadoop

RUN ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys


RUN mkdir -p /opt/hadoop/tmp && \
    mkdir -p /opt/hadoop/hdfs && \
    mkdir -p /opt/hadoop/hdfs/namenode && \
    mkdir -p /opt/hadoop/hdfs/journal && \
    mkdir -p /opt/hadoop/hdfs/datanode && \
    mkdir -p /opt/hive/conf && \
    mkdir -p /opt/sqoop/conf
 

COPY ConfigHA/* $HADOOP_CONF_DIR/
COPY ConfigZoo/* $ZOOKEEPER_HOME/conf/
COPY ConfigHive/* /opt/hive/conf/



COPY entrypoint.sh /home/hadoop/entrypoint.sh
RUN sudo chmod +x /home/hadoop/entrypoint.sh

COPY etl_script.py /home/hadoop/etl_script.py
RUN sudo chmod +x /home/hadoop/etl_script.py

ENTRYPOINT ["./entrypoint.sh"]