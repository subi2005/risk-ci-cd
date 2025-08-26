#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="/srv/risk-backend"
cd "$APP_ROOT"

# python virtualenv
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip

# install app deps
pip install -r requirements.txt

# ensure uvicorn is present for serving FastAPI
pip install uvicorn[standard]

# (optional) extras commonly needed
pip install gunicorn

# place systemd unit
sudo cp ci_cd/systemd/risk-backend.service /etc/systemd/system/risk-backend.service
sudo systemctl daemon-reload

# create a .env from SSM if needed (safe pattern)
# Uncomment and adapt if you store secrets in Parameter Store
# DB_URL=$(aws ssm get-parameter --name "/risk-app/DATABASE_URL" --with-decryption --query "Parameter.Value" --output text || echo "")
# echo "DATABASE_URL=${DB_URL}" > .env
