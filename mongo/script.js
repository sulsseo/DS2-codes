// -----------------------------------------------------------------------------
db.createCollection("bike");
db.bike.insert({
    _id: 1, manufacturer: "Favorit",
    station: ["CZE", "Prague", "Florenc"],
    made: { date: "2016-02-03", factory: "Bike Industry" },
    size: "M",
    gender: "F"
});
db.bike.insert({
    _id: 2, manufacturer: "Author",
    station: ["CZE", "Brno", "Hlavní nádraží"],
    made: { date: "2016-03-04", factory: "Bike Industry" },
    size: "M",
    gender: "F"
});
db.bike.insert({
    _id: 3, manufacturer: "Author",
    station: ["CZE", "Liberec", "Homecredit aréna"],
    made: { date: "2017-02-12", factory: "Kolo.cz" },
    size: "S",
    gender: "M"
});
db.bike.insert({
    _id: 4, manufacturer: "Favorit",
    station: ["CZE", "Rumburk", "Dymník"],
    made: { date: "2017-04-10", factory: "Kolo.cz" },
    size: "M",
    gender: "M"
});
db.bike.insert({
    _id: 5, manufacturer: "Specialized",
    station: ["DEU", "Dresden", "Bahnhof"],
    made: { date: "2018-02-09", factory: "Bike Industry" },
    size: "L",
    gender: "M"
});

// -----------------------------------------------------------------------------
db.createCollection("user");
db.user.insert({
    _id: 1, nickname: "elephant", registration: "2017-11-27", sex: "M",
    contact: { emails: ["mail1@mail.cz"], phones: [123456] }
});
db.user.insert({
    _id: 2, nickname: "hippo", registration: "2017-09-02", sex: "F",
    contact: { emails: ["mail2@mail.cz"], phones: [654321] }
});
db.user.insert({
    _id: 3, nickname: "pepa", registration: "2017-10-13", sex: "M",
    contact: { emails: ["josef@email.cz"], phones: [112233] }
});
db.user.insert({
    _id: 4, nickname: "ema", registration: "2018-01-15", sex: "F",
    contact: { emails: ["mail4@mail.cz"], phones: [111333] }
});
db.user.insert({
    _id: 5, nickname: "alex", registration: "2018-03-01", sex: "F",
    contact: { emails: ["mail5@mail.cz"], phones: [123456] }
});

// -----------------------------------------------------------------------------
db.createCollection("rental");
db.rental.save({
    _id: 1, date: "2016-12-31", bike_id: 1, user_id: 2,
    traces: [
        { name: "My ride to office", duration: 45, distance: 12 }
    ]
});
db.rental.save({
    _id: 2, date: "2017-01-04", bike_id: 2, user_id: 3,
    traces: [
        { name: "My favourite ride", duration: 34, distance: 4 }
    ]
});
db.rental.save({
    _id: 3, date: "2017-02-15", bike_id: 4, user_id: 1,
    traces: [
        { name: "Funny ride", duration: 15, distance: 2 }
    ]
});
db.rental.save({
    _id: 4, date: "2017-03-29", bike_id: 2, user_id: 3,
    traces: [
        { name: "My favourite ride 2", duration: 72, distance: 30 }
    ]
});
db.rental.save({
    _id: 5, date: "2017-03-30", bike_id: 1, user_id: 4,
    traces: [
        { name: "Ride my bike", duration: 95, distance: 42 }
    ]
});

// -----------------------------------------------------------------------------
// bud jde update nahradit objekt objektem
// nebo update operatory $set, $push (do pole)

// upsert mode - pokud pri update nenajde polozku, tak ji vlozi

// najdi uzivatele cislo 3 a nahrad vsechny jeho data timto objektem
db.user.update({ _id: 3 }, {
    nickname: "josef", registration: "2017-10-13", sex: "M",
    contact: { emails: ["josef.vomacka@email.cz"], phones: [112233] }
});

// upravi existujiciho uzivatele modifikaci jeho soucasnych dat
db.user.update({ _id: 2 }, {
    $set: { nickname: "hipponie" },
    $push: { "contact.emails": { $each: ["hippo@mail.cz"] } }
});

// najde pujcku kola podle datumu, pokud nenajde, tak vytvori zaznam
db.rental.update(
    { date: "2017-04-01" },
    {
        _id: 6, date: "2017-04-01", bike_id: 3, user_id: 1,
        traces: [
            { name: "Test ride", duration: 12, distance: 20 }
        ]
    },
    { upsert: true }
);

// prida telefon k uzivateli s nickem "ema"
db.user.update(
    { nickname: "ema" },
    {
        $push: { "contact.phones": { $each: [3322110] } }
    }
);

db.rental.update(
    { date: "2017-01-04" },
    {
        $push: { traces: { name: "My favourite", duration: 23, distance: 6 } }
    }
);

// -----------------------------------------------------------------------------
// vylistuje kontakty na uzivatele, kteri se registrovali v roce 2018
print("kontakty na uzivatele, kteri se registrovali v roce 2018")
db.user.find({ registration: { $gte: "2018-01-01" } }, { _id: 0, contact: 1 }).forEach(printjson);

// zobrazi statisticke informace o jizdach, kdy si uzivatel id 3 pujcil kolo id 2
// z vyctu dat odstrani user_id, bike_id a nazvy tras
print("statisticke informace o jizdach, kdy si uzivatel id 3 pujcil kolo id 2")
db.rental.find({ $or: [{ bike_id: 2 }, { user_id: 3 }] }, { bike_id: 0, user_id: 0, "traces.name": 0 }).forEach(printjson);

// vylistuje vsechny uzivatele serazene vzestupne podle nickname
// do vyctu se nezahrnuje id
print("vsichni uzivatele razeni vzestupne podle nickname")
db.user.find({}, { _id: 0 }).sort({ nickname: 1 }).forEach(printjson);

// vylistuje vsechna kola, ktera se nachazi v ceske republice
print("vsechna kola, ktera se nachazi v ceske republice")
db.bike.find({ station: { $elemMatch: { $eq: "CZE" } } }).forEach(printjson);

// zobrazi vsechny pujcky, ktere obsahuji alespon jednu jizdu, ktera je kratsi nebo rovna 15 minutam
print("vsechny pujcky, ktere obsahuji alespon jednu jizdu, ktera je kratsi nebo rovna 15 minutam")
db.rental.find({ "traces.duration": { $lte: 15 } }).forEach(printjson);

// -----------------------------------------------------------------------------

// ze vsech pujcek emituje kola a delku jejich zapujceni
// vysledkem je celkova doba zapujceni pro kazde kolo
print("mapreduce job")
db.rental.mapReduce(
    function() {
        var bike = this.bike_id
        if (this.traces) {
            this.traces.forEach(
                function(t) { emit(bike, t.duration); }
            );
        }
    },
    function(key, values) {
        return Array.sum(values);
    },
    {   
        out: { inline: 1 } 
    }
);

// -----------------------------------------------------------------------------

db.bike.drop();
db.user.drop();
db.rental.drop();