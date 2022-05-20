##############
# Base image #
##############
ARG UPSTREAM_VERSION
FROM ghcr.io/gnosischain/gbc-prysm-validator:${UPSTREAM_VERSION}-gbc as base

################
# Config image #
################
FROM debian:bullseye-slim as config

WORKDIR /usr/src/app
RUN apt update && apt install curl --yes && \
    curl https://raw.githubusercontent.com/gnosischain/prysm-launch/master/config/bootnodes.yaml -o bootnodes.yaml && \
    curl https://raw.githubusercontent.com/gnosischain/prysm-launch/master/config/config.yml -o config.yml

################
# Runner image #
################
FROM debian:bullseye-slim 

RUN apt-get update && apt-get install -y ca-certificates file curl && \
    rm -rf /var/lib/apt/lists/*

# Get the binary from the base image
COPY --from=base /app/cmd/validator/validator.runfiles/prysm/cmd/validator/validator_/validator /usr/local/bin/validator

# Prysm launch gnosis config: https://github.com/gnosischain/prysm-launch/tree/master/config
COPY --from=config /usr/src/app/bootnodes.yaml /root/sbc/config/
COPY --from=config /usr/src/app/config.yml /root/sbc/config/

# Prysm scripts
COPY auth-token /auth-token
COPY eth2-migrate.sh /usr/local/bin
COPY entrypoint.sh /usr/local/bin


RUN chmod +x /usr/local/bin/validator && \
    chmod +x /usr/local/bin/entrypoint.sh 

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
