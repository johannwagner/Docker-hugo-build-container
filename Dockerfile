FROM debian:jessie
MAINTAINER Samuel Debruyn <s@muel.be>

ENV HUGO_VERSION 0.14
ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install curl and apt-transport-https
RUN apt-get -y update && apt-get -y install curl apt-transport-https

# add sources for nodeJS
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo 'deb https://deb.nodesource.com/node_0.12 jessie main' > /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src https://deb.nodesource.com/node_0.12 jessie main' >> /etc/apt/sources.list.d/nodesource.list

# install required packages (zlib1g-dev is required for nokogiri, a dependency of html-proofer)
RUN apt-get -y update && apt-get -y install \
	build-essential \
	git \
	nodejs \
	python-pygments \
	ruby \
	ruby-dev \
	wget \
	yui-compressor \
	zlib1g-dev

# install html-minifier
RUN npm install html-minifier -g

# install html-proofer
RUN gem install html-proofer -N

# install hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_amd64.deb /tmp/
RUN dpkg -i /tmp/hugo_*.deb

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
