# ops-infra

Platform-operations mono-repo for Quennarith Financial Group.
Covers ops-01, ops-02, and shared tooling for prod / pre-prod deployments.

## Layout

- `ops-01/` — primary production ops (VPN, SSO, API gateway)
- `ops-02/` — read replica / DR site (stub, migrating to k3s)
- `shared/` — deploy scripts, CI helpers, k8s manifests

## Access

Contact `#platform-ops` (Slack) or the platform-ops on-call rota for
access to the corresponding vault entries. Do NOT commit secrets — see
`.gitignore`. All service-account credentials live in HashiCorp Vault
under `secret/data/ops-01/*`.

## Deploy

See `ops-01/README.md` for the standard deploy flow. Rotation cadence
for the corp cluster is 90 days; runbook link is in the platform-ops
Confluence space.

## Support

Repo owner: platform-ops
Slack: #platform-ops
Runbooks: internal Confluence

Last reviewed: 2026-Q1
