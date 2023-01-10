# Container image that runs your code
FROM node:14-alpine3.17

#Install Python
RUN apk add --update --no-cache curl py-pip

RUN pip install awscli

#Latest should be 3.26.0
RUN npm install -g serverless

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

# Prepare entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
