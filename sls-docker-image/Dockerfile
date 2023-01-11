# Container image that runs your code
FROM node:14-bullseye-slim
ARG SLS_VERSION
ENV SLS_VERSION ${SLS_VERSION}

ENV SERVERLESS_VERSION=3.26.0

#Install Python
RUN apt-get update && apt-get -y install curl python3-pip && \
    pip3 install awscli && \
    npm install -g serverless@${SLS_VERSION}
