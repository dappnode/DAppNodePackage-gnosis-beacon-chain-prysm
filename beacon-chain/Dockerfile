FROM debian:buster-slim 

COPY --from=ghcr.io/gnosischain/gbc-prysm-beacon-chain:v2.0.4-gbc /app/cmd/beacon-chain/beacon-chain /usr/local/bin/beacon-chain

RUN apt-get update && apt-get install -y ca-certificates

COPY /config/bootnodes.yaml /root/sbc/config/
COPY /config/config.yml /root/sbc/config/

ENTRYPOINT [ "sh", "-c", "exec beacon-chain \ 
    --datadir=/data \
    --accept-terms-of-use \
    --contract-deployment-block=\"$DEPLOYMENT_BLOCK\" \
    --http-web3provider=\"$XDAI_RPC_URL\" \
    --bootstrap-node /root/sbc/config/bootnodes.yaml \
    --config-file /root/sbc/config/config.yml \
    --chain-config-file /root/sbc/config/config.yml \
    --rpc-host=0.0.0.0 \
    --p2p-local-ip=0.0.0.0 \
    --subscribe-all-subnets \
    --monitoring-host=0.0.0.0 \
    $EXTRA_OPTS" ]   

