#!/bin/bash
# WizzadV2 Key Generator

KEY_DIR="roles/user_management/files"
KEY_FILE="$KEY_DIR/id_rsa_prod"

echo "🛡️  Security Check..."

mkdir -p "$KEY_DIR"

if [ -f "$KEY_FILE" ]; then
    echo "✅ Key existiert bereits: $KEY_FILE"
else
    echo "🔑 Erstelle neuen Production-Key (wird NICHT nach GitHub geladen)..."
    ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -C "prod-admin" -N ""
    chmod 600 "$KEY_FILE"
    echo "✅ Key erstellt."
fi

echo "ℹ️  Füge diesen Key zu deiner SSH-Agent hinzu (optional):"
echo "   ssh-add $KEY_FILE"
