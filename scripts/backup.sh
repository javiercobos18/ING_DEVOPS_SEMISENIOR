#!/bin/bash
# Script de respaldo de base de datos
set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="backup_$TIMESTAMP.sql"

echo "Generando respaldo en $BACKUP_FILE..."
pg_dump $DB_NAME > /backups/$BACKUP_FILE
echo "Respaldo completado."
