FROM ubuntu:bionic
RUN \
  apt-get update && \
  # устанавливаем утилиты
  apt-get install -y \
    wget \
    curl \
    software-properties-common \
    sudo && \
  # устанавливаем OpenJDK 11
  add-apt-repository ppa:openjdk-r/ppa && \
  apt-get update && \
  apt-get install -y openjdk-11-jdk && \
  update-java-alternatives -s java-1.11.0-openjdk-amd64 && \
  # очищаем временные файлы
  apt-get clean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# рабочий каталог
WORKDIR /lab

# копируем файлы в образ
COPY . .

# собираем 
RUN ./mvnw install

# точка входа, запуск сервера
CMD ["java","-jar","target/java-getting-started-1.0.jar"]