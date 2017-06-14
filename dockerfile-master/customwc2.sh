#!/bin/bash

# wordcount example.
# init.sh have to be executed prior to this events.
HADOOP_VERSION=2.8.0
WC_ONE_PATH=/custom-wc/wordcount2

echo "HADOOP_CLASSPATH:" $HADOOP_CLASSPATH
echo "PATH:"$PATH

echo "Hello World, Bye World!" >> $HADOOP_HOME/file01
echo "Hello Hadoop, Goodbye to Hadoop." >> $HADOOP_HOME/file02

echo "mkdir /input"
hdfs dfs -mkdir /input

echo "put test files"
hdfs dfs -put $HADOOP_HOME/file01 /input
hdfs dfs -put $HADOOP_HOME/file02 /input

echo "confirm input file content"
hadoop dfs -cat /input/file01
hadoop dfs -cat /input/file02

cd $WC_ONE_PATH

cp /patterns.txt .
hdfs dfs -put patterns.txt /

echo "cd to wc_one_path, compile"
hadoop com.sun.tools.javac.Main WordCount2.java
echo "create a jar file using WordCount*.class"
jar cf wc.jar WordCount2*.class

# execute custom wordcount example
echo "execute custom wordcount example"
hadoop jar wc.jar WordCount2 -Dwordcount.case.sensitive=false /input /output -skip /patterns.txt

#print output
echo "print output"
hdfs dfs -cat /output/*

