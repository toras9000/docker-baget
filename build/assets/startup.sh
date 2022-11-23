#!/bin/bash

set -eu

IMPORT_SETTINGS_FILE=/app/config/appsettings.json
APP_SETTINGS_FILE=/app/BaGet/appsettings.json

# If already exist import file, it is considered to have been initialized.
if [ -f "$IMPORT_SETTINGS_FILE" ]; then
    # Copy from import location to app settings file.
    cp -f "$IMPORT_SETTINGS_FILE" "$APP_SETTINGS_FILE"
    chmod +r "$APP_SETTINGS_FILE"
else
    # update config from variable
    if [ -n "${INIT_DB_TYPE:-}" ]; then
        dotnet /app/tool/json_updater.dll "$APP_SETTINGS_FILE" "$.Database.Type"              "$INIT_DB_TYPE"
    fi
    if [ -n "${INIT_DB_CONN_STR:-}" ]; then
        dotnet /app/tool/json_updater.dll "$APP_SETTINGS_FILE" "$.Database.ConnectionString"  "$INIT_DB_CONN_STR"
    fi

    # Copy the application setting file and initialize it as an import file. 
    cp "$APP_SETTINGS_FILE" "$IMPORT_SETTINGS_FILE"
fi

cd /app/BaGet
exec dotnet BaGet.dll
