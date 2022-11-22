#!/bin/bash

if [[ -n $CHECKPOINT_SYNC_URL ]]; then
  EXTRA_OPTS="--checkpoint-sync-url=${CHECKPOINT_SYNC_URL} --genesis-beacon-api-url=${CHECKPOINT_SYNC_URL} ${EXTRA_OPTS}"
else
  EXTRA_OPTS="--genesis-state=/genesis.ssz ${EXTRA_OPTS}"
fi

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS in
"nethermind-xdai.dnp.dappnode.eth")
  HTTP_ENGINE="http://nethermind-xdai.dappnode:8551"
  ;;
"erigon-gnosis.dnp.dappnode.eth")
  HTTP_ENGINE="http://erigon-gnosis.dappnode:8551"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS"
  HTTP_ENGINE=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS
  ;;
esac

exec -c beacon-chain \
  --datadir=/data \
  --rpc-host=0.0.0.0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --p2p-local-ip=0.0.0.0 \
  --p2p-tcp-port=$P2P_TCP_PORT \
  --p2p-udp-port=$P2P_UDP_PORT \
  --http-web3provider=$HTTP_WEB3PROVIDER \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain=$CORSDOMAIN \
  --accept-terms-of-use \
  --contract-deployment-block=$DEPLOYMENT_BLOCK \
  --bootstrap-node /root/sbc/config/bootnodes.yaml \
  --config-file /root/sbc/config/config.yml \
  --chain-config-file /root/sbc/config/config.yml \
  --execution-endpoint=$HTTP_ENGINE \
  --jwt-secret=/jwtsecret \
  $EXTRA_OPTS