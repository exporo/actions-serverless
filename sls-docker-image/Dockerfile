# Container image that runs your code
FROM node:14-alpine3.17

ENV SERVERLESS_VERSION=3.26.0

#Install Python
RUN apk add --update --no-cache curl py-pip && \
    pip install awscli && \
    npm install -g serverless@${SERVERLESS_VERSION}
