# Container image that runs your code
FROM node:12.22.12-bullseye-slim
ARG SLS_VERSION
ENV SLS_VERSION ${SLS_VERSION}

#Install Python
RUN apt-get update && apt-get -y install curl python3-pip && \
    pip3 install awscli && \
    npm install -g serverless@${SLS_VERSION}
