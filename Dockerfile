## STAGE 1: Build ###
FROM node:10.6.0 as builder

SHELL ["/bin/bash", "-c"]

WORKDIR /tmp
COPY . .
# install .net core, azure functions core tools & required bindings
RUN echo "*** --- Updating S.O. and installing azure extension --- ***"
RUN apt-get update && \
    curl -O https://dot.net/v1/dotnet-install.sh && \
    source dotnet-install.sh --channel Current && \
    rm dotnet-install.sh && \
    npm i -g azure-functions-core-tools --unsafe-perm=true && \
    func extensions install && \
    func extensions install --package Microsoft.Azure.WebJobs.Extensions.Storage --version 3.0.3
##RUN npm i

### STAGE 2: functions runtime image ###
FROM mcr.microsoft.com/azure-functions/node:2.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot
RUN echo "*** --- Coping --- ***"
COPY --from=builder /tmp /home/site/wwwroot
##COPY --from=builder . /home/site/wwwroot
RUN echo "*** --- Installing localy --- ***"