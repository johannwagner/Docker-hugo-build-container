FROM debian:latest
MAINTAINER Samuel Debruyn <s@muel.be>

ENV HUGO_VERSION 0.14
ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install required packages
RUN apt-get -y update && apt-get -y install \
	build-essential \
	curl \
	git \
	openjdk-7-jre \
	python-pip \
	ruby \
	rubygems \
	wget

# install pygments
RUN pip install Pygments

# install nodeJS
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*