FROM oraclelinux:7.2
RUN yum -y update
ADD jre-8u101-linux-i586.rpm /tmp
ADD linux_12102_client32.zip /tmp
RUN yum install -y libstdc++-devel.i686 \
		   libXrender.i686 \
                   libuuid.i686 \
                   libXext.i686 \
		   xterm \
		   less \
		   unzip \
		cpp \
		glibc-headers \
		mpfr \
		compat-libstdc++-33-3.2.3 \
		binutils-2.23.52.0.1-12.el7.x86_64 \
		compat-libcap1 \
		gcc.x86_64 \
		gcc-c++ \
		glibc.i686 \
		glibc.x86_64\
#		glibc-2.17-36.el7.i686 \
#		glibc-2.17-36.el7.x86_64 \
		glibc-devel.i686 \
		glibc-devel.x86_64 \
#		glibc-devel-2.17-36.el7.i686 \
#		glibc-devel-2.17-36.el7.x86_64 \
		ksh \
		libaio.i686 \
		libaio.x86_64 \
#		libaio-0.3.109-9.el7.i686 \
#		libaio-0.3.109-9.el7.x86_64 \
		libaio-devel.i686 \
		libaio-devel.x86_64 \
#		libaio-devel-0.3.109-9.el7.i686 \
#		libaio-devel-0.3.109-9.el7.x86_64 \
		libgcc-4.8.2-3.el7.i686 \
		libgcc-4.8.2-3.el7.x86_64 \
		libstdc++.i686 \
		libstdc++.x86_64 \
#		libstdc++-4.8.2-3.el7.i686 \
#		libstdc++-4.8.2-3.el7.x86_64 \
		libstdc++-devel.i686 \
		libstdc++-devel.x86_64 \
#		libstdc++-devel-4.8.2-3.el7.i686 \
#		libstdc++-devel-4.8.2-3.el7.x86_64 \
		libXi-1.7.2-1.el7.i686 \
		libXi-1.7.2-1.el7.x86_64 \
		libXtst-1.2.2-1.el7.i686 \
		libXtst-1.2.2-1.el7.x86_64 \
		make.x86_64 \
		sysstat.x86_64 
	
RUN yum install -y /tmp/jre-8u101-linux-i586.rpm
RUN groupadd -g 500 dba && \
    groupadd -g 501 oinstall && \
    useradd -d /home/oracle -g dba -G oinstall,dba -m -s /bin/bash oracle -p oracle && \
    useradd -g dba -ms /bin/bash siebel -p siebel
# RUN /usr/sbin/useradd -ms /bin/bash oracle -p oracle
# RUN /usr/sbin/groupadd oinstall && \
#   /usr/sbin/usermod -g oinstall -G adm oracle && \
RUN mkdir /var/run/sshd && \ 
    mkdir /oracle && \
    chown oracle:oinstall /oracle && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

USER oracle
RUN cd /tmp && \
    unzip -q linux_12102_client32.zip
COPY ora_client_12c_install.rsp /tmp/client.rsp
RUN pwd && ls -ltr && ls -ltr /tmp
COPY ora_client_12c_install.rsp /tmp/
RUN cd /tmp/client32 && \
    ./runInstaller -silent -waitforcompletion -showProgress -responseFile /tmp/client.rsp
RUN cd /oracle && \
    ls -ltr
USER root

