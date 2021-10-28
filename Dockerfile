# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

FROM python:3.7

# Retrieve the arguments passed from the docker build command
ARG CODEARTIFACT_TOKEN
ARG DOMAIN
ARG REGION
ARG REPO

RUN echo $CODEARTIFACT_TOKEN
RUN echo $DOMAIN
RUN echo $REGION
RUN echo $REPO
RUN echo https://aws:$CODEARTIFACT_TOKEN@$DOMAIN.d.codeartifact.$REGION.amazonaws.com/pypi/$REPO/simple/
COPY . /

#Manually configure the PIP client with the authenthication token
RUN pip config set global.index-url "https://aws:$CODEARTIFACT_TOKEN@$DOMAIN.d.codeartifact.$REGION.amazonaws.com/pypi/$REPO/simple/"
RUN pip install -r -v requirements.txt

CMD ["python","application.py"]