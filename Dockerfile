FROM google/cloud-sdk:latest

RUN mkdir -p /src
WORKDIR /src

RUN apt-get install kubectl
RUN apt-get install -y jq
RUN curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.11 > asmcli
RUN chmod +x asmcli

ENTRYPOINT bash