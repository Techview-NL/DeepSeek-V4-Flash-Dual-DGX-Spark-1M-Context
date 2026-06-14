#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="/home/zurih/models/spark/DeepSeek-V4-Flash"
WORKER_HOST="169.254.122.228"

cd "$MODEL_DIR"

echo "Stopping head on spark1..."
docker compose down || true

echo "Stopping worker on spark2..."
ssh "$WORKER_HOST" "cd '$MODEL_DIR' && docker compose down" || true

echo "DeepSeek V4 Flash stopped."
