
FROM debian:bullseye-slim as builder

WORKDIR /usr/src/app
RUN apt update && apt install curl && \
    curl https://github.com/gnosischain/prysm-launch/blob/master/config/bootnodes.yaml -o bootnodes.yaml && \
    curl https://github.com/gnosischain/prysm-launch/blob/master/config/config.yml -o config.yml

FROM debian:bullseye-slim 

ARG UPSTREAM_VERSION
# Get the binary from the image and configuration files
COPY --from=ghcr.io/gnosischain/gbc-prysm-validator:${UPSTREAM_VERSION} /app/cmd/validator/validator.runfiles/prysm/cmd/validator/validator_/validator /usr/local/bin/validator

# Prysm launch gnosis config: https://github.com/gnosischain/prysm-launch/tree/master/config
COPY --from=builder /usr/src/app/bootnodes.yaml /root/sbc/config/
COPY --from=builder /usr/src/app/config.yml /root/sbc/config/

# Prysm scripts
COPY auth-token /root/.eth2validators/auth-token
COPY eth2-migrate.sh /usr/local/bin
COPY entrypoint.sh /usr/local/bin

RUN apt-get update && apt-get install -y ca-certificates file curl &&  \
    chmod +x /usr/local/bin/validator && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
