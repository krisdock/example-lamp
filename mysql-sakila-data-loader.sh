#!/bin/bash

#Add mysql creds to this file
credentialsFile=/mysql-credentials.cnf
echo "[client]" > $credentialsFile
echo "user=root" >> $credentialsFile
echo "password=starbuck" >> $credentialsFile
echo "host=localhost" >> $credentialsFile

#install curl
apt-get -qq update
apt-get -y install curl

#initialize DBCOUNT
DBCOUNT=0

#This query does indeed equal 997
#if [ $DBCOUNT = 997 ]; then
#  echo expression evaluated as true
#fi
#Output: expression evaluated as true

#Does data exist?
#while the answer to my query is not 997, download and restore the data
while [ "$DBCOUNT" != "997" ]
do
  #Download the sql files
  curl -O https://downloads.mysql.com/docs/sakila-db.tar.gz
  
  #unpack
  tar -xzf sakila-db.tar.gz

  #make sure we're using the mysql-credentials.cnf for connections
  credentialsFile=/mysql-credentials.cnf

  #restore the database schema and data
  mysql --defaults-extra-file=$credentialsFile < sakila-db/sakila-schema.sql
  mysql --defaults-extra-file=$credentialsFile < sakila-db/sakila-data.sql
  #assign output of this mysql query to DBCOUNT
  #check that the data was imported
  #output is just 997, no warnings
  DBCOUNT="$(mysql --defaults-extra-file=$credentialsFile -NBD sakila -e 'select count(*) from nicer_but_slower_film_list;')"
done


#TODO: Create and use a nonroot user and password
