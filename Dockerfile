FROM debian:stable
MAINTAINER Johann Wagner <johann@wagnerdevelopment.de>

ENV HUGO_URL "https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_0.58.3_Linux-64bit.deb"
ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install curl and apt-transport-https
RUN apt-get -y update && apt-get -y install curl git python-pygments golang mercurial

# install hugo
ADD ${HUGO_URL} /tmp/
RUN dpkg -i /tmp/hugo_*.deb

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# echo hugo version
CMD hugo version
