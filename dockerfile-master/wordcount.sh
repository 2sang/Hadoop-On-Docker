#!/bin/bash

# wordcount example.
# init.sh have to be executed prior to this events.
HADOOP_VERSION=2.8.0

hdfs dfs -mkdir /input
hdfs dfs -put $HADOOP_HOME/LICENSE.txt /input

# execute wordcount example
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-${HADOOP_VERSION}.jar wordcount /input /output

#print output
hdfs dfs -cat /output/*



