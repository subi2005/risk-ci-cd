#!/usr/bin/env bash
set -euo pipefail

if systemctl list-unit-files | grep -q "risk-backend.service"; then
  systemctl stop risk-backend.service || true
fi
