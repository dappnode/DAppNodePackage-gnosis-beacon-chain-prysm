#!/bin/bash

CLIENT="prysm"
export NETWORK="gnosis"
VALIDATOR_PORT=3500
export WEB3SIGNER_API="http://web3signer.web3signer-${NETWORK}.dappnode:9000"
export WALLET_DIR="/root/.eth2validators"

# Copy auth-token in runtime to the prysm token dir
mkdir -p ${WALLET_DIR}
cp /auth-token ${WALLET_DIR}/auth-token

# Migrate if required
if [[ $(validator accounts list \
    --wallet-dir="$WALLET_DIR" \
    --wallet-password-file="${WALLET_DIR}/walletpassword.txt" \
    --accept-terms-of-use) ]]; then
    {
        echo "found validators, starging migration"
        eth2-migrate.sh &
        wait $!
    }
else
    { echo "validators not found, no migration needed"; }
fi

# Remove manual migration if older than 20 days
find /root -type d -name manual_migration -mtime +20 -exec rm -rf {} +

exec -c validator \
    --datadir="$WALLET_DIR" \
    --config-file /root/sbc/config/config.yml \
    --chain-config-file /root/sbc/config/config.yml \
    --wallet-dir="$WALLET_DIR" \
    --monitoring-host 0.0.0.0 \
    --beacon-rpc-provider="$BEACON_RPC_PROVIDER" \
    --beacon-rpc-gateway-provider="$BEACON_RPC_GATEWAY_PROVIDER" \
    --validators-external-signer-url="$WEB3SIGNER_API" \
    --grpc-gateway-host=0.0.0.0 \
    --grpc-gateway-port="$VALIDATOR_PORT" \
    --grpc-gateway-corsdomain=http://0.0.0.0:"$VALIDATOR_PORT" \
    --graffiti="$GRAFFITI" \
    --suggested-fee-recipient="${FEE_RECIPIENT_ADDRESS}" \
    --web \
    --accept-terms-of-use \
    --enable-doppelganger \
    ${EXTRA_OPTS}
