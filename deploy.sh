#!/bin/bash
set -e

DEST=/var/www/gesap-kinal

echo "=== KINAL-GESAP Deploy ==="

git pull --recurse-submodules
git submodule update --init --recursive

echo "→ Backend..."
docker compose up -d --build

for dir in client-kinal-alumno client-kinal-enfermero client-kinal-admin; do
  echo "→ $dir..."
  cd $dir && npm ci && npm run build && cd ..
done

mkdir -p $DEST/client-alumno $DEST/client-enfermero $DEST/client-admin
cp -r client-kinal-alumno/dist/.    $DEST/client-alumno/
cp -r client-kinal-enfermero/dist/. $DEST/client-enfermero/
cp -r client-kinal-admin/dist/.     $DEST/client-admin/

echo "=== Deploy completo ==="
