FROM ubuntu:latest
ARG FLAG
RUN apt update && apt install  openssh-server sudo -y 
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 
RUN  echo 'test:test' | chpasswd

RUN touch /home/ubuntu/flag.txt
RUN echo $FLAG > /home/ubuntu/flag.txt

EXPOSE 22
RUN service ssh start
CMD ["/usr/sbin/sshd","-D"]