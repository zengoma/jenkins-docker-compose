FROM jenkins/jenkins:lts

ENV JENKINS_HOME="/var/jenkins_home"
ENV DOCKER_COMPOSE_VERSION="1.24.0"

USER root

RUN apt-get update -qq &&  apt-get install -y sudo build-essential

# Install Docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN usermod -aG sudo jenkins && echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER jenkins
