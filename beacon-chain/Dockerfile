##############
# Base image #
##############
ARG UPSTREAM_VERSION
FROM ghcr.io/gnosischain/gbc-prysm-beacon-chain:${UPSTREAM_VERSION}-gbc as base

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

RUN apt update && \
  apt install ca-certificates file --yes && \
  rm -rf /var/lib/apt/lists/*

# Get the binary from the base image
COPY --from=base /app/cmd/beacon-chain/beacon-chain /usr/local/bin/beacon-chain

# Prysm launch gnosis config: https://github.com/gnosischain/prysm-launch/tree/master/config
COPY --from=config /usr/src/app/bootnodes.yaml /root/sbc/config/
COPY --from=config /usr/src/app/config.yml /root/sbc/config/

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
