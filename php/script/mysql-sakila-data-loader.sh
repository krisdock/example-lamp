#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Ensure required environment variables are setup
test -n "${MYSQL_USER}"
test -n "${MYSQL_PASSWORD}"
test -n "${MYSQL_HOST}"

#Add mysql creds to this file
credentialsFile=/mysql-credentials.cnf
cat >$credentialsFile <<EOF
[client]
user=${MYSQL_USER}
password=${MYSQL_PASSWORD}
host=${MYSQL_HOST}
EOF

#initialize DBCOUNT
DBCOUNT=0

#This query does indeed equal 997
#if [ $DBCOUNT = 997 ]; then
#  echo expression evaluated as true
#fi
#Output: expression evaluated as true

#Download the sql files
curl -O https://downloads.mysql.com/docs/sakila-db.tar.gz
  
#unpack
tar -xzf sakila-db.tar.gz

#Does data exist?
#while the answer to my query is not 997, download and restore the data
function check_data() {
  #assign output of this mysql query to DBCOUNT
  #check that the data was imported
  #output is just 997, no warnings
  DBCOUNT=$(mysql --defaults-extra-file=$credentialsFile -NBD sakila -e 'select count(*) from nicer_but_slower_film_list;' || echo 0)

  if [[ "${DBCOUNT}" == "997" ]]; then
    return 0
  else
    return 1
  fi
}

until check_data; do
  #make sure we're using the mysql-credentials.cnf for connections
  credentialsFile=/mysql-credentials.cnf

  #restore the database schema and data
  mysql --defaults-extra-file=$credentialsFile < sakila-db/sakila-schema.sql
  mysql --defaults-extra-file=$credentialsFile < sakila-db/sakila-data.sql
done
