#!/bin/bash

[[ -n $WEB3_BACKUP ]] && EXTRA_OPTS="--fallback-web3provider=${WEB3_BACKUP} ${EXTRA_OPTS}"
if [[ -n $CHECKPOINT_SYNC_URL ]]; then
  EXTRA_OPTS="--checkpoint-sync-url=${CHECKPOINT_SYNC_URL} --genesis-beacon-api-url=${CHECKPOINT_SYNC_URL}"
fi

exec -c beacon-chain \
  --datadir=/data \
  --rpc-host=0.0.0.0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --p2p-local-ip=0.0.0.0 \
  --http-web3provider=$XDAI_RPC_URL \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain=$CORSDOMAIN \
  --accept-terms-of-use \
  --contract-deployment-block=$DEPLOYMENT_BLOCK \
  --bootstrap-node /root/sbc/config/bootnodes.yaml \
  --config-file /root/sbc/config/config.yml \
  --chain-config-file /root/sbc/config/config.yml \
  $EXTRA_OPTS
