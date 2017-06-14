FROM ubuntu:16.04

# Java
RUN apt-get update && apt-get -y install openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# VIM - only for temporarly debugging
RUN apt-get -y install vim

# openssh-server
RUN apt-get -y install openssh-server && apt-get -y install sshpass
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN echo 'root' >> /password.txt
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Hadoop
ENV HADOOP_VERSION 2.8.0
ENV HADOOP_HOME	/usr/local/hadoop
ENV HADOOP_CONFIG_HOME $HADOOP_HOME/etc/hadoop
ENV HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Downlaod hadoop from host machine
## Need to fix when deploy on web
COPY hadoop-$HADOOP_VERSION.tar.gz /
COPY apache-hive-1.2.2-bin.tar.gz /

RUN tar -zxvf /hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    mkdir -p /usr/local/hadoop/logs

RUN tar -zxvf /apache-hive-1.2.2-bin.tar.gz && \
    rm /apache-hive-1.2.2-bin.tar.gz && \
    mv /apache-hive-1.2.2-bin /usr/local/hive 

# Custom copy
COPY conf $HADOOP_HOME/etc/hadoop/
COPY bashrc-sub /etc/profile
COPY 4300.txt $HADOOP_HOME
COPY init.sh /init.sh
COPY wordcount.sh /wordcount.sh
COPY custom-wc /custom-wc
COPY customwc1.sh /customwc1.sh
COPY customwc2.sh /customwc2.sh
COPY customhive.sh /customhive.sh
COPY patterns.txt /patterns.txt
COPY tashu.csv /tashu.csv

RUN . /etc/profile

# When IP issue was solved
# RUN $HADOOP_HOME/bin/hdfs namenode -format 
# RUN $HADOOP_HOME/sbin/start-all.sh


EXPOSE 22 8020 8033 8041 8042 8088 9010 50010 50020 50075 50070 50090 

CMD ["/usr/sbin/sshd", "-D"]

