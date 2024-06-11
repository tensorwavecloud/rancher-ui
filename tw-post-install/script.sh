#!/bin/sh
# TODO: Uncomment these for SUSE Linux
# sudo zypper refresh
# sudo zypper install jq

# Check if required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <ADMIN_USERNAME> <ADMIN_PASSWORD> <BASE_URL>"
    exit 1
fi

# Assign arguments to variables
ADMIN_USERNAME="$1"
ADMIN_PASSWORD="$2"
BASE_URL="$3"
# TODO: Replace this URL with our helm chart repo
TENSORWAVE_HELM_REPO_URL="https://charts.bitnami.com/bitnami"

LOGIN_RESPONSE=$(curl -k --location "$BASE_URL/v3-public/localProviders/local?action=login" \
--header "Content-Type: application/json" \
--data "{\"username\":\"$ADMIN_USERNAME\", \"password\":\"$ADMIN_PASSWORD\"}")

token=$(echo "$LOGIN_RESPONSE" | jq -r '.token')

curl -k --location "$BASE_URL/v1/catalog.cattle.io.clusterrepos" \
--header "Content-Type: application/json" \
--header "Authorization: Bearer $token" \
--data '{
    "type": "catalog.cattle.io.clusterrepo",
    "metadata": {
        "name": "tensorwave"
    },
    "spec": {
        "url": "'"$TENSORWAVE_HELM_REPO_URL"'",
        "clientSecret": null
    }
}'

curl -k --location --request DELETE "$BASE_URL/v1/catalog.cattle.io.clusterrepos/rancher-partner-charts" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $token"

curl -k --location --request DELETE "$BASE_URL/v1/catalog.cattle.io.clusterrepos/rancher-charts" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $token"

curl -k --location --request DELETE "$BASE_URL/v1/catalog.cattle.io.clusterrepos/rancher-rke2-charts" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $token"