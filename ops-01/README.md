# ops-01

Primary production ops for Quennarith Financial Group's platform stack.
Owns the VPN concentrator, SSO portal, and public REST API gateway.

## Services

| Service | Host                  | Role                          |
| ------- | --------------------- | ----------------------------- |
| VPN     | vpn.quennarith.com    | Corp VPN concentrator         |
| SSO     | login.quennarith.com  | Okta SAML relay + MFA         |
| API     | api.quennarith.com    | External REST endpoint        |

See `config/endpoints.yaml` for full config.

## Deploy

./deploy.sh


The script pulls the current release manifest, resolves the service-account
credentials from Vault (`secret/data/ops-01/service-account`), applies the
k8s namespace from `shared/k8s/namespace.yaml`, and runs the rolling deploy.

Rotation cadence: 90 days. `rotate-creds.sh` handles the ceremony.

## Runbooks

Standard incidents (SSO down, VPN saturated, API 5xx rate spike) — see
platform-ops Confluence space. On-call is paged via PagerDuty for any
priority ≤ 3.
