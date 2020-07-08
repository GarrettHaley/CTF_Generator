FROM ubuntu:latest
ENV FLAG=$FLAG_1
RUN touch /home/ubuntu/hello.txt
RUN echo "comething" >> /home/ubuntu/flag.txt
RUN apt update && apt install  openssh-server sudo -y 
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 
RUN  echo 'test:test' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]