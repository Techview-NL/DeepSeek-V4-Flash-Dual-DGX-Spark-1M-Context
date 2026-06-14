#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Change context size to 1000000 and GPU memory utilization to 0.8253
sed -i 's/--max-model-len [0-9]*/--max-model-len 1000000/' docker-compose.yml
sed -i 's/--gpu-memory-utilization [0-9.]*/--gpu-memory-utilization 0.8253/' docker-compose.yml

echo "ctx=1000000, gpu-memory-utilization=0.8253"
