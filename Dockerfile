FROM debian:stable
MAINTAINER Samuel Debruyn <s@muel.be>

ENV HUGO_URL "https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1-64bit.deb"
ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install curl and apt-transport-https
RUN apt-get -y update && apt-get -y install curl apt-transport-https gnupg

# install required packages (optipng helps you optimize images)
RUN apt-get -y update && apt-get -y install \
	git \
    	optipng \
	python-pygments \
	wget \
	yui-compressor

# install hugo
ADD ${HUGO_URL} /tmp/
RUN dpkg -i /tmp/hugo_*.deb

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# echo hugo version
CMD hugo version
