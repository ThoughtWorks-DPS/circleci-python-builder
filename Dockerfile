FROM ghcr.io/thoughtworks-dps/twdps/circleci-base-image:alpine-5.0.0

LABEL org.opencontainers.image.authors="nic.cheneweth@thoughtworks.com" \
      org.opencontainers.image.description="Alpine-based CircleCI executor image" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.title="circleci-python-builder" \
      org.opencontainers.image.vendor="ThoughtWorks, Inc."

ENV CONFTEST_VERSION=0.39.2

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo bash -c "echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             curl==7.88.1-r0 \
             libcurl==7.88.1-r0 \
             wget==1.21.3-r2 \
             gnupg==2.2.40-r0 \
             python3==3.10.10-r0 \
             python3-dev==3.10.10-r0 \
             docker==20.10.21-r3 \
             openrc==0.45.2-r7 \
             nodejs==18.14.2-r0 \
             npm==9.1.2-r0 \
             jq==1.6-r2 \
             build-base==0.5-r3 \
             openssl-dev==3.0.8-r0 \
             libffi-dev==3.4.4-r0 \
             g++==12.2.1_git20220924-r4 \
             gcc==12.2.1_git20220924-r4 \
             make==4.3-r1 && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==23.0.1 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
         setuptools==67.4.0 \
         awscli==1.27.94 \
         setuptools_scm==7.1.0 \
         moto==4.1.4 \
         wheel==0.38.4 \
         build==0.10.0 \
         twine==4.0.2 \
         pipenv==2023.2.18 \
         pylint==2.16.3 \
         pytest==7.2.2 \
         pytest-cov==4.0.0 \
         coverage==7.2.1 \
         invoke==1.7.3 \
         requests==2.28.2 \
         jinja2==3.1.2 && \
    sudo npm install -g \
             snyk@1.1115.0 \
             bats@1.9.0 && \
    sudo bash -c "curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter" && \
    sudo chmod +x /usr/local/bin/cc-test-reporter && \
    wget --quiet https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && rm ./* && \
    sudo -u circleci mkdir /home/circleci/.gnupg && \
    sudo -u circleci bash -c "echo 'allow-loopback-pinentry' > /home/circleci/.gnupg/gpg-agent.conf" && \
    sudo -u circleci bash -c "echo 'pinentry-mode loopback' > /home/circleci/.gnupg/gpg.conf" && \
    chmod 700 /home/circleci/.gnupg && \
    chmod 600 /home/circleci/.gnupg/*

USER circleci
