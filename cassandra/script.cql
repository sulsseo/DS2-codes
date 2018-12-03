CREATE TYPE IF NOT EXISTS t_name (
    first text,
    last text
);

CREATE TABLE IF NOT EXISTS bike (
    id int PRIMARY KEY ,
    -- tuple pro domovskou stanici stat,mesto,misto
    station tuple<text, text, text>, 
    made tuple<date, text>, -- datum, firma
    size text
);

CREATE TABLE IF NOT EXISTS user ( 
    id int,
    name t_name,
    nick text,
    registration date,
    emails set<text>, 
    phones map<text, int>,
    category text,
    PRIMARY KEY (category, nick)
);

CREATE TABLE IF NOT EXISTS rental (
    id int PRIMARY KEY,
    name text,
    r_date date,
    traces list<frozen<map<text, int>>>,
    id_user int,
    id_bike int,
);

// ------------ insert dat o uzivatelich ---------------------------------------
INSERT INTO user (id , nick , name , registration,  emails , phones , category) 
VALUES ( 1, 'josef', {first: 'Josef', last: 'Novak'}, '2017-11-27', {'mail1@mail.cz', 'josef@email.cz'}, {'personal': 123456}, 'VIP');

INSERT INTO user (id , nick , registration,  emails , phones , category) 
VALUES ( 2, 'elephant', '2017-09-02', {'mail2@mail.cz'}, {'personal': 654321} , 'VIP');

INSERT INTO user (id , nick , name , registration,  emails , phones , category) 
VALUES ( 3, 'hippo', {first: 'Ela', last: 'Smith'}, '2017-10-13', {'mail3@mail.cz'}, {'personal': 112233} , 'basic');

INSERT INTO user (id , nick , registration,  emails , phones , category) 
VALUES ( 4, 'alex', '2018-01-15', {'mail4@mail.cz'}, {'work': 445533, 'mobile': 111333} , 'VIP');

INSERT INTO user (id , nick , registration,  emails , phones , category) 
VALUES ( 5, 'ema', '2018-03-01', {'mail5@mail.cz', 'ema@mail.cz'}, {'work': 123456} , 'basic');

// ------------ insert dat o kolech --------------------------------------------
INSERT INTO bike (id , station , made, size) 
VALUES ( 1, ('CZE','Prague','Florenc'), ('2016-02-03','Bike Industry'), 'M');

INSERT INTO bike (id , station , made,  size) 
VALUES ( 2, ('CZE','Brno','Hlavní nádraží'), ('2016-03-04','Bike Industry'), 'L');

INSERT INTO bike (id , station , made,  size) 
VALUES ( 3, ('CZE','Liberec','Homecredit arena'), ('2017-02-12','Kolo.cz'), 'S');

INSERT INTO bike (id , station , made,  size) 
VALUES ( 4, ('CZE','Rumburk','Dymník'), ('2017-04-10','Kolo.cz'), 'M');

INSERT INTO bike (id , station , made,  size) 
VALUES ( 5, ('DEU','Dresden','Bahnhof'), ('2018-02-09','Kolo.cz'), 'L');

-- pro moznost selectu podle 
CREATE INDEX IF NOT EXISTS ON bike (size);

// ------------ insert dat o zapujckach ----------------------------------------
INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (1, 'My ride to office', '2017-12-31', [{'duration':45,'distance':12}], 2, 1);

INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (2, 'My favourite ride', '2017-01-04', [{'duration':34,'distance':4}], 3, 2);

INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (3, 'Funny ride', '2017-02-15', [{'duration':15,'distance':2}], 1, 4);

INSERT INTO rental ( id , r_date , traces , id_user , id_bike )
VALUES (4, '2017-03-29', [{'duration':95,'distance':42}], 2, 3);

INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (5, 'Ride my bike', '2017-03-30', [{'duration':85,'distance':38}], 4, 1);

INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (6, 'Nightrider', '2017-04-01', [{'duration':10,'distance':20}], 2, 3);

INSERT INTO rental ( id , name , r_date , traces , id_user , id_bike )
VALUES (7, 'My ride to office', '2018-12-31', [{'duration':110,'distance':90}], 1, 5);

INSERT INTO rental ( id , r_date , traces , id_user , id_bike )
VALUES (8, '2018-10-11', [{'duration':66,'distance':27}], 4, 2);


// ------------ update dat o uzivatelich ---------------------------------------
-- vyber cele tabulky s uzivateli
SELECT * FROM user;

UPDATE user 
SET 
    emails = emails + {'j.m@gmail.com'},
    phones = phones + {'personal': 111222}
WHERE nick = 'josef' AND category = 'VIP';

UPDATE user 
SET 
    emails = emails - {'mail5@mail.cz'},
    phones = {'work': 111222}
WHERE nick = 'ema' AND category = 'basic';

UPDATE user 
SET 
    name = {first: 'Alex', last: 'Hungry'},
    emails = {'ela.home@mail.cz'},
    phones = phones - {'work'}
WHERE nick = 'alex' AND category = 'VIP';

-- kontrola zmeny dat po updatu
SELECT * FROM user;

UPDATE bike
SET
    station = ('CZE','Prague','Václavské náměstí')
WHERE id = 1;

// ------------ update dat o zapujckach  ---------------------------------------
-- vyber cele tabulky rental
SELECT * FROM rental;

UPDATE rental
SET
    traces = traces + [{'distance':11,'duration':40}]
WHERE id = 1;

UPDATE rental
SET
    traces = traces - [{'distance': 27, 'duration': 66}]
WHERE id = 8;

UPDATE rental
SET
    traces = [{'distance': 27, 'duration': 66}, {'distance':11, 'duration': 37}]
WHERE id = 7;

-- kontrola zmeny dat po updatu
SELECT * FROM rental;

// ------------ select queries -------------------------------------------------
-- výběr všech informaci o VIP uživatelích řazené podle jejich nick name
SELECT * FROM user WHERE category = 'VIP' ORDER BY nick;

-- vypsani zaznamu o posledni pujcce kola
SELECT * FROM rental WHERE id = 8;

-- informace o vsech kolech velikosti M
SELECT * FROM bike WHERE size = 'M';

-- vyber vsech jizd, ktere byli uskutecnene pred dubnem 2017
SELECT * FROM rental WHERE r_date < '2017-04-01' ALLOW FILTERING ;