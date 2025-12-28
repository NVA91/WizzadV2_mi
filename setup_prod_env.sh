#!/bin/bash
# WizzadV2 Production Environment Setup

echo "🏗️  Starte Vorbereitung für Produktions-Umgebung..."

# 1. Verzeichnisstruktur prüfen
KEY_DIR="roles/user_management/files"
if [ ! -d "$KEY_DIR" ]; then
    echo "📂 Erstelle Verzeichnis: $KEY_DIR"
    mkdir -p "$KEY_DIR"
fi

# 2. SSH Key Management
KEY_FILE="$KEY_DIR/id_rsa_prod"

if [ -f "$KEY_FILE" ]; then
    echo "✅ Produktions-Key existiert bereits: $KEY_FILE"
    echo "   (Wir nutzen diesen weiter, um nichts zu überschreiben)"
else
    echo "🔑 Generiere neuen SSH-Key für das Produktions-System..."
    # Generiert einen neuen RSA Key (4096 bit) ohne Passphrase
    ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -C "admin@gmtec-k12-prod" -N ""
    
    echo "✅ Neuer Key erstellt!"
    echo "   Public Key: $KEY_FILE.pub"
    echo "   Private Key: $KEY_FILE"
fi

# 3. Berechtigungen fixen
chmod 600 "$KEY_FILE"
chmod 644 "$KEY_FILE.pub"

echo "-----------------------------------------------------------"
echo "🎉 Vorbereitung abgeschlossen!"
echo "-----------------------------------------------------------"
echo "NÄCHSTE SCHRITTE (Tag X):"
echo "1. Installiere Proxmox auf dem GMtec K12."
echo "2. Kopiere diesen Public Key auf den Server:"
echo "   ssh-copy-id -i $KEY_FILE.pub root@<NEUE-IP>"
echo "3. Starte den Ansible Wizard:"
echo "   ansible-playbook site.yml -i inventory/hosts.yml"
echo "-----------------------------------------------------------"
