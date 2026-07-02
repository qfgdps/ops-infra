#!/usr/bin/env bash
# ops-01 rolling deploy.
# Usage: ./deploy.sh [ops-01|ops-02]

set -euo pipefail

TARGET="${1:-ops-01}"
NAMESPACE="platform-${TARGET}"
CONFIG_DIR="$(dirname "$0")/config"

if [[ -z "${VAULT_ADDR:-}" ]]; then
  echo "VAULT_ADDR not set — source your ops-shell profile first." >&2
  exit 1
fi

echo "==> Resolving service-account creds from Vault"
SA_PASSWORD=$(vault kv get -field=password "secret/${TARGET}/service-account")
AUTH_TOKEN=$(vault kv get -field=token   "secret/${TARGET}/service-account")

if [[ -z "$SA_PASSWORD" ]] || [[ -z "$AUTH_TOKEN" ]]; then
  echo "Failed to resolve credentials from Vault." >&2
  exit 2
fi

echo "==> Ensuring namespace ${NAMESPACE}"
kubectl apply -f "$(dirname "$0")/../shared/k8s/namespace.yaml"

echo "==> Applying endpoint config"
kubectl -n "${NAMESPACE}" create configmap endpoints \
  --from-file="${CONFIG_DIR}/endpoints.yaml" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "==> Rolling deploy"
kubectl -n "${NAMESPACE}" rollout restart deployment/platform-api
kubectl -n "${NAMESPACE}" rollout status  deployment/platform-api --timeout=5m

echo "==> Deploy complete: ${TARGET}"
