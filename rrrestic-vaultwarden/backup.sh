#!/bin/sh

TARGET_DIR="/target"
DB_FILE="${TARGET_DIR}/db.sqlite3"

BACKUP_DIR="/backup"
BACKUP_FILE_DB_SQLITE="${BACKUP_DIR}/db.sqlite3.bak"

function backup_db_sqlite() {
    color blue "backup vaultwarden sqlite database"

    if [[ -f "${DB_FILE}" ]]; then
        sqlite3 "${DB_FILE}" ".backup '${BACKUP_FILE_DB_SQLITE}'"
    else
        color yellow "not found vaultwarden sqlite database, skipping"
    fi
}

function backup_rest_of_data() {
    color blue "backup vaultwarden data directory"

    rsync -a --exclude='db.sqlite3*' "${TARGET_DIR}/" "${BACKUP_DIR}/"
}

backup_db_sqlite
backup_rest_of_data