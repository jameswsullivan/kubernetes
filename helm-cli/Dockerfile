FROM ubuntu:24.04

ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV CHARTS_DIR="/mnt/charts"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget nano curl unzip tzdata locales ca-certificates gpg && \
    apt-get upgrade ca-certificates -y && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Ref: https://helm.sh/docs/intro/install/#from-apt-debianubuntu
RUN curl https://baltocdn.com/helm/signing.asc | \
    gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
    apt-get install apt-transport-https --yes && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | \
    tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update -y && \
    apt-get install helm -y

WORKDIR ${CHARTS_DIR}

CMD ["/bin/sh", "-c", "tail -f /dev/null"]