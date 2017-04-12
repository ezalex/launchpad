#!/usr/bin/env bash

cd /var/www/html/project
mkdir -p data

 DUMP_DIR="$(pwd)/data"
if [ "$1" != "" ] && [ -d "$1" ]; then
    if [[ "$1" =~ ^/ ]]; then
        DUMP_DIR="$1"
    fi
fi

DB_FILE_NAME="$DATABASE_NAME"
STORAGE_FILE_NAME="storage"

if [ "$2" != "" ]; then
    DB_FILE_NAME="$2"
    STORAGE_FILE_NAME="$2_storage"
fi

MYSQLDUMP="mysqldump -h$DATABASE_HOST -u$DATABASE_USER -p$DATABASE_PASSWORD"

$MYSQLDUMP $DATABASE_NAME > $DUMP_DIR/$DB_FILE_NAME.sql
gzip -f $DUMP_DIR/$DB_FILE_NAME.sql

cd /var/www/html/project/ezplatform/web
tar czvf $DUMP_DIR/$STORAGE_FILE_NAME.tar.gz var/
cd -
