# hugo-build

A docker container to build and test hugo sites.

[![layers](https://badge.imagelayers.io/samueldebruyn/hugo-build:latest.svg "layers")](https://imagelayers.io/?images=samueldebruyn/hugo-build:latest)

[![wercker status](https://app.wercker.com/status/8afdbf4994c7db1948a47dfd28304863/s/master "wercker status")](https://app.wercker.com/project/bykey/8afdbf4994c7db1948a47dfd28304863)

*Please ignore the ~~failing~~ builds until [this issue](https://github.com/Runnable/validate-dockerfile/issues/17) is resolved.*

[![docker](http://dockeri.co/image/samueldebruyn/hugo-build "docker")](https://registry.hub.docker.com/u/samueldebruyn/hugo-build/)

## What this container is for

This container is ideally used in a [wercker](http://wercker.com) step to build a static site made with [hugo](http://gohugo.io). You can also use it to check your website for dead links and syntax errors and to minify the generated code.

## Packages

The following packages and its dependencies are installed:

* curl
* git
* [html-minifier](https://github.com/kangax/html-minifier) (Node.js)
* [html-proofer](https://github.com/gjtorikian/html-proofer) (Ruby)
* hugo
* [yuicompressor](https://github.com/yui/yuicompressor) (Java)
* wget

## Example *wercker.yml*

*This is taken from [my own hugo site](https://github.com/SamuelDebruyn/sa.muel.be-hugo).*

	build:
	  box: samueldebruyn/hugo-build
	  steps:
	    - script:
	        name: initialize git submodules
	        code: |
	            git submodule update --init --recursive
	    - script:
	        name: build with hugo
	        code: |
	            hugo
	    - samueldebruyn/minify
	    - kyleboyle/html-proofer-test:
	        basedir: public
	        arguments: --check-external-hash --href-ignore /https?:\/\/sa.muel.be.*/ig
