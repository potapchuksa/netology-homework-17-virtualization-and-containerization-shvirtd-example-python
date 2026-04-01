#!/bin/bash
set -e

source /opt/shvirtd-example/.env

mkdir -p /opt/backup

docker run --rm \
  --network shvirtd-example_backend \
  -e MYSQLDUMP_HOST=db_mysql \
  -e MYSQLDUMP_USER=$MYSQL_USER \
  -e MYSQLDUMP_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQLDUMP_DATABASE=$MYSQL_DATABASE \
  schnitzler/mysqldump | gzip > /opt/backup/virtd_$(date +%Y%m%d_%H%M%S).sql.gz

ls -t /opt/backup/*.sql.gz 2>/dev/null | tail -n +11 | xargs -r rm
