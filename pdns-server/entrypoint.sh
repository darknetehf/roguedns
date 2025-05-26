#!/usr/bin/env sh

POWER_DNS_DB_FILE="/data/pdns.db"

if [ -z ${PDNS_API_KEY+x} ]; then
    API_KEY=changeme
fi

if [ -z ${PDNS_PORT+x} ]; then
    WEB_PORT=8081
fi

# Create an empty DB if it does not already exist
if ! [ -f "${POWER_DNS_DB_FILE}" ]; then
    echo "DB ${POWER_DNS_DB_FILE} does not exist -> create"
    sqlite3 "${POWER_DNS_DB_FILE}" < /usr/share/doc/pdns-backend-sqlite3/schema.sqlite3.sql
    chown pdns:pdns "${POWER_DNS_DB_FILE}"
fi

/usr/sbin/pdns_server --launch=gsqlite3 --gsqlite3-database="${POWER_DNS_DB_FILE}" \
    --webserver=yes --webserver-address=0.0.0.0 --webserver-port="${PDNS_PORT}" \
    --api=yes --api-key="${PDNS_API_KEY}" --webserver-allow-from="${PDNS_WEBSERVER_ALLOW_FROM}"
