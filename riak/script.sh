curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name_s": "Favorit", "found_i": 1950 }' http://localhost:10011/buckets/f181_trmaljak_manufacturers/keys/m001

# vkladani dat reprezentujicih kola
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "manufacturer_s": "Favorit", "madeYear_i": 2017, "madeMonth_i": 01, "size_s": "M" }' http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk001
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "manufacturer_s": "Author", "madeYear_i": 2016, "madeMonth_i": 02, "size_s": "L" }' http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk002
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "manufacturer_s": "Specialized", "madeYear_i": 2017, "madeMonth_i": 06, "size_s": "S" }' http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk003
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "manufacturer_s": "KTM", "madeYear_i": 2017, "madeMonth_i": 09, "size_s": "M" }' http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk004
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "manufacturer_s": "Scott", "madeYear_i": 2018, "madeMonth_i": 05, "size_s": "S" }' http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk005

# vkladani dat uzivatelu
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "nickname_s": "elephant", "registration_s": "2017-09-02", "sex_s": "M" }' http://localhost:10011/buckets/f181_trmaljak_users/keys/u001
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "nickname_s": "hippo", "registration_s": "2017-10-13", "sex_s": "F" }' http://localhost:10011/buckets/f181_trmaljak_users/keys/u002
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "nickname_s": "pepa", "registration_s": "2018-01-15", "sex_s": "M" }' http://localhost:10011/buckets/f181_trmaljak_users/keys/u003
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "nickname_s": "ema", "registration_s": "2018-03-01", "sex_s": "F" }' http://localhost:10011/buckets/f181_trmaljak_users/keys/u004
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "nickname_s": "ignac", "registration_s": "2018-05-23", "sex_s": "M" }' http://localhost:10011/buckets/f181_trmaljak_users/keys/u005

# vkladani jednotlivych jizd
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-12-31", "bike_s": "bk001", "user_s": "u002", "duration_i": 45, "distance_i": 12 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r001
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-01-04", "bike_s": "bk002", "user_s": "u003", "duration_i": 34, "distance_i": 4 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r002
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-02-15", "bike_s": "bk004", "user_s": "u001", "duration_i": 15, "distance_i": 2 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r003
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-03-29", "bike_s": "bk003", "user_s": "u005", "duration_i": 95, "distance_i": 42 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-03-30", "bike_s": "bk001", "user_s": "u004", "duration_i": 85, "distance_i": 38 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r005

# zjisteni vsech jizd, ktere mam v databazi zaznamenany
curl -i -X GET http://localhost:10011/buckets/f181_trmaljak_rides/keys?keys=true

# vyhledani klice r005 pro nalezeni informace o jizde
curl -i -X GET http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004

# aktualizace jizdy r004, protoze mela prirazeneho spatneho uzivatele
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "date_s": "2017-03-29", "bike_s": "bk003", "user_s": "u001", "duration_i": 95, "distance_i": 42 }' http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004

# linkovani jednotlivych entit, uzivatelu k jizdam, kol k jizdam a vyrobce ke kolu
curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_manufacturers/keys/m001>; riaktag="tmanufacturer"' \
    -d '{ "manufacturer_s": "Favorit", "madeYear_i": 2017, "madeMonth_i": 01, "size_s": "M" }' \
    http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk001

curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_users/keys/u001>; riaktag="tuser"' \
	-H 'Link: </buckets/f181_trmaljak_bikes/keys/bk004>; riaktag="tbike"' \
	-d '{ "date_s": "2017-12-31", "bike_s": "bk001", "user_s": "u002", "duration_i": 45, "distance_i": 12 }' \
	http://localhost:10011/buckets/f181_trmaljak_rides/keys/r001

curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_users/keys/u001>; riaktag="tuser"' \
	-H 'Link: </buckets/f181_trmaljak_bikes/keys/bk004>; riaktag="tbike"' \
	-d '{ "date_s": "2017-01-04", "bike_s": "bk002", "user_s": "u003", "duration_i": 34, "distance_i": 4 }' \
	http://localhost:10011/buckets/f181_trmaljak_rides/keys/r002

curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_users/keys/u001>; riaktag="tuser"' \
	-H 'Link: </buckets/f181_trmaljak_bikes/keys/bk004>; riaktag="tbike"' \
	-d '{ "date_s": "2017-02-15", "bike_s": "bk004", "user_s": "u001", "duration_i": 15, "distance_i": 2 }' \
	http://localhost:10011/buckets/f181_trmaljak_rides/keys/r003

curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_users/keys/u001>; riaktag="tuser"' \
	-H 'Link: </buckets/f181_trmaljak_bikes/keys/bk003>; riaktag="tbike"' \
	-d '{ "date_s": "2017-03-29", "bike_s": "bk003", "user_s": "u001", "duration_i": 95, "distance_i": 42 }' \
	http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004

curl -i -X PUT -H 'Content-Type: application/json' \
	-H 'Link: </buckets/f181_trmaljak_users/keys/u004>; riaktag="tuser"' \
	-H 'Link: </buckets/f181_trmaljak_bikes/keys/bk001>; riaktag="tbike"' \
	-d '{ "date_s": "2017-03-30", "bike_s": "bk001", "user_s": "u004", "duration_i": 85, "distance_i": 38 }' \
	http://localhost:10011/buckets/f181_trmaljak_rides/keys/r005


# zjisteni uzivatele, ze ctvrte jizdy, ktera je v systemu zaznamenana
curl -i -X GET \
 http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004/f181_trmaljak_users,tuser,1

# zjisteni informaci o vyrobce kola, ktere bylo pouzito pri pate jizde
curl -i -X GET \
  http://localhost:10011/buckets/f181_trmaljak_rides/keys/r005/f181_trmaljak_bikes,tbike,0/f181_trmaljak_manufacturers,tmanufacturer,1

# odstraneni vsech pracovnich dat
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_manufacturers/keys/m001

curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk001
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk002
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk003
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk004
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_bikes/keys/bk005

curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_users/keys/u001
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_users/keys/u002
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_users/keys/u003
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_users/keys/u004
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_users/keys/u005

curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_rides/keys/r001
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_rides/keys/r002
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_rides/keys/r003
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_rides/keys/r004
curl -i -X DELETE http://localhost:10011/buckets/f181_trmaljak_rides/keys/r005

# zjisteni zda je bucket rides vyprazdnen
curl -i -X GET http://localhost:10011/buckets/f181_trmaljak_rides/keys?keys=true