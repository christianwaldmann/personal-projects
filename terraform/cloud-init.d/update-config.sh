#!/usr/bin/env bash
set -euo pipefail

SSM_VARS=(
    BOOKMARKS_FRONTEND_DOMAIN BOOKMARKS_FRONTEND_BASE_URL BOOKMARKS_GITHUB_LINK BOOKMARKS_STATUS_LINK BOOKMARKS_API_DOCS_LINK BOOKMARKS_SECRET_KEY
    BOOKMARKS_BACKEND_DOMAIN BOOKMARKS_BACKEND_BASE_URL
    GEOMETRIERECHNER_DOMAIN GEOMETRIERECHNER_DEPLOYMENT_ENV GEOMETRIERECHNER_URL GEOMETRIERECHNER_SOURCE_CODE_URL GEOMETRIERECHNER_UMAMI_TRACKING_LINK GEOMETRIERECHNER_UMAMI_TRACKING_CODE
    STORAGEBOX_USERNAME STORAGEBOX_HOSTNAME
)

mkdir -p /app
chmod 0777 /app

function get_ssm_parameters {
    prefix="personal-projects"
    params=()
    for env_name in "$@"; do
        ssm_name=$${prefix}-$${env_name}
        ssm_name=$${ssm_name//_/-}
        ssm_name=$${ssm_name,,}
        params+=("$${ssm_name}")
    done

    output=$(xargs --max-args=10 --no-run-if-empty aws ssm get-parameters --region eu-central-1 --with-decryption --query "Parameters[].{Name: Name, Value: Value}" --names <<<"$${params[@]//,/}")

    if [[ "x$${output}" == "x" ]]; then
        echo "Could not fetch ssm parameters $${SSM_VARS}"
        exit 1
    fi

    for env_name in "$@"; do
        ssm_name=$${prefix}-$${env_name}
        ssm_name=$${ssm_name//_/-}
        ssm_name=$${ssm_name,,}

        env_value="$(echo $${output} | jq -r ".[] | select(.Name==\"$${ssm_name}\").Value")"
        if ! grep -q "$${env_name}}=" "/app/.env"; then
            echo $${env_name}="$${env_value}" >> "/app/.env"
        else
            sed -i "s/$${env_name}}=.*/$${env_name}}=$${env_value}}/g" "/app/.env"
        fi
    done
}

get_ssm_parameters "$${SSM_VARS[@]}"

if [ -f docker-compose.yaml ]; then
    docker-compose up -d
fi
