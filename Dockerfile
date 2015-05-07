FROM centos/c7-systemd
RUN yum -y install openssh-server passwd; yum clean all; systemctl enable sshd.service;
RUN mkdir ~/.ssh; curl -o ~/.ssh/authorized_keys https://github.com/myasu26.keys;chmod 600 ~/.ssh;chmod 400 ~/.ssh/authorized_keys
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin without-password/' /etc/ssh/sshd_config
RUN sed -ri 's/^#RSAAuthentication yes/RSAAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
RUN sed -ri 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -ri 's/^#Port 22/Port 22/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/usr/sbin/init","3"]
