FROM debian:buster-slim 

COPY --from=ghcr.io/gnosischain/gbc-prysm-beacon-chain:v2.1.1-gbc /app/cmd/beacon-chain/beacon-chain /usr/local/bin/beacon-chain

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && \
  apt install -y ca-certificates file && \
  rm -rf /var/lib/apt/lists/* \
  chmod +x /usr/local/bin/entrypoint.sh 

COPY /config/bootnodes.yaml /root/sbc/config/
COPY /config/config.yml /root/sbc/config/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
