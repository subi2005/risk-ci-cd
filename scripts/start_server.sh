#!/usr/bin/env bash
set -euo pipefail

# enable + start systemd service
systemctl enable risk-backend.service
systemctl restart risk-backend.service
systemctl status risk-backend.service --no-pager || true
