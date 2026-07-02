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
