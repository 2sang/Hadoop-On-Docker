FROM ubuntu:16.04

# Java
RUN apt-get update && apt-get -y install openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# openssh-server
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# iputils-ping
RUN apt-get -y install iputils-ping

# Hadoop
ENV HADOOP_VERSION 2.8.0
ENV HADOOP_HOME	/usr/local/hadoop
ENV HADOOP_CONFIG_HOME $HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Downlaod hadoop from host machine
## Need to fix when deploy on web
COPY hadoop-$HADOOP_VERSION.tar.gz /

RUN tar -zxvf /hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    mkdir -p /usr/local/hadoop/logs

COPY conf $HADOOP_HOME/etc/hadoop/
COPY bashrc-sub /etc/profile
COPY 4300.txt ~

# When IP issue was solved
# RUN $HADOOP_HOME/bin/hdfs namenode -format 
# RUN $HADOOP_HOME/sbin/start-all.sh


EXPOSE 22 8020 8033 8041 8042 8088 9010 50010 50020 50075 50070 50090 

CMD ["/usr/sbin/sshd", "-D"]

