FROM centos/c7-systemd

RUN yum -y install openssh-server passwd; yum clean all; systemctl enable sshd.service;
RUN mkdir ~/.ssh; curl -o ~/.ssh/authorized_keys https://github.com/myasu26.keys;chmod 700 ~/.ssh;chmod 600 ~/.ssh/authorized_keys
RUN sed -ri 's/^#PermitRootLogin yes/#PermitRootLogin without-password/' /etc/ssh/sshd_config
RUN sed -ri 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

EXPOSE 22
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init","3"]
