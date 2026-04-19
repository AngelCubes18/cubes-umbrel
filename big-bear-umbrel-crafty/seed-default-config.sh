#!/bin/sh
set -eu
python3 - <<'PY'
import json, os
from pathlib import Path

# Write to the location the app copies FROM on first boot
default_json = Path("/app/config_original/default.json")
app_password = os.environ.get("APP_PASSWORD")

if app_password and default_json.exists():
    default_json.write_text(
        json.dumps({"username": "admin", "password": app_password}, indent=2) + "\n",
        encoding="utf-8",
    )
PY
exec /app/docker_launcher.sh "$@"
