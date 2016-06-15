#!/bin/bash -x

# Copyright 2016 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# start the backup job
#
# the service looks for the following env vars to be set by
# the cpm-admin that provisioned us
#
# /pgdata is a volume that gets mapped into this container
# $BACKUP_HOST host we are connecting to
# $BACKUP_USER pg user we are connecting with
# $BACKUP_PASS pg user password we are connecting with
# $BACKUP_PORT pg port we are connecting to
#

env

BACKUPBASE=/pgdata/$BACKUP_HOST
if [ ! -d "$BACKUPBASE" ]; then
	echo "creating BACKUPBASE directory..."
	mkdir -p $BACKUPBASE
fi

TS=`date +%Y-%m-%d-%H-%M-%S`
BACKUP_PATH=$BACKUPBASE/$TS
mkdir $BACKUP_PATH


export PGPASSFILE=/tmp/pgpass

echo "*:*:*:"$BACKUP_USER":"$BACKUP_PASS  >> $PGPASSFILE

chmod 600 $PGPASSFILE

chown $UID:$UID $PGPASSFILE

cat $PGPASSFILE

pg_basebackup --xlog --pgdata $BACKUP_PATH --host=$BACKUP_HOST --port=$BACKUP_PORT -U $BACKUP_USER

chown -R $UID:$UID $BACKUP_PATH

echo "backup has ended!"
