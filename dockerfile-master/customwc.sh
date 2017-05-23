#!/bin/bash

# wordcount example.
# init.sh have to be executed prior to this events.
HADOOP_VERSION=2.8.0

echo "HADOOP_CLASSPATH:" $HADOOP_CLASSPATH
echo "PATH:"$PATH

echo "Hello World Bye World" >> $HADOOP_HOME/file01
echo "Hello Hadoop Goodbye Hadoop" >> $HADOOP_HOME/file02

hdfs dfs -mkdir /input
hdfs dfs -put $HADOOP_HOME/file01 /input
hdfs dfs -put $HADOOP_HOME/file02 /input

hadoop com.sun.tools.javac.Main /custom-wc/wordcount1/WordCount.java
jar cf wc.jar WordCount*.class

echo "confirm input file content"
hadoop dfs -cat /user/joe/wordcount/input/file01
hadoop dfs -cat /user/joe/wordcount/input/file02

# execute custom wordcount example
hadoop jar wc.jar WordCount /input /output

#print output
hdfs dfs -cat /output/*

