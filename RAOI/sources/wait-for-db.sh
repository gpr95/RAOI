#!/usr/bin/env bash
set -e


curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-tools.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install mssql-tools
sudo apt-get install unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

HOST=127.0.0.1
PORT=1401
USER=sa
PASSWORD=Microsoft2017
DATABASE=SampleDB

displayUsage() {
    echo "Usage:"
    echo "$0                    -- T-sql command line"
    echo "$0 "query"              -- Query to be run on DB"
    echo "$0 datebase file.sql  -- File to be run on DB"
    exit 0
}

if [ $# -eq 0 ]; then
    OPTS=""
elif [ $# -eq 1 ]; then
    if [[ $1 = *".sql"* ]] && [ -n $DATABASE ]; then
        OPTS="-d $DATABASE -i ./$1"
    else
        BASEOPTS="-Q $1"
    fi
elif [ $# -eq 2 ]; then
    if [[ $2 = *".sql"* ]]; then
        OPTS="-d $1 -i ./$2"
    else
        displayUsage
    fi
else
    displayUsage
fi
sqlcmd -S $HOST\\SQLEXPRESS,$PORT -U $USER -P $PASSWORD $OPTS


host="$1"
shift
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd

