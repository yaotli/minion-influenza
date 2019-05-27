FROM ubuntu
MAINTAINER yaotli <nprotei@gmail.com>

RUN apt-get update
RUN apt-get install -y git build-essential wget zlib1g-dev vim libncurses5-dev

RUN git clone --recursive https://github.com/jts/nanopolish/ && cd nanopolish && git checkout && make

ENV PATH $PATH:/nanopolish
