FROM jenkins/jenkins

USER root

RUN mkdir /etc/Container 

COPY ./Container/requirements-azure.txt /etc/Container

COPY ./Container/azlogin.sh /etc/Container

WORKDIR /etc/Container

RUN apt-get update && apt-get install python3-pip -y && \
    pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip3 install -r requirements-azure.txt; \
    ansible-galaxy collection install azure.azcollection

RUN /etc/Container/azlogin.sh

