#!/bin/bash

DOCKER_CONTAINER=$1
MYSQL_DB=$2
MYSQL_USER=$3
MYSQL_PWD=$4
JAVERS_DATE_DELETE_FROM=$5

if [ -z $DOCKER_CONTAINER ] || [ -z $MYSQL_DB ] || [ -z $MYSQL_USER ] || [ -z $MYSQL_PWD ] || [ -z $JAVERS_DATE_DELETE_FROM ]; then 
  echo "./runJaversCleanup.sh [docker_container] [db] [mysql_user] [mysql_pwd] [javers_date_delete_from] are required parameters"
  exit -1
fi

sed -i '.bak' -e "s/date_delete_from/$JAVERS_DATE_DELETE_FROM/g" cleanup-javers.sql
docker cp cleanup-javers.sql $DOCKER_CONTAINER:/cleanup-javers.sql
docker exec -i $DOCKER_CONTAINER sh -c "mysql -u ${MYSQL_USER} -p${MYSQL_PWD} ${MYSQL_DB} < /cleanup-javers.sql"
docker exec -i $DOCKER_CONTAINER rm -f /cleanup-javers.sql
sed -i '.bak' -e "s/$JAVERS_DATE_DELETE_FROM/date_delete_from/g" cleanup-javers.sql
