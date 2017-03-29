FROM albodor/ubuntu:xenial.20170328

MAINTAINER elouiz.badr@gmail.com

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server supervisor \
 && curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash \
 && apt-get install -y gitlab-ce && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 22/tcp 80/tcp 443/tcp

VOLUME ["/var/opt/gitlab"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
