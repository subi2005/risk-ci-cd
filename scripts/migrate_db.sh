#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="/srv/risk-backend"
cd "$APP_ROOT"
source .venv/bin/activate

# run lightweight DB init using your SQLAlchemy Base (creates tables if not exist)
# assumes backend/main.py imports Base and engine
python - <<'PYCODE'
from backend.database import Base, engine
Base.metadata.create_all(bind=engine)
print("DB migration/creation completed.")
PYCODE
