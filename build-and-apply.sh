#!/usr/bin/env bash
set -euo pipefail

bash render-template.sh
mani=$(cat ".latest_manifest_name")
echo "---"
cat $mani
echo "---"
read -p "I am about to apply the above manifest, press ENTER to continue!" dummy
kubectl apply -f $mani
