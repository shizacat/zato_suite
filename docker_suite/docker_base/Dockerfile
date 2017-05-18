# Zato base image

FROM ubuntu:16.04
MAINTAINER ShizaCat <...@zato.io>

# Install helper programs used during Zato installation
RUN apt-get update && \
	apt-get install -y \
		apt-transport-https \
		python-software-properties \
		software-properties-common \
		telnet \
	&& apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# Build Zato
RUN apt-get update && \
	apt-get install -y \
		sudo \
		git \
		curl \
		wget \
	&& \
	git clone https://github.com/zatosource/zato.git /opt/zato && \
	/opt/zato/code/install.sh && \
	cd /opt/zato/code && \
	/opt/zato/code/bin/python bootstrap.py -v 1.7.0 && \
	/opt/zato/code/bin/buildout && \
	apt-get remove -y \
		git \
		curl \
		wget \
	&& \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN ln -s /opt/zato/code/bin/zato /bin/zato

WORKDIR	/opt/zato/code/

# ENTRYPOINT ["/opt/zato/code/bin/zato"]
CMD ["/opt/zato/code/bin/zato"]
