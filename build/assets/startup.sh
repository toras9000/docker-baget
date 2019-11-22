#!/bin/bash

IMPORT_SETTINGS_FILE=/app/config/appsettings.json
APP_SETTINGS_FILE=/app/appsettings.json

if [ -f "$IMPORT_SETTINGS_FILE" ]; then
    cp -f "$IMPORT_SETTINGS_FILE" "$APP_SETTINGS_FILE"
    chmod +r "$APP_SETTINGS_FILE"
else
    IMPORT_SETTINGS_DIR=$(dirname "$IMPORT_SETTINGS_FILE")
    if [ -d "$IMPORT_SETTINGS_DIR" ]; then
        cp "$APP_SETTINGS_FILE" "$IMPORT_SETTINGS_FILE"
    fi
fi

exec dotnet /app/BaGet.dll
