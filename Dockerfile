#!/bin/bash
FROM maven:alpine

LABEL maintainer="Zia ALBORZI <zalborzi@ecomundo.eu>"

RUN apk add --update --no-cache \
        unzip wget

ARG STANFORD_CORENLP_VERSION="4.2.0"
ARG MODELS="English,French,German,Spanish"

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}.zip && \
    unzip stanford-corenlp-${STANFORD_CORENLP_VERSION}.zip && \
    rm stanford-corenlp-${STANFORD_CORENLP_VERSION}.zip

WORKDIR stanford-corenlp-${STANFORD_CORENLP_VERSION}

RUN case "$MODELS" in *"English"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-english.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-english.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN case "$MODELS" in *"French"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-french.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-french.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN case "$MODELS" in *"German"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-german.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-german.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN case "$MODELS" in *"Spanish"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-spanish.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-spanish.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN case "$MODELS" in *"Chinese"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-chinese.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-chinese.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN case "$MODELS" in *"Arabic"*) \
        wget http://nlp.stanford.edu/software/stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-arabic.jar && \
        mvn install:install-file -Dfile=stanford-corenlp-${STANFORD_CORENLP_VERSION}-models-arabic.jar \
        -DgroupId=edu.stanford.nlp -DartifactId=stanford-srparser \
        -Dversion=${STANFORD_CORENLP_VERSION} -Dpackaging=jar \
        ;; esac

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV JAVA_MX 8g
ENV PORT 9000
EXPOSE $PORT

CMD java -cp "*" -mx$JAVA_MX edu.stanford.nlp.pipeline.StanfordCoreNLPServer
