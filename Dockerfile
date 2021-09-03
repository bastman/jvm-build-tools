FROM debian:stretch-slim

# define default build args
ARG SDK_JAVA_VERSION="8.0.292.hs-adpt"

# Defining default non-root user UID, GID, and name
#ARG USER_UID="1000"
#ARG USER_GID="1000"
#ARG USER_NAME="jenkins"

# Creating default non-user
#RUN groupadd -g $USER_GID $USER_NAME && \
#	useradd -m -g $USER_GID -u $USER_UID $USER_NAME

# Switching to non-root user
#USER $USER_UID:$USER_GID

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

# sdkman: download
RUN curl -s "https://get.sdkman.io" | bash
RUN echo "sdkman_auto_answer=true" > /root/.sdkman/etc/config && \
    echo "sdkman_selfupdate_enable=false" >> /root/.sdkman/etc/config && \
    echo "sdkman_auto_env=false" >> /root/.sdkman/etc/config && \
    echo "sdkman_insecure_ssl=true" >> /root/.sdkman/etc/config
# sdkman: Installing Java and Maven, removing some unnecessary SDKMAN files
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk selfupdate && \

    sdk list java && \
    yes | sdk install java $SDK_JAVA_VERSION" \

RUN java -version

# sdkman: cleanup
RUN bash -c "rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/* "

# entrypoint: init sdkman
ENTRYPOINT bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && $0 $@"




