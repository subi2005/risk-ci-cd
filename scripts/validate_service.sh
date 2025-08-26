#!/usr/bin/env bash
set -euo pipefail

HEALTH_URL="http://localhost:8000/"
for i in {1..20}; do
  if curl -fsS "${HEALTH_URL}" | grep -qi "Backend is running"; then
    echo "Health check passed."
    exit 0
  fi
  echo "Waiting for service... ($i/20)"
  sleep 3
done

echo "Health check failed."
exit 1
