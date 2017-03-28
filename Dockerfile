FROM albodor/ubuntu:xenial-20170328
MAINTAINER elouiz.badr@gmail.com
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server supervisor \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash \
 && apt-get install -y gitlab-ce && rm -rf /var/lib/apt/lists/*

EXPOSE 22/tcp 80/tcp 443/tcp

ADD entrypoint.sh /

ENTRYPOINT ["./entrypoint.sh"]
