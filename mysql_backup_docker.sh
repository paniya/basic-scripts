#!/bin/bash
 
################################################################
##
##   MySQL Database Backup Script 
##   Written By: Praneeth Perera
##   Last Update: Sep 03, 2021
##
################################################################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%Y-%m-%d-%M-%S"`
 
################################################################
################## Update below values  ########################
 
DB_BACKUP_PATH='/backup/dbbackup'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='mysecret'
DATABASE_NAME='mydb'

#################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"

mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} > ${DB_BACKUP_PATH}/${TODAY}/ejs-db-backup-${TODAY}.sql
 
if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
  exit 1
fi
