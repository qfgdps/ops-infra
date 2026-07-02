# ops-infra
Internal — Quennarith Financial Group platform-ops mono-repo (ops-01/ops-02, deployment scripts, service configs). Do not fork.

# ops-infra

Platform-operations mono-repo for Quennarith Financial Group.
Covers ops-01, ops-02, and shared tooling for prod / pre-prod deployments.

## Layout

- `ops-01/` — primary production ops (VPN, SSO, API gateway)
- `ops-02/` — read replica / DR site
- `shared/` — deploy scripts, CI helpers, k8s manifests

## Access

Contact `#platform-ops` (Slack) or `svc-ops@quennarith.com` for access
to the corresponding vault entries. Do NOT commit secrets — see `.gitignore`.

## Deploy

See `ops-01/README.md` for the standard deploy flow. Rotation cadence
for the corp cluster is 90 days; see runbook link in Confluence.

Last reviewed: 2026-Q1
