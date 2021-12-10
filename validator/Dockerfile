
FROM debian:buster-slim 

# Get the binary from the image and configuration files
COPY --from=ghcr.io/gnosischain/gbc-prysm-validator:v2.0.4-gbc /app/cmd/validator/validator.runfiles/prysm/cmd/validator/validator_/validator /usr/local/bin/validator

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin

RUN apt-get update && apt-get install -y ca-certificates curl &&  \
    chmod +x /usr/local/bin/validator && \
    chmod +x /usr/local/bin/entrypoint.sh

COPY /config/bootnodes.yaml /root/sbc/config/
COPY /config/config.yml /root/sbc/config/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]