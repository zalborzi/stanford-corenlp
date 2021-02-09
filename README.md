# stanford-corenlp

Dockerfile for Stanford CoreNLP Server
---------

This is a server wrapper for the [Stanford CoreNLP
Server](http://stanfordnlp.github.io/CoreNLP/corenlp-server.html). 
It exposes the endpoint on port 9000. 
Requests are made as described in the documentation.
You can specify the version you want to build, as well as to download model jars for the language you want via `--build-arg`.

## Build Docker image.

```shell
docker build --build-arg STANFORD_CORENLP_VERSION=4.2.0 --build-arg MODELS=English,French,German,Spanish,Chinese,Arabic -t corenlp:4.2.0 .
```

## Run Docker image in a container.
The container runs the server with some defaults and runs the jar with 4gb of memory. The command can be overriden:

```shell
docker run -p 9000:9000 -d corenlp:4.2.0 java -cp "*" -mx8g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -preload tokenize,ssplit,pos,lemma,depparse,ner,kbp,relation,coref,quote,sentiment -quiet
```
