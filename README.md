# jvm-build-tools

## image contains

- curl
- jq
- make
- just
- sdkman
- java
- docker
- docker-compose

## see:

- https://e.printstacktrace.blog/using-sdkman-as-a-docker-image-for-jenkins-pipeline-a-step-by-step-guide/
- https://computingforgeeks.com/install-docker-and-docker-compose-on-debian-10-buster/
- https://computingforgeeks.com/how-to-install-latest-docker-compose-on-linux/
- https://github.com/YMonnier/docker-sdkman-java

## build image
```
see: https://github.com/casey/just

# java 11
$ just docker-build-java11

# java8
$ just docker-build-java8

```

## run image
```
# java 11
$ docker run --rm ci-jvm-build-tools:java-11 java -version
$ docker run --rm -it ci-jvm-build-tools:java-11 bash

# java 8
$ docker run --rm ci-jvm-build-tools:java-8 java -version
$ docker run --rm -it ci-jvm-build-tools:java-8 bash

```

