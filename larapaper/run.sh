#!/bin/sh
set -e

OPTIONS=/data/options.json

# ── Read options ──────────────────────────────────────────────────────────────
APP_URL=$(jq --raw-output '.app_url' "${OPTIONS}")
APP_TIMEZONE=$(jq --raw-output '.app_timezone' "${OPTIONS}")
REGISTRATION_ENABLED=$(jq --raw-output '.registration_enabled' "${OPTIONS}")
LOG_LEVEL=$(jq --raw-output '.log_level' "${OPTIONS}")
PHP_MEMORY_LIMIT=$(jq --raw-output '.php_memory_limit' "${OPTIONS}")
PHP_FPM_PM_MAX_CHILDREN=$(jq --raw-output '.php_fpm_pm_max_children' "${OPTIONS}")
PHP_FPM_PM_MAX_SPARE_SERVERS=$(jq --raw-output '.php_fpm_pm_max_spare_servers' "${OPTIONS}")
TRMNL_PROXY_BASE_URL=$(jq --raw-output '.trmnl_proxy_base_url' "${OPTIONS}")
TRMNL_PROXY_REFRESH_MINUTES=$(jq --raw-output '.trmnl_proxy_refresh_minutes' "${OPTIONS}")

# Convert JSON bool to integer
[ "${REGISTRATION_ENABLED}" = "true" ] && REGISTRATION_ENABLED=1 || REGISTRATION_ENABLED=0

# ── Persistent APP_KEY ────────────────────────────────────────────────────────
if [ ! -f /data/app_key ]; then
    echo "[larapaper] Generating APP_KEY..."
    php -r "echo 'base64:'.base64_encode(random_bytes(32));" > /data/app_key
fi
APP_KEY=$(cat /data/app_key)

# ── Persistent SQLite database ────────────────────────────────────────────────
DB_PATH=/var/www/html/database/database.sqlite

if [ ! -f /data/database.sqlite ]; then
    echo "[larapaper] Initializing database..."
    [ -f "${DB_PATH}" ] && cp "${DB_PATH}" /data/database.sqlite || touch /data/database.sqlite
fi

rm -f "${DB_PATH}"
ln -sf /data/database.sqlite "${DB_PATH}"
chown www-data:www-data /data/database.sqlite

# ── Export environment ────────────────────────────────────────────────────────
export APP_ENV=production
export APP_DEBUG=false
export APP_NAME=LaraPaper
export APP_KEY="${APP_KEY}"
export APP_URL="${APP_URL}"
export APP_TIMEZONE="${APP_TIMEZONE}"
export REGISTRATION_ENABLED="${REGISTRATION_ENABLED}"
export LOG_LEVEL="${LOG_LEVEL}"
export TRUSTED_PROXIES="*"
export FORCE_HTTPS=0
export PHP_OPCACHE_ENABLE=1
export PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT}"
export PHP_FPM_PM_CONTROL=ondemand
export PHP_FPM_PM_MAX_CHILDREN="${PHP_FPM_PM_MAX_CHILDREN}"
export PHP_FPM_PM_START_SERVERS=1
export PHP_FPM_PM_MIN_SPARE_SERVERS=1
export PHP_FPM_PM_MAX_SPARE_SERVERS="${PHP_FPM_PM_MAX_SPARE_SERVERS}"
export TRMNL_PROXY_BASE_URL="${TRMNL_PROXY_BASE_URL}"
export TRMNL_PROXY_REFRESH_MINUTES="${TRMNL_PROXY_REFRESH_MINUTES}"
export AUTORUN_ENABLED=true
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
export PUPPETEER_DOCKER=1

echo "[larapaper] Starting (url=${APP_URL}, fpm_max=${PHP_FPM_PM_MAX_CHILDREN})..."
exec docker-php-serversideup-entrypoint /init
