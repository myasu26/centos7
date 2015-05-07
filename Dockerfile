FROM centos/c7-systemd
RUN yum -y install openssh-server passwd; yum clean all; systemctl enable sshd.service;
EXPOSE 22
CMD ["/usr/sbin/init","3"]
