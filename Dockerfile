# Container image that runs your code
FROM node:14-alpine3.17

ENV SERVERLESS_VERSION=3.26.0

#Install Python
RUN apk add --update --no-cache curl py-pip && \
    pip install awscli && \
    npm install -g serverless@${SERVERLESS_VERSION}

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

# Prepare entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
