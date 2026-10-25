#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v xcodegen >/dev/null 2>&1 || { echo "Installa XcodeGen: brew install xcodegen" >&2; exit 127; }
xcodegen generate --spec project.yml
