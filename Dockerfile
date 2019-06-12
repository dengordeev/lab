FROM ubuntu:bionic
RUN \
  apt-get update && \
  # install utilities
  apt-get install -y \
    wget \
    curl \
    software-properties-common \
    sudo && \
  # install OpenJDK 11
  add-apt-repository ppa:openjdk-r/ppa && \
  apt-get update && \
  apt-get install -y openjdk-11-jdk && \
  update-java-alternatives -s java-1.11.0-openjdk-amd64 && \
  # install node.js
  wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.gz -O /tmp/node.tar.gz && \
  tar -C /usr/local --strip-components 1 -xzf /tmp/node.tar.gz && \
  # upgrade npm
  npm install -g npm && \
  # cleanup
  apt-get clean && \
  rm -rf \
    /home/jhipster/.cache/ \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

WORKDIR /lab

COPY . .
RUN ./mvnw install
CMD ["java","-jar","target/java-getting-started-1.0.jar"]