FROM ubuntu:24.04

ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"

# Intall basic packages :
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget nano curl unzip tzdata locales ca-certificates sudo gpg && \
    apt-get upgrade ca-certificates -y && \
    apt-get install -y iputils-ping iproute2 net-tools && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Install kubectl :
RUN apt-get update -y && \
    apt-get install -y apt-transport-https gnupg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | \
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | \
    tee /etc/apt/sources.list.d/kubernetes.list && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update -y && \
    apt-get install -y kubectl

CMD ["/bin/sh", "-c", "tail -f /dev/null"]

