# see: https://github.com/casey/just

# list tasks
default:
  @just --list

# build java 8 image (8.0.292.hs-adpt)
docker-build-java8:
   docker build --build-arg SDK_JAVA_VERSION=8.0.292.hs-adpt -t ci-jvm-build-tools:java-8 .

# build java 11 image (11.0.11.hs-adpt)
docker-build-java11:
   docker build --build-arg SDK_JAVA_VERSION=11.0.11.hs-adpt -t ci-jvm-build-tools:java-11 .
