#!/bin/bash
# Create a CSV of mapgame results
echo "distance,lat,lon" > results.tmp
> results.csv
ID=27
while [ "$1" != "" ]; do
    case $1 in
        -i | --id ) shift
            ID=$1
            ;;
    esac
    shift
done
SQL="SELECT CONCAT(guess, ',', lat, ',', lon) FROM mapgame_guesses WHERE games_id = $ID;"
echo $SQL > results.sql
mysql mapgame -u root -p < results.sql >> results.tmp
sed '2d' results.tmp >> results.csv
echo 'http://denverpostplus.com/app/mapgame/www/results.csv'
