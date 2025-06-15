#!/bin/bash

set -e

CERT_DIR="./certs"
DAYS_VALID=365
COMMON_NAME="localhost"

mkdir -p "$CERT_DIR"

echo "🔐 Generating self-signed certificate for CN=$COMMON_NAME..."

openssl req -x509 -nodes -newkey rsa:4096 \
  -keyout "$CERT_DIR/key.pem" \
  -out "$CERT_DIR/cert.pem" \
  -sha256 \
  -days $DAYS_VALID \
  -subj "/CN=$COMMON_NAME" \
  -addext "subjectAltName=DNS:$COMMON_NAME,IP:127.0.0.1,DNS:grafana,DNS:tempo"

echo "✅ Certificate generated at:"
echo "  - $CERT_DIR/cert.pem"
echo "  - $CERT_DIR/key.pem"

chmod 0644 $CERT_DIR/key.pem
chmod 0644 $CERT_DIR/cert.pem
