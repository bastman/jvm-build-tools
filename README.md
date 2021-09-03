# jvm-build-tools

## see:

- https://e.printstacktrace.blog/using-sdkman-as-a-docker-image-for-jenkins-pipeline-a-step-by-step-guide/
- https://computingforgeeks.com/install-docker-and-docker-compose-on-debian-10-buster/
- https://computingforgeeks.com/how-to-install-latest-docker-compose-on-linux/

```
$ docker build -t sdkman:local .

$ docker run --rm -u $(id -u) sdkman:local java -version
$ docker run --rm -u $(id -u) sdkman:local jq --version

$ docker build -q --build-arg JAVA_VERSION=13.0.1-zulu --build-arg MAVEN_VERSION=3.6.2 -t sdkman:mvn-3.6.2-jdk-13.0.1-zulu .

```
