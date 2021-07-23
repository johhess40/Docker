FROM centos:7
RUN yum -y install openssh-server 

RUN useradd johnhession;  \
    echo "password123" | passwd --stdin johnhession; \
    mkdir /home/johnhession/.ssh && \
    chmod 700 /home/johnhession/.ssh

COPY remote-key.pub /home/johnhession/.ssh/authorized_keys

RUN chown johnhession:johnhession -R /home/johnhession/.ssh/ && \
    chmod 600 /home/johnhession/.ssh/authorized_keys

EXPOSE 22

RUN ssh-keygen -A

COPY script.sh /tmp

RUN yum check -update; \
    yum install -y gcc libffi-devel python3 epel-release mysql; \
    yum install -y openssh-clients; \
    pip3 install --upgrade pip; \
    pip3 install azure-cli

CMD /usr/sbin/sshd -D





