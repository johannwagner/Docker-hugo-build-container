FROM debian:latest
MAINTAINER Samuel Debruyn <s@muel.be>

ENV DEBIAN_FRONTEND noninteractive

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

# install hugo	
RUN HUGO_VERSION=0.14 wget https://github.com/spf13/hugo/releases/download/${HUGO_VERSION}/hugo_${HUGO_VERSION}_amd64.deb -O hugo.deb && dpkg-i hugo.deb && rm hugo.deb

# install pygments
RUN pip install Pygments

# install html-proofer
RUN gem install html-proofer -N

# install nodeJS
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install nodejs npm

# install html-minifier
RUN npm install html-minifier -g

# install yuicompressor
RUN npm install yuicompressor -g

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*