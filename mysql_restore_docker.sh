#!/bin/bash
 
################################################################
##
##   MySQL Database Restore Script 
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
BACKUP_RETAIN_DAYS=30   ## Number of days to keep local backup copy

CONTAINER='container_name'
RESTORE_FILE=`ls -1t $DB_BACKUP_PATH | head -1`
 
#################################################################

echo "Restore started for database - ${DATABASE_NAME}"

docker exec -i $CONTAINER mysql -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} < $DB_BACKUP_PATH/$RESTORE_FILE
 
if [ $? -eq 0 ]; then
  echo "Database restore successfully completed"
else
  echo "Error found during backup"
  exit 1
fi