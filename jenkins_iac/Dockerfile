FROM jenkins/jenkins

#Becoming superuser
USER root

RUN mkdir /etc/build 

COPY ./conf/requirements.txt /etc/build

WORKDIR /etc/build
#Installing Packer
#Installing Ansible
#Also installing collections for major cloud providers, this allows us to run ansible against tagged VM's
#Installing Terraform 
RUN apt-get update && apt-get install python3-pip -y && \
    pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip3 install -r requirements.txt; \
    pip3 install awscli; \
    pip3 install azure-cli; \
    ansible-galaxy collection install azure.azcollection; \
    ansible-galaxy collection install amazon.aws; \
    ansible-galaxy collection install google.cloud; \
    apt-get install wget unzip; \
    wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip; \
    unzip ./terraform_1.0.0_linux_amd64.zip; \
    mv terraform /usr/local/bin; \
    terraform --version; \ 
    wget https://releases.hashicorp.com/packer/1.7.2/packer_1.7.2_linux_amd64.zip; \
    unzip ./packer_1.7.2_linux_amd64.zip; \
    mv packer /usr/local/bin; \
    packer --version
EXPOSE 8080
