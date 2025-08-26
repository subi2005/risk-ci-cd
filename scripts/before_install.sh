#!/usr/bin/env bash
set -euo pipefail

# stop existing service if present
if systemctl list-unit-files | grep -q "risk-backend.service"; then
  systemctl stop risk-backend.service || true
fi

# create application directory if missing
mkdir -p /srv/risk-backend

# ensure required rpm packages
yum update -y || true
yum install -y python3 python3-pip python3-venv jq curl git || true
