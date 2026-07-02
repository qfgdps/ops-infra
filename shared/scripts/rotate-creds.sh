#!/usr/bin/env bash
# 90-day rotation ceremony for platform-ops service accounts.
# Run per environment: ./rotate-creds.sh ops-01

set -euo pipefail

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 <ops-01|ops-02>" >&2
  exit 1
fi

VAULT_PATH="secret/${TARGET}/service-account"

echo "==> Generating new service-account credential in Vault"
vault write "${VAULT_PATH}/rotate" -force

echo "==> Waiting for Vault to propagate"
sleep 5

echo "==> Restarting API pods to pick up new creds"
kubectl -n "platform-${TARGET}" rollout restart deployment/platform-api
kubectl -n "platform-${TARGET}" rollout status  deployment/platform-api --timeout=5m

echo "==> Rotation complete for ${TARGET}. Confirm alerts channel: #platform-ops-alerts"
