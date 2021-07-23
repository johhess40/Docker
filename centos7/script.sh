#!/bin/bash

DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
DATE=$(date +%H-%M-%S)
STORAGE_ACCNT=$4
STORAGE_KEY=$5
STORAGE_CONTAINER=$6
STORAGE_BLOB=$7
mysqldump -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/db-$DATE.sql


echo "Uploading db backup to blob....this may take a second..."

export AZURE_STORAGE_KEY=$STORAGE_KEY

az storage blob upload --account-name $STORAGE_ACCNT --account-key $AZURE_STORAGE_KEY --container $STORAGE_CONTAINER --file /tmp/db-$DATE.sql --name $STORAGE_BLOB