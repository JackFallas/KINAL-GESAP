#!/bin/bash
set -e

echo "=== KINAL-GESAP Deploy ==="

git pull --recurse-submodules
git submodule update --init --recursive

echo "→ Backend..."
docker compose up -d --build

for dir in client-kinal-alumno client-kinal-enfermero client-kinal-admin; do
  echo "→ $dir..."
  cd $dir && npm ci && npm run build && cd ..
done

echo "=== Deploy completo ==="
