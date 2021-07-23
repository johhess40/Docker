FROM centos:7

LABEL Owner="John Hession"

ENV APACHE_URLS=http://*:80

USER root

RUN yum -y update; \
    yum -y install httpd; \
    yum clean all

COPY App /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]