FROM centos:7
MAINTAINER "you" <hot@email.here>
ENV container docker
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i ==
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install openssh-server passwd; yum clean all; systemctl enable sshd.service;
RUN mkdir ~/.ssh; curl -o ~/.ssh/authorized_keys https://github.com/myasu26.keys;chmod 700 ~/.ssh;chmod 600 ~/.ssh/authorized_keys
RUN sed -ri 's/^#PermitRootLogin yes/#PermitRootLogin without-password/' /etc/ssh/sshd_config
RUN sed -ri 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

EXPOSE 22
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

