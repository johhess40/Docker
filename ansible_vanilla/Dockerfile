FROM centos:centos7.7.1908 

RUN mkdir /etc/Container 

COPY ./ServicePrincipal.ps1 /etc/Container 

COPY ./requirements-azure.txt /etc/Container

COPY ./Container/azlogin.sh /etc/Container

RUN chmod +x /etc/Container/ServicePrincipal.ps1

RUN chmod +x /etc/Container/azlogin.sh

WORKDIR /etc/Container

RUN yum check -update; \
    yum install -y gcc libffi-devel python3 epel-release; \
    yum install -y openssh-clients; \
    pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip install -r requirements-azure.txt; \
    ansible-galaxy collection install azure.azcollection; 

RUN /etc/Container/azlogin.sh

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo 

RUN yum install -y powershell

RUN pwsh -Command Install-Module -Name Az -Force

RUN pwsh -Command "./ServicePrincipal.ps1"

RUN subscriptionId=$(pwsh -Command "(Get-AzContext).Subscription.Id") \
    clientid=$(pwsh -Command "(Get-AzAdServicePrincipal -DisplayName 'ansible').ApplicationId.Guid") \
    secret='P@ssW0rd1234!@' \
    tenantid=$(pwsh -Command "(Get-AzContext).Tenant.Id") \
    export AZURE_SUBSCRIPTION_ID=$subscriptionId; \
    export AZURE_CLIENT_ID=$clientid; \
    export AZURE_SECRET=$secret; \
    export AZURE_TENANT=$tenantid; 

ENTRYPOINT az account show > currentsub.txt








