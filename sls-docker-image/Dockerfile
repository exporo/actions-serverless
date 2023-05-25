# Container image that runs your code
ARG NODE_VERSION
FROM node:${NODE_VERSION}-bullseye-slim
ARG SLS_VERSION
ENV SLS_VERSION ${SLS_VERSION}

#Install Python
RUN apt-get update && apt-get -y install curl python3-pip && \
    pip3 install awscli && \
    npm install -g serverless@${SLS_VERSION}
