FROM debian:buster-slim 

# Get the binary from the image and configuration files
COPY --from=ghcr.io/openethereum/sbc-prysm-validator:v2.0.4-sbc /app/cmd/* /usr/local/bin/validator/

RUN apt-get update && apt-get install -y wget

COPY /config/bootnodes.yaml /root/sbc/config/
COPY /config/config.yml /root/sbc/config/

ENTRYPOINT [ "sh", "-c", "exec /usr/local/bin/validator/validator.runfiles/prysm/cmd/validator/validator_/validator \
    --datadir=/root/.eth2 \
    --rpc-host 0.0.0.0 \
    --monitoring-host 0.0.0.0 \
    --beacon-rpc-provider=\"$BEACON_RPC_PROVIDER\" \
    --beacon-rpc-gateway-provider=\"$BEACON_RPC_GATEWAY_PROVIDER\" \
    --wallet-dir=/root/.eth2validators \
    --config-file /root/sbc/config/config.yml \
    --chain-config-file /root/sbc/config/config.yml \
    --wallet-password-file /root/.eth2wallets/wallet-password.txt \
    --write-wallet-password-on-web-onboarding \
    --web \
    --grpc-gateway-host=0.0.0.0 \
    --grpc-gateway-port=80 \
    --accept-terms-of-use \
    $EXTRA_OPTS"]