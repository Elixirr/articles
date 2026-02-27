#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

npx skills add https://github.com/froessell/app-store-opportunity-research --skill app-store-opportunity-research --yes
