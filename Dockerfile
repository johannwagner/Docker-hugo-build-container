FROM debian:stable-slim
MAINTAINER Samuel Debruyn <s@muel.be>

ENV HUGO_VERSION 0.18
ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install curl and apt-transport-https
RUN apt-get -y update && apt-get -y install curl apt-transport-https gnupg

# add sources for nodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# install required packages (optipng helps you optimize images)
RUN apt-get -y update && apt-get -y install \
	build-essential \
	git \
	nodejs \
    	optipng \
	python-pygments \
	wget \
	yui-compressor
	
# update npm
RUN npm install npm -g

# install html-minifier
RUN npm install html-minifier -g

# install hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_amd64.deb /tmp/
RUN dpkg -i /tmp/hugo_*.deb

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# echo hugo version
CMD hugo version
