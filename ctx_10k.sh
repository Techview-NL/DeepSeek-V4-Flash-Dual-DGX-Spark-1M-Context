#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Change context size to 10000 and GPU memory utilization to 0.25
sed -i 's/--max-model-len [0-9]*/--max-model-len 10000/' docker-compose.yml
sed -i 's/--gpu-memory-utilization [0-9.]*/--gpu-memory-utilization 0.25/' docker-compose.yml

echo "ctx=10000, gpu-memory-utilization=0.25"
