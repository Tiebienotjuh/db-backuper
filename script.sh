#!/bin/sh

# MySQL/MariaDB Backuper (External SFTP)
# By Tiebienotjuh (DirectNode)
# Original script by: Pietro Marangon

# SFTP Information of the other server.
USERNAME="" # EXAMPLE: USERNAME="root"
PASSWORD="" # EXAMPLE: PASSWORD="secretpassword"
SERVER="" # EXAMPLE: SERVER="127.0.0.1"
PORT="" # EXAMPLE: PORT="22"

# Database information of the database and the user of the database. There is no check if its valid. If its invalid the script breaks.
DB_USERNAME="" # EXAMPLE: DB_USERNAME="dbuser"
DB_PASSWORD="" # EXAMPLE: DB_PASSWORD="dbsecretpassword"
DB_NAME="" # EXAMPLE: DB_NAME="database"

#Directory where the sql files wil temporary saved to upload to the other server.
DIR="/root"

#Remote directory where the backup will be placed
REMOTEDIR="./"

# Please do not change the script if you do not know what this means. This is important for correct use of the script
d=$(date --iso)
FILE="$DIR/sqlbackup_"$d".tar.gz"
mysqldump --user=$DB_USERNAME --password=$DB_PASSWORD $DB_NAME > $PATH 

rsync --rsh="sshpass -p $PASSWORD ssh -p $PORT -o StrictHostKeyChecking=no -l $USERNAME" $FILE $SERVER:$REMOTEDIR
echo 'Remote Backup Complete'
rm -f ./$FILE
echo 'Local Backup Removed'
