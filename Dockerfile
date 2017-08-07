FROM node:6.11.1-alpine

# RUN apk add --no-cache --virtual .build-deps \
#		ca-certificates \
#		gcc \
#		make \
#		openssl \
#		python \
#		unzip \
#	&& wget -O ghost.zip "https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip" \
#	&& unzip ghost.zip \
#	&& npm install --production \
#	&& apk del .build-deps \
#	&& rm ghost.zip \
#	&& npm cache clean \
#	&& rm -rf /tmp/npm*

RUN apk add --no-cache --virtual .build-deps \
		ca-certificates \
		gcc \
		make \
		openssl \
		python \
		unzip

#RUN apk add --no-cache sudo

WORKDIR /app
RUN adduser -HD ghost

ENV NODE_ENV=production

RUN npm install -g ghost-cli
RUN ghost install local -V --no-stack --no-setup --no-start

RUN apk add --no-cache git
COPY entrypoint.sh .
WORKDIR /app/versions/1.0.0-rc.1/core/server/adapters/storage
RUN git clone https://github.com/matti/ghost-imgur
WORKDIR /app/current
RUN npm install matti/ghost-imgur
WORKDIR /app
#RUN chown -R ghost /app
#USER ghost
