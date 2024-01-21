#!/usr/bin/env bash
set -euo pipefail

### These three cannot have spaces in the value!

SERVER_NAME="world123" # Public server name
SERVER_PASSWORD="password"
ADMIN_PASSWORD="password2"

### Maybe change these?

NAMESPACE_NAME="palworld"
DEPLOYMENT_NAME="palworld"
STORAGE_SIZE="5Gi"

### Don't change below this line

TS=$(date +%s)
mani="manifest-$TS.yml"
cp manifest.tpl manifest-$TS.yml

sed -i "s/__NAMESPACE_NAME__/$NAMESPACE_NAME/g" $mani
sed -i "s/__DEPLOYMENT_NAME__/$DEPLOYMENT_NAME/g" $mani
sed -i "s/__STORAGE_SIZE__/$STORAGE_SIZE/g" $mani
sed -i "s/__SERVER_NAME__/$SERVER_NAME/g" $mani
sed -i "s/__SERVER_PASSWORD__/$SERVER_PASSWORD/g" $mani
sed -i "s/__ADMIN_PASSWORD__/$ADMIN_PASSWORD/g" $mani

echo "$mani" > .latest_manifest_name