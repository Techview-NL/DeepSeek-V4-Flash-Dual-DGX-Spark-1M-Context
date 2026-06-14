#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="/home/zurih/models/spark/DeepSeek-V4-Flash"
WORKER_HOST="169.254.122.228"
API_URL="http://127.0.0.1:8888/v1/models"

cd "$MODEL_DIR"

echo "Starting worker on spark2..."
ssh "$WORKER_HOST" "cd '$MODEL_DIR' && docker compose up -d"

echo "Starting head on spark1..."
docker compose up -d

echo "Waiting for vLLM API..."
for _ in $(seq 1 80); do
  if curl -fsS --max-time 5 "$API_URL" >/dev/null; then
    echo "DeepSeek V4 Flash is running: $API_URL"
    docker compose ps
    ssh "$WORKER_HOST" "cd '$MODEL_DIR' && docker compose ps"
    exit 0
  fi
  sleep 15
done

echo "Timed out waiting for API. Recent spark1 logs:"
docker logs --tail=120 deepseek-v4-flash-vllm-1 2>&1 || true
echo "Recent spark2 logs:"
ssh "$WORKER_HOST" "docker logs --tail=120 deepseek-v4-flash-vllm-1 2>&1" || true
exit 1
