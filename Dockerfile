FROM centos/c7-systemd
RUN yum -y install openssh-server passwd; yum clean all; systemctl enable sshd.service;
RUN mkdir ~/.ssh; curl -o ~/.ssh/authorized_keys https://github.com/myasu26.keys
EXPOSE 22
CMD ["/usr/sbin/init","3"]
