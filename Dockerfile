FROM debian:latest

RUN apt-get -y update && apt-get -y install \
	build-essential \
	curl \
	git \
	openjdk-7-jre \
	ruby2.1 \
	wget