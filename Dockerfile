FROM debian:stretch-slim

# Defining default Java and Maven version
ARG JAVA_VERSION="8.0.292.hs-adpt"
ARG MAVEN_VERSION="3.6.2"

# Defining default non-root user UID, GID, and name
ARG USER_UID="1000"
ARG USER_GID="1000"
ARG USER_NAME="jenkins"

# Creating default non-user
RUN groupadd -g $USER_GID $USER_NAME && \
	useradd -m -g $USER_GID -u $USER_UID $USER_NAME

# Installing basic packages
RUN apt-get update && \
	apt-get install -y zip unzip curl apt-transport-https ca-certificates gnupg2 software-properties-common

# jq
RUN apt-get install -y jq
RUN bash -c "jq --version"

# make
RUN apt-get install -y make
RUN bash -c "make --version"

# just
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt update
RUN apt -y install docker-ce docker-ce-cli containerd.io docker-compose


# clean up
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*


#RUN sfagsg



# Switching to non-root user to install SDKMAN!
USER $USER_UID:$USER_GID


# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash

# Installing Java and Maven, removing some unnecessary SDKMAN files
#RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
#    yes | sdk selfupdate && \
#    sdk list java && \
#    yes | sdk install java $JAVA_VERSION && \
#    rm -rf $HOME/.sdkman/archives/* && \
#    rm -rf $HOME/.sdkman/tmp/* "

#RUN bash -c "sdk selfupdate"
#RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
#    yes | sdk install java $JAVA_VERSION && \
#    yes | sdk install maven $MAVEN_VERSION && \
#    rm -rf $HOME/.sdkman/archives/* && \
#    rm -rf $HOME/.sdkman/tmp/*"

# ENTRYPOINT bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && $0 $@" 

#ENV MAVEN_HOME="/home/jenkins/.sdkman/candidates/maven/current"
#ENV JAVA_HOME="/home/jenkins/.sdkman/candidates/java/current"
#ENV PATH="$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"


