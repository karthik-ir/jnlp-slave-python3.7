FROM jenkins/jnlp-slave
RUN echo ${user}
USER root
RUN apt-get -y update
RUN apt-get -y install build-essential checkinstall
RUN apt-get -y install python3-pip
RUN apt-get  -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
RUN cd /usr/src
RUN wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
RUN tar xzf Python-3.7.3.tgz
RUN cd Python-3.7.3 &&  ./configure --enable-optimizations &&  make altinstall
RUN apt-get -y install python3-mock python3-nose python3-coverage pylint
RUN update-alternatives --install /usr/bin/pip3 python /usr/local/bin/pip3.7 10
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.7 20
RUN pip3.7 install --upgrade pip
RUN pip3 install wheel
RUN apt-get install -y zip swig libpulse-dev
USER jenkins
ENTRYPOINT ["jenkins-slave"]

