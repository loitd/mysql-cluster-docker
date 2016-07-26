# ###############################################################
# ref: https://www.howtoforge.com/tutorial/how-to-install-and-configure-mysql-cluster-on-centos-7/

from centos:6.8
MAINTAINER Loitd at Config9.com <"loitranduc@gmail.com">

# ###############################################################
# Install basic package

RUN yum update && yum install net-tools vim wget curl 
# check to download your appropriate rpm/deb package from official download page
# In RHEL 5 vs 6, there will be a lot of dependencies missing errors occur and you won't like this
RUN wget --no-check-certificate https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.12-1.rhel5.x86_64.rpm-bundle.tar
# RUN wget --no-check-certificate https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.12-1.el6.x86_64.rpm-bundle.tar 
RUN tar -xvf MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar

# ################################################################
# MySQL-Cluster-client-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-devel-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-embedded-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-gpl-7.4.12-1.rhel5.x86_64.rpm-bundle.tar
# MySQL-Cluster-server-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-shared-compat-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-shared-gpl-7.4.12-1.rhel5.x86_64.rpm
# MySQL-Cluster-test-gpl-7.4.12-1.rhel5.x86_64.rpm

RUN rpm -Uvh MySQL-Cluster-*

# ################################################################
# SETUP MANAGEMENT NODE
# Now copy config file
RUN mkdir -p /var/lib/mysql-cluster
COPY mgm_config.ini /var/lib/mysql-cluster/
RUN ndb_mgmd --config-file=/var/lib/mysql-cluster/mgm_config.ini

# ################################################################
# Now mgmd is running and we can test with this command
# ndb_mgm
# show
