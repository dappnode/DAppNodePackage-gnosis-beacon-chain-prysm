FROM debian:bullseye-slim as builder

WORKDIR /usr/src/app
RUN apt update && apt install curl && \
  curl https://github.com/gnosischain/prysm-launch/blob/master/config/bootnodes.yaml -o bootnodes.yaml && \
  curl https://github.com/gnosischain/prysm-launch/blob/master/config/config.yml -o config.yml

FROM debian:bullseye-slim 

COPY --from=ghcr.io/gnosischain/gbc-prysm-beacon-chain:v2.1.1-gbc /app/cmd/beacon-chain/beacon-chain /usr/local/bin/beacon-chain

RUN apt update && \
  apt install -y ca-certificates file && \
  rm -rf /var/lib/apt/lists/*

# Prysm launch gnosis config: https://github.com/gnosischain/prysm-launch/tree/master/config
COPY --from=builder /usr/src/app/bootnodes.yaml /root/sbc/config/
COPY --from=builder /usr/src/app/config.yml /root/sbc/config/

ENTRYPOINT [ "sh", "-c", "exec beacon-chain \ 
  --datadir=/data \
  --rpc-host=0.0.0.0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --p2p-local-ip=0.0.0.0 \
  --http-web3provider=\"$XDAI_RPC_URL\" \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain=\"$CORSDOMAIN\" \
  --accept-terms-of-use \
  --contract-deployment-block=\"$DEPLOYMENT_BLOCK\" \
  --bootstrap-node /root/sbc/config/bootnodes.yaml \
  --config-file /root/sbc/config/config.yml \
  --chain-config-file /root/sbc/config/config.yml \
  $EXTRA_OPTS" ]
