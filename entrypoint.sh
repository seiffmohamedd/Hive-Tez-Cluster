#!/bin/bash

case $(hostname) in
  master11|master22|master33)
    NODE_TYPE="master"
    ;;
  metastore)
    NODE_TYPE="metastore"
    ;;
  hiveserver2)
    NODE_TYPE="hiveserver"
    ;;
  *)
    NODE_TYPE="worker"
    ;;
esac

sudo service ssh start

if [[ $NODE_TYPE == "master" ]]; then
  mkdir -p $ZOOKEEPER_HOME/data
  case $(hostname) in
    master11) echo "1" > $ZOOKEEPER_HOME/data/myid ;;
    master22) echo "2" > $ZOOKEEPER_HOME/data/myid ;;
    master33) echo "3" > $ZOOKEEPER_HOME/data/myid ;;
  esac

  if [[ $(hostname) == "master11" ]]; then
    $ZOOKEEPER_HOME/bin/zkServer.sh start
    hdfs --daemon start journalnode
    hdfs namenode -initializeSharedEdits -force
    hdfs namenode -format
    hdfs zkfc -formatZK -force
    hdfs --daemon start namenode
    hdfs --daemon start zkfc
    sleep 40
    while true; do
      if jps | grep -q 'NameNode' && jps | grep -q 'ZKFailoverController'; then
        echo "NameNode and ZKFailoverController are running on master11."
        break
      fi
      echo "Waiting for NameNode and ZKFailoverController to start..."
      sleep 5
    done
  else
    sleep 10
    $ZOOKEEPER_HOME/bin/zkServer.sh start
    hdfs --daemon start journalnode
    hdfs namenode -bootstrapStandby -force
    hdfs --daemon start namenode
    hdfs --daemon start zkfc
  fi
  
  yarn --daemon start resourcemanager

elif [[ $NODE_TYPE == "metastore" ]]; then
  sleep 50
  hdfs dfs -mkdir /tez
  hadoop fs -put /opt/tez/share/tez.tar.gz /tez/
  schematool -initSchema -dbType postgres
  hive --service metastore &
  sleep 20

elif [[ $NODE_TYPE == "hiveserver" ]]; then
  sleep 50
  export HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_HOME/*:$TEZ_HOME/lib/*
  hiveserver2 &

  sleep 20

    
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table time_dim --target-dir /user/hadoop/customer_care/time_dim --m 1
  sleep 20
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table date_dim --target-dir /user/hadoop/customer_care/date_dim --m 1
  sleep 20
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table feedback_dim --target-dir /user/hadoop/customer_care/feedback_dim --m 1
  sleep 20
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table employee_dim --target-dir /user/hadoop/customer_care/employee_dim --m 1
  sleep 20
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table customer_dim --target-dir /user/hadoop/customer_care/customer_dim --m 1   
  sleep 20
  sqoop import --connect jdbc:postgresql://postgres:5432/hive --username seif --password seif --table customercarefact --target-dir /user/hadoop/customer_care/customercarefact --m 1
  sleep 20

  
else
  hdfs --daemon start datanode
  yarn --daemon start nodemanager
fi

sleep infinity